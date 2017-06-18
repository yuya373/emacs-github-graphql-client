;;; github-graphql-client-types.el ---               -*- lexical-binding: t; -*-

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


(cl-deftype ggc:unsubscribed () '(satisfies (lambda (state) (string= "UNSUBSCRIBED" state))))
(cl-deftype ggc:subscribed () '(satisfies (lambda (state) (string= "SUBSCRIBED" state))))
(cl-deftype ggc:ignored () '(satisfies (lambda (state) (string= "IGNORED" state))))
(cl-deftype ggc:subscription-state () '(or ggc:ignored ggc:subscribed ggc:unsubscribed))

;; TODO https://developer.github.com/v4/reference/scalar/uri/
(defun ggc:uri? (maybe-uri) t)
(cl-deftype ggc:uri () '(satisfies ggc:uri?))
;; TODO https://developer.github.com/v4/reference/scalar/html/
(defun ggc:html? (maybe-html) t)
(cl-deftype ggc:html () '(satisfies ggc:html?))
;; TODO https://developer.github.com/v4/reference/scalar/datetime/
(defun ggc:datetime? (maybe-datetime) t)
(cl-deftype ggc:datetime () '(satisfies ggc:datetime?))

(cl-deftype ggc:rename () '(satisfies (lambda (reason) (string= reason "RENAME"))))
(cl-deftype ggc:migrating () '(satisfies (lambda (reason) (string= reason "MIGRATING"))))
(cl-deftype ggc:billing () '(satisfies (lambda (reason (string= reason "BILLING")))))
(cl-deftype ggc:moving () '(satisfies (lambda (reason) (string= reason "MOVING"))))
(cl-deftype ggc:repository-lock-reason () '(or ggc:moving ggc:billing ggc:migrating ggc:rename))

;; TODO https://developer.github.com/v4/reference/scalar/gitobjectid/
(cl-deftype ggc:git-object-id () '(satisfies (lambda (e) t)))

(cl-deftype ggc:visible () '(satisfies (lambda (type) (string= type "VISIBLE"))))
(cl-deftype ggc:secret () '(satisfies (lambda (type) (string= type "SECRET"))))
(cl-deftype ggc:team-privacy () '(or ggc:secret ggc:visible))

(cl-deftype ggc:insufficient-access () '(satisfies (lambda (e) (string= e "INSUFFICIENT_ACCESS"))))
(cl-deftype ggc:locked () '(satisfies (lambda (e) (string= e "LOCKED"))))
(cl-deftype ggc:login-required () '(satisfies (lambda (e) (string= e "LOGIN_REQUIRED"))))
(cl-deftype ggc:maintenance () '(satisfies (lambda (e) (string= e "MAINTENANCE"))))
(cl-deftype ggc:verified-email-required () '(satisfies (lambda (e) (string= e "VERIFIED_EMAIL_REQUIRED"))))
(cl-deftype ggc:viewer-cannot-update-reason ()
  '(or ggc:insufficient-access ggc:locked ggc:login-required ggc:maintenance ggc:verified-email-required))

(defmacro ggc:deftype (name predicate)
  `(cl-deftype ,name () '(satisfies ,predicate)))

(defmacro ggc:deftype1 (name value)
  `(ggc:deftype ,name (lambda (e) (equal e ,value))))


(defmacro ggc:enum (name &rest types)
  `(cl-deftype ,name () '(or ,@types)))

;; TODO https://developer.github.com/v4/reference/union/issuetimelineitem/
(ggc:enum ggc:issue-timeline-item
          ggc:commit ggc:issue-comment
          ;; ggc:closed-event ggc:reopened-event ggc:subscribed-event ggc:unsubscribed-event
          ;; ggc:referenced-event ggc:assigned-event ggc:unassigned-event ggc:labeled-event
          ;; ggc:milestoned-event ggc:demilestoned-event ggc:renamed-title-event
          ;; ggc:locked-event ggc:unlocked-event
          )

(ggc:deftype1 ggc:thumbs-up "THUMBS_UP")
(ggc:deftype1 ggc:thumbs-down "THUMBS_DOWN")
(ggc:deftype1 ggc:laugh "LAUGH")
(ggc:deftype1 ggc:hooray "HOORAY")
(ggc:deftype1 ggc:confused "CONFUSED")
(ggc:deftype1 ggc:heart "HEART")
(ggc:enum ggc:reaction-content ggc:thumbs-up ggc:thumbs-down ggc:laugh ggc:hooray ggc:confused ggc:heart)

(ggc:deftype1 ggc:open "OPEN")
(ggc:deftype1 ggc:closed "CLOSED")
(ggc:enum ggc:issue-state ggc:open ggc:closed)
(ggc:enum ggc:milestone-state ggc:open ggc:closed)

(ggc:deftype1 ggc:mergeable "MERGEABLE")
(ggc:deftype1 ggc:conflicting "CONFLICTING")
(ggc:deftype1 ggc:unknown "UNKNOWN")
(ggc:enum ggc:mergeable-state ggc:mergeable ggc:conflicting ggc:unknown)

(ggc:deftype1 ggc:pending "PENDING")
(ggc:deftype1 ggc:commented "COMMENTED")
(ggc:deftype1 ggc:approved "APPROVED")
(ggc:deftype1 ggc:changes-requested "CHANGES_REQUESTED")
(ggc:deftype1 ggc:dismissed "DISMISSED")
(ggc:enum ggc:pull-request-review-state
          ggc:pending ggc:commented ggc:approved ggc:changes-requested ggc:dismissed)

(ggc:deftype1 ggc:merged "MERGED")
(ggc:enum ggc:pull-request-state ggc:open ggc:closed ggc:merged)
(provide 'github-graphql-client-types)
;;; github-graphql-client-types.el ends here
