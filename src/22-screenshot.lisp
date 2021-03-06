;; screenshot.lisp
;;
;; Stores functions related to screenshot.

(in-package :stumpwm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Commands                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun screenshot-path ()
  "Return the file path of screen shot."
  (uiop:merge-pathnames* (now) +screenshot-dir+))

(defcommand take-screenshot () ()
  "Take screenshot without asking for file name."
  (cond
    ((command-exists-p "maim")
     (run-shell-command
      (format nil "maim -m 10 --format jpg ~A.jpg" (screenshot-path))))
    (t
     (screenshot:screenshot (screenshot-path)))))

(defcommand take-screenshot-selection () ()
  "Take screenshot with selection."
  (cond
    ((command-exists-p "maim")
     (run-shell-command
      (format nil "maim -m 10 --format jpg -s ~A.jpg" (screenshot-path))))
    (t
     (message "Not supported! Please install maim first."))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Bindings                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key *top-map* (kbd "SunPrint_Screen") "take-screenshot")
(define-key *top-map* (kbd "Sys_Req") "take-screenshot-selection")
