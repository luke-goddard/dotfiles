;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 8 :weight 'semi-light)
;;     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 8))
;;
(setq doom-font (font-spec :size 12 ))


;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/Documents/org/org-roam")
(setq org-display-remote-inline-images t)

(use-package! consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep) ;; faster searching
  (consult-org-roam-buffer-after-buffers t) ;; display org-roam buffers after non-org-roam
  :config
  (consult-org-roam-mode))


(defun my/org-insert-filetags-property ()
  "Automatically insert the FILETAGS property into a new, empty Org-mode file."
  (when (and (derived-mode-p 'org-mode)
             (zerop (buffer-size)))
    (goto-char (point-min))
    (insert "#+FILETAGS: \n")))


(add-hook 'org-mode-hook 'org-display-inline-images)

(add-hook 'find-file-hook 'my/org-insert-filetags-property)

(defun my/org-roam-find-by-tag ()
  "Use completion to select an Org-roam tag, then open the matching node."
  (interactive)
  (let* ((all-tags (delete-dups
                     (mapcan #'org-roam-node-tags (org-roam-node-list))))
         (tag (completing-read "Select tag: " all-tags nil t))
         (nodes (seq-filter (lambda (node)
                              (member tag (org-roam-node-tags node)))
                            (org-roam-node-list))))
    (if nodes
        (let ((selected-node
               (completing-read
                (format "Notes tagged '%s': " tag)
                (mapcar (lambda (node)
                          ;; Return a cons cell where the car is the title and cdr is the node object
                          (cons (org-roam-node-title node) node))
                        nodes)
                nil t)))
          (when selected-node
            (let ((node-object (cdr (assoc selected-node
                                           (mapcar (lambda (node)
                                                     (cons (org-roam-node-title node) node))
                                                   nodes)))))
              (find-file (org-roam-node-file node-object)))))
      (message "No notes found with tag: %s" tag))))


(map! :leader
      (:prefix ("f" . "file")
       :desc "Consult Org-roam Search" "g" #'consult-org-roam-search))

(map! :leader
      (:prefix ("f" . "file")
       :desc "Find notes via tag" "t" #'my/org-roam-find-by-tag))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
