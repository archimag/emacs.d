;; bindings.el

(when (fboundp 'pc-selection-mode)
  (pc-selection-mode))

(when (fboundp 'delete-selection-mode)
  (delete-selection-mode))

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "\C-c\C-g") 'goto-line)

(global-set-key "\C-cC" 'comment-region)
(global-set-key "\C-cU" 'uncomment-region)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; flymake
(require 'flymake)
(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)

;; eglot
(require 'eglot)
(define-key eglot-mode-map (kbd "C-c C-c r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c C-c h") 'eldoc)
(define-key eglot-mode-map (kbd "M-?") 'xref-find-references)
(define-key eglot-mode-map (kbd "M-<tab>") 'company-complete)
