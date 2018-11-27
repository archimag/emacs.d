(add-to-list 'load-path "~/development/common-lisp/slime")
(autoload 'slime-highlight-edits-mode "slime-highlight-edits" nil t)
(require 'slime-autoloads)
(slime-setup '(slime-fancy slime-asdf slime-banner))
;;(slime-setup '(slime-fancy slime-asdf slime-banner slime-repl-ansi-color))
(setq inferior-lisp-program "/usr/bin/sbcl")

(global-set-key "\C-cs" 'slime-selector)
(setq slime-enable-evaluate-in-emacs t)


(defmacro define-slime-lisp (lisp path &optional coding)
 (let ((funname (intern (format "%s-slime" lisp))))
   `(defun ,funname ()
      (interactive)
      (let ((inferior-lisp-program ,path)
            (slime-net-coding-system (or ,coding 'utf-8-unix)))
        (slime)))))


(define-slime-lisp sbcl "/usr/bin/sbcl")
;; (define-slime-lisp clisp "/usr/bin/clisp")
;; (define-slime-lisp clozure "/usr/bin/ccl -K utf8")
;; (define-slime-lisp cmucl "/usr/bin/lisp")

(setq common-lisp-hyperspec-root
	  "file:///usr/share/doc/hyperspec/HyperSpec/")


(defun hyperspec-lookup (&optional symbol-name)
  (interactive)
  (let ((browse-url-browser-function 'w3m-browse-url))
    (if symbol-name
        (common-lisp-hyperspec symbol-name)
      (call-interactively 'common-lisp-hyperspec))))

;; (global-set-key "\C-c\C-d\C-e" 'hyperspec-lookup)

;;;; restas

;;(require 'restas)
;;(require 'closure-template-html-mode)
