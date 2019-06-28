(defun my-vc-dir-delete-marked-files ()
  "Delete all marked files in a `vc-dir' buffer."
  (interactive)
  (let ((files (vc-dir-marked-files)))
    (if (not files)
        (message "No marked files.")
      (when (yes-or-no-p (format "%s %d marked file(s)? "
                                 (if delete-by-moving-to-trash "Trash" "Delete")
                                 (length files)))
        (unwind-protect
            (mapcar
             (lambda (path)
               (if (and (file-directory-p path)
                        (not (file-symlink-p path)))
                   (when (or (not (directory-files
                                   path nil directory-files-no-dot-files-regexp))
                             (y-or-n-p
                              (format "Directory `%s' is not empty, really %s? "
                                      path (if delete-by-moving-to-trash
                                               "trash" "delete"))))
                     (delete-directory path t t))
                 (delete-file path t)))
             files)
          (revert-buffer))))))
