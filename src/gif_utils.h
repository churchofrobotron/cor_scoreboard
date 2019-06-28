typedef struct GifInfo {
  int width;
  int height;
  int frames;
  int curr;
  void *buffer;
  void *pict;
  void *prev;
  unsigned long last;
} GifInfo;

void frame(void *data, struct GIF_WHDR *whdr) {
  GifInfo *info = (GifInfo *)data;
  uint32_t *pict, *prev, x, y, yoff, iter, ifin, dsrc, ddst;
#define BGRA(i)                                                                \
  ((whdr->bptr[i] == whdr->tran)                                               \
       ? 0                                                                     \
       : ((uint32_t)(whdr->cpal[whdr->bptr[i]].R << ((GIF_BIGE) ? 8 : 16)) |   \
          (uint32_t)(whdr->cpal[whdr->bptr[i]].G << ((GIF_BIGE) ? 16 : 8)) |   \
          (uint32_t)(whdr->cpal[whdr->bptr[i]].B << ((GIF_BIGE) ? 24 : 0)) |   \
          ((GIF_BIGE) ? 0xFF : 0xFF000000)))
  if (!whdr->ifrm) {
    info->width = whdr->xdim;
    info->height = whdr->ydim;
    info->frames = whdr->nfrm;
    info->buffer =
        realloc(info->buffer, info->width * info->height * 4 * info->frames);
    info->pict = malloc(info->width * info->height * 4);
    info->prev = malloc(info->width * info->height * 4);
    info->curr = 0;
  }
  pict = (uint32_t *)info->pict;
  ddst = (uint32_t)(whdr->xdim * whdr->fryo + whdr->frxo);
  ifin = (!(iter = (whdr->intr) ? 0 : 4)) ? 4 : 5; /** interlacing support **/
  for (dsrc = (uint32_t)-1; iter < ifin; iter++)
    for (yoff = 16U >> ((iter > 1) ? iter : 1), y = (8 >> iter) & 7;
         y < (uint32_t)whdr->fryd; y += yoff)
      for (x = 0; x < (uint32_t)whdr->frxd; x++)
        if (whdr->tran != (long)whdr->bptr[++dsrc])
          pict[(uint32_t)whdr->xdim * y + x + ddst] = BGRA(dsrc);
  memcpy((char *)info->buffer + info->width * info->height * 4 * info->curr,
         pict, info->width * info->height * 4);
  info->curr++;
  if ((whdr->mode == GIF_PREV) && !info->last) {
    whdr->frxd = whdr->xdim;
    whdr->fryd = whdr->ydim;
    whdr->mode = GIF_BKGD;
    ddst = 0;
  } else {
    info->last =
        (whdr->mode == GIF_PREV) ? info->last : (unsigned long)(whdr->ifrm + 1);
    pict = (uint32_t *)((whdr->mode == GIF_PREV) ? info->pict : info->prev);
    prev = (uint32_t *)((whdr->mode == GIF_PREV) ? info->prev : info->pict);
    for (x = (uint32_t)(whdr->xdim * whdr->ydim); --x;
         pict[x - 1] = prev[x - 1])
      ;
  }
  if (whdr->mode == GIF_BKGD) /** cutting a hole for the next frame **/
    for (whdr->bptr[0] = (uint8_t)((whdr->tran >= 0) ? whdr->tran : whdr->bkgd),
        y = 0, pict = (uint32_t *)info->pict;
         y < (uint32_t)whdr->fryd; y++)
      for (x = 0; x < (uint32_t)whdr->frxd; x++)
        pict[(uint32_t)whdr->xdim * y + x + ddst] = BGRA(0);
#undef BGRA
}

static void imageReleaseCb(void *_ptr, void *_userData) {
  BX_UNUSED(_ptr);
  free(_userData);
}

bgfx::TextureHandle loadGif(const std::string &f, int *num_frames) {
  bx::FileReader fr;
  bx::Error error;
  fr.open(f.c_str(), &error);
  int64_t sz = bx::getSize(&fr);
  void *data = malloc(sz);
  bx::read(&fr, data, sz, &error);
  GifInfo gi;
  gi.buffer = malloc(100);
  gi.frames = 0;
  gi.last = 0;
  GIF_Load(data, sz, frame, 0, &gi, 0L);
  free(data);

  // Downsize by 2x so we fit into raspi mem
  int downsized_sz = (gi.width / 2) * ((gi.height * gi.frames) / 2) * 4;
  uint8_t* downsized = (uint8_t*) malloc(downsized_sz);
  uint8_t* src = (uint8_t*) gi.buffer;
  for (int y = 0; y < gi.height * gi.frames; y += 2) {
    int destYOffset = (y / 2) * (gi.width / 2) * 4;
    int sourceYOffset = y * gi.width * 4;
    for (int x = 0; x < gi.width; x += 2) {
      int destXOffset = (x / 2) * 4;
      int sourceXOffset = x * 4;
      downsized[destYOffset + destXOffset] = src[sourceYOffset + sourceXOffset];
      downsized[destYOffset + destXOffset + 0] = src[sourceYOffset + sourceXOffset + 0];
      downsized[destYOffset + destXOffset + 1] = src[sourceYOffset + sourceXOffset + 1];
      downsized[destYOffset + destXOffset + 2] = src[sourceYOffset + sourceXOffset + 2];
    }
  }
  free(gi.buffer);
  free(gi.pict);
  free(gi.prev);

  const bgfx::Memory *mem =
      bgfx::makeRef(downsized, downsized_sz,
                    imageReleaseCb, downsized);
  *num_frames = gi.frames;
  return bgfx::createTexture2D(gi.width / 2, gi.height * gi.frames / 2, false, 1,
                               bgfx::TextureFormat::BGRA8, 0, mem);
}
