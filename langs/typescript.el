(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(setq typescript-indent-level 2)

(require 'typescript-mode)
(require 'mocha)

(defun mocha-test-at-point2 ()
  "Test the current innermost 'it' or 'describe' or the file if none is found."
  (interactive)
  (let ((file (buffer-file-name))
        (test-at-point (progn
                         (save-excursion
                           (re-search-backward "^[[:space:]]*it(\'\\([^\'\"]+\\)\'"))
                         (match-string 1))))
    (mocha-run file test-at-point)))


(defun setup-typescript-mode ()
  (interactive)
  ;; tide
  ;;(tide-setup)
  ;;(tide-hl-identifier-mode +1)

  ;; eglot
  (eglot-ensure)

  ;; prettier
  (prettier-mode t)

  ;; tree-setter
  (tree-sitter-hl-mode)
  ;; company
  (company-mode +1)
  ;; mocha
  (local-set-key (kbd "C-c C-i") #'mocha-test-at-point2)
  (local-set-key (kbd "C-c C-l") #'mocha-test-file)
  (make-local-variable 'mocha-command)
  (setq-local mocha-command "node_modules/.bin/ts-mocha --paths"))

(add-hook 'typescript-mode-hook 'setup-typescript-mode)
(add-hook 'tsx-ts-mode-hook #'setup-typescript-mode)
(add-hook 'typescript-mode-hook '(lambda () (prettier-mode t)))


