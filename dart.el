(unless (package-installed-p 'dart-mode)
  (pacage-refresh-contents)
  (package-install 'dart-mode))
