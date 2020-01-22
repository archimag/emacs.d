(use-package toml-mode)

(use-package rust-mode
  :hook (rust-mode . racer-mode))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(setq rust-format-on-save t)
