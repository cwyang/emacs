(unless (package-installed-p 'dart-mode)
  (package-refresh-contents)
  (package-install 'dart-mode))
