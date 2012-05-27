;; bindings.el

(pc-selection-mode)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "\C-c\C-g") 'goto-line)

(global-set-key "\C-cC" 'comment-region)
(global-set-key "\C-cU" 'uncomment-region)
