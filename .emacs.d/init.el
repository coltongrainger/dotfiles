;; see also <https://github.com/riceissa/dotfiles>
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; default split behavior, show more lines
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; install packages
(require 'package)
(add-to-list 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; only one instance of custom-set-variables please
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type (quote bar))
 '(indent-tabs-mode nil)
 '(magit-diff-refine-hink (quote all))
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(org-agenda-block-separator "")
 '(org-agenda-custom-commands
   (quote
    (("c" "ccg-agenda"
      ((tags "PRIORITY=\"A\""
             ((org-agenda-overriding-header "PRIORITIES")
              (org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if
                 (quote todo)
                 (quote done))))))
       (agenda ""
               ((org-agenda-overriding-header "TIME-SENSITIVE")
                (org-agenda-span 7)))
       (alltodo ""
                ((org-agenda-overriding-header "UNSCHEDULED")
                 (org-agenda-skip-function
                  (quote
                   (or
                    (air-org-skip-subtree-if-priority 65)
                    (org-agenda-skip-if nil
                                        (quote
                                         (scheduled deadline)))
                    (org-agenda-skip-entry-if
                     (quote todo)
                     (quote
                      ("WAITING"))))))))))
     ("p" "printable-ccg-agenda"
      ((tags "PRIORITY=\"A\""
             ((org-agenda-overriding-header "PRIORITIES")
              (org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if
                 (quote todo)
                 (quote done))))))
       (agenda ""
               ((org-agenda-overriding-header "TIME-SENSITIVE")
                (org-agenda-span 7)))
       (alltodo ""
                ((org-agenda-overriding-header "UNSCHEDULED")
                 (org-agenda-skip-function
                  (quote
                   (or
                    (air-org-skip-subtree-if-priority 65)
                    (org-agenda-skip-if nil
                                        (quote
                                         (scheduled deadline)))
                    (org-agenda-skip-entry-if
                     (quote todo)
                     (quote
                      ("WAITING")))))))))
      ((ps-left-header
        (list "(Agenda)" "(Colton Grainger)"))
       (org-agenda-with-colors nil))
      ("~/agenda.pdf")))))
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-agenda-prefix-format "    %t%s")
 '(org-agenda-start-on-weekday nil)
 '(org-archive-location "~/rec/archive.org::")
 '(org-capture-templates
   (quote
    (("w" "WAITING item" entry
      (file+headline "~/todo.org" "unsorted")
      "* WAITING %?")
     ("t" "TODO item" entry
      (file+headline "~/todo.org" "unsorted")
      "* TODO %? %i"))))
 '(org-log-done (quote time))
 '(org-startup-truncated nil)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "NOPE(n)"))))
 '(package-selected-packages (quote (multiple-cursors magit)))
 '(ps-bottom-margin 20)
 '(ps-font-family (quote Helvetica))
 '(ps-font-size 7)
 '(ps-header-font-family (quote Helvetica))
 '(ps-header-font-size 9)
 '(ps-header-line-pad 0)
 '(ps-header-lines 2)
 '(ps-header-title-font-size 11)
 '(ps-inter-column 0)
 '(ps-landscape-mode nil)
 '(ps-left-margin 20)
 '(ps-number-of-columns 1)
 '(ps-print-color-p (quote black-white))
 '(ps-print-footer nil)
 '(ps-print-header-frame nil)
 '(ps-right-header
   (list
    (quote ps-time-stamp-yyyy-mm-dd)
    "/pagenumberstring load"))
 '(ps-right-margin 20)
 '(ps-top-margin 20)
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(scroll-conservatively 1000)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t))

;; org key maps
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; agenda pretty print
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

;; magit commands
(when (fboundp 'magit-status)
  (global-set-key (kbd "C-x g") 'magit-status))

(when (fboundp 'magit-diff-buffer-file)
  ;; This is like ":Git diff %" in fugitive.vim
  (global-set-key (kbd "C-x C-d")
                  '(lambda () (interactive)
                     (magit-diff-buffer-file)
                     (setq truncate-lines nil)
                     (diff-refine-hunk)
                     (delete-other-windows))))

(when (fboundp 'magit-stage-file)
  ;; This is like ":Gwrite | Gcommit" in fugitive.vim
  (global-set-key (kbd "C-x s")
                  '(lambda () (interactive)
                     (magit-stage-file buffer-file-name)
                     (magit-commit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
