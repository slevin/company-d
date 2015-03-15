;;; company-d.el --- company-mode backend for D Lang (using DCD)
;; Version: 20150315

;; Copyright (C) 2015

;; Author: slevin <slevin@gmail.com>
;; Keywords: languages
;; Package-Requires: ((company "0.8.0"))

;; No license, this code is under public domain, do whatever you want.

;; Lots of advice from company-go

;;; Code:

(eval-after-load "d-mode"
  '(progn
     (start-process "DVD-server" "*dcd-server*" "dcd-server" "-p" "2000")))

(defun company-d--prefix ()
  (company-grab-symbol-cons "\\." 1)
  )

(defun company-d--process-candidates (results)
  ;;(message "%s" results)
  (let ((res (split-string results "\n" t "[ \f\t\n\r\v]+")))
    (if (string= (car res) "identifiers")
        (mapcar (lambda (str)
                  (car  (split-string str "\t"))
                  )
                (cdr res))
      '())))

(defun company-d (command &optional arg &rest ignored)
  ;(message "%s : %s" command arg)
  (case command
    (prefix (and (derived-mode-p 'd-mode)
                 (not (company-in-string-or-comment))
                 (or (company-d--prefix) 'stop)))
    (candidates
     (let ((temp-buffer (generate-new-buffer "*dcd-client*")))
       (prog2
           (call-process-region (point-min)
                                (point-max)
                                "dcd-client"
                                nil
                                temp-buffer
                                nil
                                (format "-c%d" (point)))
           (with-current-buffer temp-buffer
             (company-d--process-candidates (buffer-string)))
         (kill-buffer temp-buffer))))
    ))

(provide 'company-d)

;; split out return type



;;; company-d.el ends here
