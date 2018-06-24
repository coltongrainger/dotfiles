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
 ;; org mode
 '(package-selected-packages (quote (magit)))
 '(org-agenda-files (quote ("~/todo.org" )))
 '(org-archive-location "~/rec/archive.org::")
 '(org-log-done (quote time))
 '(org-startup-truncated nil)
 '(org-agenda-start-on-weekday nil)
 '(org-capture-templates
   '(
     ;; ("i" "idea" entry
     ;;  (file+headline "~/todo.org" "ideas")
     ;;  "* %T %?")
     ("t" "TODO item" entry
      (file+headline "~/todo.org" "unsorted")
      "* TODO %?
  %i")))
 '(org-todo-keywords
  '((sequence "TODO(t)" "|" "DONE(d)" "NOPE(n)")))
 '(org-agenda-block-separator "")
 '(org-agenda-prefix-format "  %t%s")
 '(org-agenda-custom-commands
   '(("c" "ccg-agenda"
      ((tags "PRIORITY=\"A\""
        ((org-agenda-overriding-header "PRIORITIES")
         (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))))
       (agenda "" 
        ((org-agenda-overriding-header "TIME-SENSITIVE")
         (org-agenda-span 3)))
       (alltodo ""
        ((org-agenda-overriding-header "UNSCHEDULED")
         (org-agenda-skip-function
          '(or (air-org-skip-subtree-if-priority ?A)
               (org-agenda-skip-if nil '(scheduled deadline))))))))
     ("p" "printable-ccg-agenda"
      ((tags "PRIORITY=\"A\""
        ((org-agenda-overriding-header "PRIORITIES")
         (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))))
       (agenda "" 
        ((org-agenda-overriding-header "TIME-SENSITIVE")
         (org-agenda-span 3)))
       (alltodo ""
        ((org-agenda-overriding-header "UNSCHEDULED")
         (org-agenda-skip-function
          '(or (air-org-skip-subtree-if-priority ?A)
               (org-agenda-skip-if nil '(scheduled deadline)))))))
      ((ps-left-header (list "(emacs org-mode)" "(colton grainger)"))
       (org-agenda-add-entry-text-maxlines 5)
       (org-agenda-with-colors nil)
       (htmlize-output-type 'font)
       )
      ("~/raw/agenda.html" "~/raw/agenda.pdf"))
     ))
 '(ps-right-header
   (list 'ps-time-stamp-yyyy-mm-dd "/pagenumberstring load"))
 ;; portrait half-page agenda
 '(ps-header-font-family 'Helvetica)
 '(ps-font-family 'Helvetica)
 '(ps-print-header-frame nil)
 '(ps-print-footer nil)
 '(ps-header-title-font-size 11)
 '(ps-header-font-size 9)
 '(ps-font-size 7)
 '(ps-header-lines 2)
 '(ps-header-line-pad 0)
 '(ps-left-margin 10)
 '(ps-right-margin 10)
 '(ps-top-margin 20)
 '(ps-bottom-margin 20)
 '(ps-number-of-columns 1)
 '(ps-inter-column 0)
 '(ps-landscape-mode nil)
 ;; usage
 '(cursor-type (quote bar))
 '(indent-tabs-mode nil)
 '(magit-diff-refine-hink (quote all))
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
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
