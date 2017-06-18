;;; github-graphql-client-connections.el ---         -*- lexical-binding: t; -*-

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

(require 'github-graphql-client-interfaces)

;; https://developer.github.com/v4/reference/object/useredge/
(defclass ggc:user-edge (ggc:edge) ())
(defclass ggc:project-edge (ggc:edge) ())
(defclass ggc:repository-edge (ggc:edge) ())
(defclass ggc:team-edge (ggc:edge) ())
(defclass ggc:commit-comment-edge (ggc:edge) ())
(defclass ggc:reacting-user-edge (ggc:edge)
  ((reacted-at :initarg :reacted-at :type ggc:datetime)))
(defclass ggc:pull-request-edge (ggc:edge) ())
(defclass ggc:review-request-edge (ggc:edge) ())
(defclass ggc:pull-request-review-edge (ggc:edge) ())
(defclass ggc:issue-edge (ggc:edge) ())
(defclass ggc:label-edge (ggc:edge) ())
(defclass ggc:issue-comment-edge (ggc:edge) ())
(defclass ggc:issue-timeline-item-edge (ggc:edge) ())
(defclass ggc:protected-branch-edge (ggc:edge) ())

;; https://developer.github.com/v4/reference/object/userconnection/
(defclass ggc:user-connection (ggc:connection)
  ((edges :initarg :edges :type list ;;ggc:user-edge
          )
   (nodes :initarg :nodes :type list ;;ggc:user
          )
   ))

;; https://developer.github.com/v4/reference/object/projectconnection/
(defclass ggc:project-connection (ggc:connection)
  ((edges :initarg :edges :type list ;;ggc:project-edge
          )
   (nodes :initarg :nodes :type list ;;ggc:project
          )))

(defclass ggc:repository-connection (ggc:connection)
  ((edges :initarg :edges :type ;; (list ggc:repository-edge)
          )
   (nodes :initarg :nodes :type ;; (list ggc:repository)
          )
   (total-disk-usage :initarg :total-disk-usage :type integer)))

;; TODO https://developer.github.com/v4/reference/object/organizationinvitationconnection
(defclass ggc:organization-invitation-connection () ())

(defclass ggc:team-connection (ggc:connection)
  ((edges :initarg :edges :type list ;;ggc:team-edge
          )
   (nodes :initarg :nodes :type list ;;ggc:team
          )))


(defclass ggc:reacting-user-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; reacting-user-edge
          )
   (nodes :initarg :nodes :type list ;; user
          ))
  )

;; TODO https://developer.github.com/v4/reference/object/reactionconnection/
(defclass ggc:reaction-connection ()
  ())

(defclass ggc:commit-comment-connection (ggc:connection)
  ((edges :initarg :edges :type list ;;ggc:commit-comment-edge
          )
   (nodes :initarg :nodes :type list ;;ggc:commit-comment
          )
   ))

;; TODO https://developer.github.com/v4/reference/object/pullrequestcommitconnection/
(defclass ggc:pull-request-commit-connection (ggc:connection) ())

;; TODO https://developer.github.com/v4/reference/object/pullrequesttimelineconnection
(defclass ggc:pull-request-timeline-connection (ggc:connection) ())

(defclass ggc:review-request-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:review-request-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:review-request
          )))

(defclass ggc:pull-request-review-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:pull-request-review-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:pull-request-review
          )))

;; https://developer.github.com/v4/reference/object/pullrequestconnection/
(defclass ggc:pull-request-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; (list ggc:pull-request-edge)
          )
   (nodes :initarg :nodes :type ;; (list ggc:pull-request)
          )))

(defclass ggc:label-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:label-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:label
          )))

;; https://developer.github.com/v4/reference/object/issuecommentconnection
(defclass ggc:issue-comment-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:issue-comment-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:issue-comment
          )
   ))

;; https://developer.github.com/v4/reference/object/issuetimelineconnection
(defclass ggc:issue-timeline-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:issue-timeline-item-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:issue-timeline-item
          )
   ))

(defclass ggc:issue-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:issue-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:isssue
          )
   ))

;; TODO https://developer.github.com/v4/reference/object/pushallowanceconnection
(defclass ggc:push-allowance-connection (ggc:connection) ())

;; TODO https://developer.github.com/v4/reference/object/reviewdismissalallowanceconnection
(defclass ggc:review-dismissal-allowance-connection (ggc:connection) ())

(defclass ggc:protected-branch-connection (ggc:connection)
  ((edges :initarg :edges :type list ;; ggc:protected-branch-edge
          )
   (nodes :initarg :nodes :type list ;; ggc:protected-branch
          )
   ))

(provide 'github-graphql-client-connections)
;;; github-graphql-client-connections.el ends here
