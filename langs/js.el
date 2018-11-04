;;; package --- Summary
;;; Commentary:

;;; Code:



(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;; flycheck

(require 'flycheck)

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;;; hooks

(add-hook 'js2-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-i") #'mocha-test-at-point)
            (local-set-key (kbd "C-c C-l") #'mocha-test-file)
            (flycheck-mode t)))


(add-hook 'rjsx-mode-hook
          (lambda ()
            (flycheck-mode t)))

;;; prettier

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)



;;; local.el ends here
