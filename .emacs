; ediff one and one character
;(setq-default ediff-forward-word-function 'forward-char)

;; make frequently used commands short
(defalias 'fb 'flyspell-buffer)
(defalias 'wsc 'whitespace-cleanup)
(defalias 'wsr 'whitespace-cleanup-region)
(defalias 'mm 'mail-mode)

(load-file "~/.emacs.d/rst.el")

(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 130))

(add-to-list 'load-path "/private/pgdr/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(package-initialize) ;; You might already have this line

; clang tools
; (load "~/clang/tools/clang-format/clang-format.el")
; (global-set-key [C-M-q] 'clang-format-region)

(push ".cache" completion-ignored-extensions)


; metno
(setq weather-metno-location-name "Bergen,  Norway"
      weather-metno-location-latitude 60.389444
      weather-metno-location-longitude 5.33)


;; clock time org mode
;; format string used when creating CLOCKSUM lines and when generating a
;; time duration (avoid showing days)
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))


; color theme
(setq debug-on-error t)
; (require 'color-theme)
(load-file "~/.emacs.d/zenburn-theme.el")
; (zenburn)


(custom-set-variables
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message "")
 '(ediff-split-window-function (quote split-window-horizontally))
 )

(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
;(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(setq line-number-mode t)
(setq column-number-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-ignore-extensions t)


(setq show-paren-delay 0)
(show-paren-mode 1)

(setq default-directory "~/" )


(setq-default fill-column 80)

(require 'whitespace)
; (setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
; (setq indent-line-function 'insert-tab)

;; c++ indentation stuff
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq c-default-style "linux"
      c-basic-offset 2)




;; cmake
(autoload 'cmake-mode "~/.emacs.d/cmake-mode.el" t)

(autoload 'cmake-font-lock-activate "~/.emacs.d/cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode))
              '(("\\.cmake\\'" . cmake-mode)) auto-mode-alist))

;; eclipse
(load-file "~/.emacs.d/eclipse.el")

(add-to-list 'auto-mode-alist '("\\.data\\'"   . eclipse-mode))
(add-to-list 'auto-mode-alist '("\\.ert\\'"    . eclipse-mode))
(add-to-list 'auto-mode-alist '("\\.grdecl\\'" . eclipse-mode))
(add-to-list 'auto-mode-alist '("\\.DATA\\'"   . eclipse-mode))

(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)







;; QML mode


;;; qml-mode.el --- Mode for Qt QML file

;; Filename: qml-mode.el
;; Description: Mode for Qt QML file
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2013 ~ 2014, Andy Stewart, all rights reserved.
;; Created: 2013-12-31 21:23:56
;; Version: 0.3
;; Last-Updated: 2014-05-12 21:16:14
;;           By: Andres Gomez Garcia
;; URL: http://www.emacswiki.org/emacs/download/qml-mode.el
;; Keywords:
;; Compatibility: GNU Emacs 24.3.50.1
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Mode for Qt QML file
;;

;;; Installation:
;;
;; Put qml-mode.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'qml-mode)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET qml-mode RET
;;

;;; Change log:
;;
;; 2014/05/12
;;     * Fixed qml-indent-line
;;
;; 2014/04/10
;;      * Improve qml-font-lock-keywords.
;;
;; 2014/04/09
;;      * Derived-mode from text-mode, and not prog-mode.
;;      * Fixed syntax highlight and indent problem.
;;
;; 2014/01/01
;;      * Fixed keywords regexp
;;      * Fxied qml-indent-line
;;
;; 2013/12/31
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require

(require 'css-mode)
(require 'js)

;;; Code:

(defcustom qml-mode-hook '()
  "Called upon entry into term mode.
This is run before the process is cranked up."
  :type 'hook
  :group 'qml-mode)

(defvar qml-indent-width 4)

(defconst qml-block-re "\\(^[ \t]*\\)\\([a-zA-Z0-9]*\\)[ \t]*[a-zA-Z0-9_]*[ \t]*.*{")

(defun qml-get-beg-of-block ()
  (save-excursion
    (when (re-search-backward qml-block-re nil t)
      (match-beginning 2)))
  )

(defun qml-get-end-of-block ()
  (save-excursion
    (when (re-search-backward qml-block-re nil t)
      (goto-char (match-end 0))
      (backward-char)
      (condition-case nil
          (save-restriction
            (forward-list)
            (point))
        (error nil))
      ))
  )

(defun qml-indent-line ()
  (let ((cur (point))
        (start (qml-get-beg-of-block))
        (end (qml-get-end-of-block))
        (cur-indent nil))
    (save-excursion
      (if (not (and start end (> cur start) (< cur end)))
          (progn
            (if start
                (goto-char start))
            (setq start (qml-get-beg-of-block))
            (setq end (qml-get-end-of-block))
            (while (and (not (eq start nil)) (not (eq end nil)) (not (and (> cur start) (< cur end))))
              (goto-char start)
              (setq start (qml-get-beg-of-block))
              (setq end (qml-get-end-of-block))
              )
            (if (or (eq start nil) (= (point) (point-min)))
                (progn
                  (goto-char (point-min))
                  (when (re-search-forward qml-block-re nil t)
                    (goto-char (match-beginning 2))
                    (setq start (point))
                    (goto-char (match-end 0))
                    (backward-char)
                    (condition-case nil
                        (save-restriction
                          (forward-list)
                          (setq end (point))
                          (setq cur-indent 0))
                      (error nil)))))))
      (if (not cur-indent)
          (progn
            (goto-char start)
            (setq cur-indent (current-indentation))
            (goto-char cur)
            (unless (string= (string (char-after (- (point) 1))) "{")
              (setq cur-indent (+ cur-indent tab-width))
              )
            )))
    (indent-line-to cur-indent)
    (if (string= (string (char-after (point))) "}")
        (indent-line-to (- cur-indent tab-width))
      )
    ))

(defvar qml-font-lock-keywords
  `(
    ;; Comment.
    ("/\\*.*\\*/\\|//.*"
     (0 font-lock-comment-face t t))
    ;; Constants.
    ("\\<\\(true\\|false\\)\\>"
     (0 font-lock-constant-face)
     )
    (":[ \t]?\\(-?[0-9\.]+\\)"
     (1 font-lock-constant-face)
     )
    ;; String.
    ("\"[^\"]*\""
     (0 font-lock-string-face))
    ;; Keyword.
    ("\\<\\(import\\|if\\|for\\|case\\|break\\|switch\\|else\\|[ \t]+if\\)\\>"
     (1 font-lock-keyword-face nil t))
    ;; Import
    ("\\(^import\\)[ \t]+\\([a-zA-Z\.]+\\)[ \t]+\\([0-9\.]+\\)"
     (1 font-lock-keyword-face nil t)
     (2 font-lock-function-name-face nil t)
     (3 font-lock-constant-face nil t)
     )
    ;; Element
    ("\\([A-Z][a-zA-Z0-9]*\\)[ \t]?{"
     (1 font-lock-function-name-face nil t))
    ;; Property keyword.
    ("\\(^[ \t]+property[ \t][a-zA-Z0-9_]+[ \t][a-zA-Z0-9_]+\\)"
     (0 font-lock-variable-name-face nil t))
    ;; Signal.
    ("\\(^[ \t]+signal[ \t][a-zA-Z0-9]+\\)"
     (0 font-lock-variable-name-face nil t))
    ;; Properties.
    ("\\([ \t]?[a-zA-Z0-9_\.]+\\):"
     (1 font-lock-variable-name-face nil t))
    ("\\<\\(anchors\\|margins\\)\\>"
     (1 font-lock-variable-name-face nil t))
    ;; Method
    ("\\<\\(function\\) +\\([a-z][a-zA-Z0-9]*\\)\\>"
     (1 font-lock-keyword-face nil t)
     (2 font-lock-function-name-face nil t))
    )
  "Keywords to highlight in `qml-mode'.")

(defvar qml-mode-syntax-table
  (let ((table (make-syntax-table)))
    (c-populate-syntax-table table)
    table))

;;;###autoload

(define-derived-mode qml-mode text-mode "QML"
  "Major mode for Qt declarative UI"
  (interactive)
  (set-syntax-table qml-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(qml-font-lock-keywords))
  (set (make-local-variable 'tab-width) qml-indent-width)
  (set (make-local-variable 'indent-tabs-mode) nil)
  (set (make-local-variable 'indent-line-function) 'qml-indent-line)
  (set (make-local-variable 'comment-start) "/* ")
  (set (make-local-variable 'comment-end) " */")
  (setq major-mode 'qml-mode)
  (setq mode-name "qml")

  (electric-indent-mode -1)

  (use-local-map qml-mode-map)
  (run-hooks 'qml-mode-hook)
  )

(defvar qml-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-M-q") 'qml-indent-exp)
    map)
  "Keymap used by `qml-mode'.")

(defun qml-indent-exp ()
  (interactive)
  (save-excursion
    (indent-buffer))
  )

(provide 'qml-mode)
(add-to-list 'auto-mode-alist '("\\.qml\\'"    . qml-mode))
;;; qml-mode.el ends here

;; // END QML MODE


                                        ; YAML
(load-file "~/.emacs.d/yaml-mode.el")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.est\\'" . yaml-mode))





(add-hook 'mail-mode-hook 'flyspell-mode)

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)


;;
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)



(defun snake-case ()
  (interactive)
  (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil
                         (region-beginning)
                         (region-end))
         (downcase-region (region-beginning) (region-end))))
