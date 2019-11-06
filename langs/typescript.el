(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(require 'mocha)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  )

(defun mocha-test-at-point2 ()
  "Test the current innermost 'it' or 'describe' or the file if none is found."
  (interactive)
  (let ((file (buffer-file-name))
        (test-at-point (progn
                         (save-excursion
                           (re-search-backward "it(\'\\([^\'\"]+\\)\'"))
                         (match-string 1))))
    (mocha-run file test-at-point)))


(defun setup-typescript-mode ()
  (interactive)
  ;; tide
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company
  (company-mode +1)
  (local-set-key (kbd "M-?") #'company-complete)
  ;; mocha
  (local-set-key (kbd "C-c C-i") #'mocha-test-at-point2)
  (local-set-key (kbd "C-c C-l") #'mocha-test-file)
  (make-local-variable 'mocha-command)
  (setq-local mocha-command "node_modules/.bin/ts-mocha --paths"))

(add-hook 'typescript-mode-hook 'setup-typescript-mode)

(require 'prettier-js)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
