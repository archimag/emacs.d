;;; package --- Summary
;;; Commentary:

;;; Code:

(require 'gradle-mode)
(gradle-mode 1)
(setf gradle-use-gradlew t)
(setf gradle-gradlew-executable "./gradlew")

(eval-after-load 'flycheck
  (lambda ()
    (require 'flycheck-kotlin)
    (flycheck-kotlin-setup)))

(require 'lsp-mode)

(defun is-gradle-project-dir (dir)
  "Check if DIR is contained build.gradle."
  (file-exists-p (expand-file-name "build.gradle" dir)))

(defun find-gradle-root-dir (&optional dir)
  "Find proejct top directory base on current DIR."
  (let ((root (locate-dominating-file (or dir default-directory) 'is-gradle-project-dir)))
    (if root
        (or (find-gradle-root-dir (file-name-directory (directory-file-name root)))
            root))))

(lsp-define-stdio-client lsp-kotlin-mode
 "kotlin"
 #'find-gradle-root-dir
  '("kotlin-language-server"))

(add-hook 'kotlin-mode-hook
          (lambda ()
            (flycheck-mode t)
            (lsp-kotlin-mode-enable)))


;;; kotlin.el ends here
