(require 'org)

n(defvar my-gtd-dir "~/gtd/")

(defun my-gtd-file (name)
  (format "%s%s" my-gtd-dir name))

(setq org-agenda-files `(,(my-gtd-file "projects.org")
                         ,(my-gtd-file "someday.org")
                         ,(my-gtd-file "tickler.org")))

(setq org-capture-templates `(("t" "Todo [inbox]" entry
                               (file+headline ,(my-gtd-file "inbox.org") "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline ,(my-gtd-file "tickler.org") "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets `((,(my-gtd-file "projects.org") :maxlevel . 3)
                           (,(my-gtd-file "someday.org") :level . 1)
                           (,(my-gtd-file "tickler.org") :maxlevel . 2)))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "\C-c c") #'org-capture)


(global-set-key (kbd "\C-c i")
                (lambda ()
                  (interactive)
                  (find-file (my-gtd-file "inbox.org"))))

(global-set-key (kbd "\C-c p")
                (lambda ()
                  (interactive)
                  (find-file (my-gtd-file "projects.org"))))

(global-set-key (kbd "\C-c t")
                (lambda ()
                  (interactive)
                  (find-file (my-gtd-file "tickler.org"))))
