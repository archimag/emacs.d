;;; package --- Summary
;;; Commentary:

;;; Code:

(require 'gradle-mode)
(setf gradle-use-gradlew t)
(setf gradle-gradlew-executable "./gradlew")

(eval-after-load 'flycheck
  (lambda ()
    (require 'flycheck-kotlin)
    (flycheck-kotlin-setup)))

(add-to-list 'compilation-error-regexp-alist 'gradlew-error)
(add-to-list 'compilation-error-regexp-alist 'gradlew-warn)
(add-to-list 'compilation-error-regexp-alist-alist
             '(gradlew-error "^e: \\(.+?\\): (\\([0-9]+\\), \\([0-9]+\\)):.*" 1 2 3))
(add-to-list 'compilation-error-regexp-alist-alist
             '(gradlew-warn "^w: \\(.+?\\): (\\([0-9]+\\), \\([0-9]+\\)):.*" 1 2 3 1))

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

(defun gradle-test-file ()
  (interactive)
  (gradle-single-test--daemon (file-name-base buffer-file-name)))

(setf last-gradle-test-name "")

(defun gradle-test-class (test-name)
  (interactive
   (list (read-string "Gradle test class: " last-gradle-test-name nil "")))
  (setf last-gradle-test-name test-name)
  ;; (gradle-single-test--daemon test-name)
  (gradle-execute--daemon (format "test --tests %s"  test-name)))

(setf last-compile-kotlin-prefix "")

(defun gradle-compile-kotlin (prefix)
  (interactive
   (list (read-string "Gradle :compileKotlin prefix: " last-compile-kotlin-prefix nil "")))
  (setf last-compile-kotlin-prefix prefix)
  (gradle-execute--daemon (format "%s:compileKotlin" prefix)))

(add-hook 'kotlin-mode-hook
          (lambda ()
            (flycheck-mode t)
            (lsp-kotlin-mode-enable)))

(eval-after-load 'kotlin-mode
  (lambda ()
    (define-key kotlin-mode-map [?\C-c ?\C-l] #'gradle-test-file)
    (define-key kotlin-mode-map [?\C-c ?\C-i] #'gradle-test-class)
    (define-key kotlin-mode-map [?\C-c ?\C-q] #'gradle-compile-kotlin)))

;;; kotlin.el ends here
