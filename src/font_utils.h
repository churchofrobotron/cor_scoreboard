TrueTypeHandle loadTtf(FontManager *_fm, const char *_filePath) {
  uint32_t size;
  void *data = load(_filePath, &size);

  if (NULL != data) {
    TrueTypeHandle handle = _fm->createTtf((uint8_t *)data, size);
    BX_FREE(entry::getAllocator(), data);
    return handle;
  }

  TrueTypeHandle invalid = BGFX_INVALID_HANDLE;
  return invalid;
}
