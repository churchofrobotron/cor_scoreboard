std::vector<std::string> SplitString(const std::string &s, char delim) {
  std::vector<std::string> v;
  size_t i = 0;
  auto pos = s.find(delim);
  while (pos != std::string::npos) {
    v.push_back(s.substr(i, pos - i));
    i = pos + 1;
    pos = s.find(delim, pos + 1);
  }

  if (i <= s.size()) {
    v.push_back(s.substr(i));
  }

  return v;
}
