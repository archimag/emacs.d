;;; package --- Summary
;;; Commentary:

;;; Code:

(require 'gradle-mode)
(gradle-mode 1)
(setf gradle-use-gradlew t)
(setf gradle-gradlew-executable "./gradlew")

(add-to-list 'compilation-error-regexp-alist 'gradlew-error)
(add-to-list 'compilation-error-regexp-alist 'gradlew-warn)
(add-to-list 'compilation-error-regexp-alist-alist
             '(gradlew-error "^e: \\(.+?\\): (\\([0-9]+\\), \\([0-9]+\\)):.*" 1 2 3))
(add-to-list 'compilation-error-regexp-alist-alist
             '(gradlew-warn "^w: \\(.+?\\): (\\([0-9]+\\), \\([0-9]+\\)):.*" 1 2 3 1))

(eval-after-load 'flycheck
  (lambda ()
    (require 'flycheck-kotlin)
    (flycheck-kotlin-setup)))

;;; kotlin.el ends here
