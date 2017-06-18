;;; github-graphql-client-request.el ---             -*- lexical-binding: t; -*-

;; Copyright (C) 2017  南優也

;; Author: 南優也 <yuyaminami@minamiyuuya-no-MacBook.local>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'eieio)
(require 'request)


;; (defclass ggc:query () () :abstract t)

;; (defclass ggc:repository-query (ggc:query)
;;   ((owner :initarg :owner :type string)
;;    (name :initarg :name :type string)
;;    ))

;; (defmethod github-graphql-client-to-query ((repository ggc:repository))
;;   (format ""))

;; (message "%s" (mapcar #'cl--slot-descriptor-name
;;                       (eieio-class-slots 'ggc:repository)
;;                       ;; (object-slots (make-instance 'ggc:repository))
;;                       ;; (class-p)
;;                       ))

;; (defun ggc:request-slot-name-with-type (class)
;;   (mapcar #'(lambda (e) (cons (cl--slot-descriptor-name e)
;;                               (cl--slot-descriptor-type e)))
;;           (eieio-class-slots class)))

;; (defun ggc:request-initialize (class props)
;;   (let ((slot-specs (ggc:request-slot-name-with-type class))
;;         (normalized-props (ggc:request-uncamelize-keys props))
;;         (children-initialized nil))
;;     (dolist (e normalized-props)
;;       (let ((type (cdr (cl-assoc (intern (replace-regexp-in-string ":" "" (symbol-name e))) slot-specs)))
;;             (value (plist-get normalized-props e)))
;;         (if (cl-typep value type)
;;             (plist-put children-initialized e value)
;;           ))
;;       )))

;; (defun ggc:request-uncamelize-keys (plist)
;;   (let ((ret nil))
;;     (mapcar #'(lambda (maybe-key) (if (plist-member plist maybe-key)
;;                                       (plist-put ret maybe-key (plist-get plist maybe-key))))
;;             plist)
;;     ret))

(cl-defun github-graphql-client-request (query token &key (variables nil) success error http-error (headers nil))
  (cl-labels
      ((on-success (&key data &allow-other-keys)
                   (if (plist-get data :error)
                       (funcall error data)
                     (funcall success data)))
       (on-error (&key error-thrown symbol-status response data &allow-other-keys)
                 (funcall http-error
                          :error-thrown error-thrown
                          :symbol-status symbol-status
                          :response response
                          :data data)))
    (let ((url "https://api.github.com/graphql")
          (headers (or headers
                       (list (cons "Authorization" (format "bearer %s" token))
                             (cons "User-Agent" "Emacs")
                             (cons "Content-Type" "application/json")))))
      (request url
               :type "POST"
               :data (json-encode (list (cons "query" query)
                                        (cons "variables" variables)))
               :headers headers
               :parser #'(lambda () (let ((json-object-type 'plist))
                                      (json-read)))
               :error #'on-error
               :success #'on-success))))


(provide 'github-graphql-client-request)
;;; github-graphql-client-request.el ends here
