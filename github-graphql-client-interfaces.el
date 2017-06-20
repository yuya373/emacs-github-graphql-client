;;; github-graphql-client-interfaces.el ---          -*- lexical-binding: t; -*-

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
(require 'github-graphql-client-types)

(defclass ggc:node () ((id :initarg :id :type string)) :abstract t)

(defclass ggc:nodes () ((ids :initarg :id :type list)) :abstract t)

(defclass ggc:assignable () ((assignees :initarg :assignees :type ggc:user-connection)) :abstract t)

(defclass ggc:labelable () ((labels :initarg :labels :type ggc:label-connection)) :abstract t)

(defclass ggc:lockable () ((locked :initarg :locked :type boolean)) :abstract t)

(defclass ggc:closable () ((closed :initarg :closed :type boolean)) :abstract t)

(defclass ggc:actor ()
  ((avatar-url :initarg :avatar-url :type ggc:uri)
   (login :initarg :login :type string)
   (resource-path :initarg :resource-path :type ggc:uri)
   (url :initarg :url :type ggc:uri))
  :abstract t)

(defclass ggc:updatable () ((viewer-can-update :initarg :viewer-can-update :type boolean)) :abstract t)

(defclass ggc:uniform-resource-locatable ()
  ((resource-path :initarg :resource-path :type ggc:uri)
   (url :initarg :url :type ggc:uri))
  :abstract t)

(defclass ggc:project-owner ()
  ((project :initarg :project :type ggc:project)
   (projects-resource-path :initarg :projects-resource-path :type ggc:uri)
   (projects-url :initarg :projects-url :type string)
   (viewer-can-create-projects :initarg :viewer-can-create-projects :type boolean))
  :abstract t)

(defclass ggc:edge ()
  ((cursor :initarg :cursor :type string)
   (node :initarg :node))
  :abstract t)

(defclass ggc:connection ()
  ((page-info :initarg :page-info :type ggc:page-info)
   (total-count :initarg :total-count :type integer))
  :abstract t)

(defclass ggc:subscribable ()
  ((viewer-can-subscribe :initarg :viewer-can-subscribe :type boolean)
   (viewer-subscription :initarg :viewer-subscription :type :string))
  :abstract t)

(defclass ggc:starrable ()
  ((viewer-has-starred :initarg :viewer-has-starred :type boolean))
  :abstract t)

;; https://developer.github.com/v4/reference/interface/repositoryinfo/
(defclass ggc:repository-info ()
  ((created-at :initarg :created-at :type ggc:datetime)
   (description :initarg :description :type string)
   (description-html :initarg :description-html :type ggc:html)
   (has-issues-enabled :initarg :has-issues-enabled :type boolean)
   (has-wiki-enabled :initarg :has-wiki-enabled :type boolean)
   (homepage-url :initarg :homepage-url :type ggc:uri)
   (is-fork :initarg :is-fork :type boolean)
   (is-locked :initarg :is-locked :type boolean)
   (is-mirror :initarg :is-mirror :type boolean)
   (is-private :initarg :is-private :type boolean)
   (license :initarg :license :type string)
   (lock-reason :initarg :lock-reason :type ggc:repository-lock-reason)
   (mirror-url :initarg :mirror-url :type ggc:uri)
   (name :initarg :name :type string)
   (name-with-owner :initarg :name-with-owner :type string)
   (owner :initarg :owner :type ggc:repository-owner)
   (pushed-at :initarg :owner :type ggc:datetime)
   (resource-path :initarg :resource-path :type ggc:uri)
   (url :initarg :url :type ggc:uri))
  :abstract t)

;; https://developer.github.com/v4/reference/interface/comment/
(defclass ggc:comment ()
  ((author :initarg :author :type ggc:actor)
   (body :initarg :body :type string)
   (body-html :initarg :body-html :type ggc:html)
   (created-at :initarg :created-at :type ggc:datetime)
   (created-via-email :initarg :created-via-email :type boolean)
   (editor :initarg :editor :type (or null ggc:actor))
   (last-edited-at :initarg :last-edited-at :type (or null ggc:datetime))
   (published-at :initarg :published-at :type ggc:datetime)
   (viewer-did-author :initarg :viewer-did-author :type boolean))
  :abstract t)

(defclass ggc:has-comments ()
  ((comments :initarg :comments :type ggc:issue-comment-connection))
  :abstract t)

(defclass ggc:has-participants ()
  ((participants :initarg :participants :type ggc:user-connection))
  :abstract t)

(defclass ggc:deletable ()
  ((viewer-can-delete :initarg :viewer-can-delete :type boolean))
  :abstract t)

(defclass ggc:updatable-comment ()
  ((viewer-cannot-update-reasons :initarg :viewer-cannot-update-reasons :type list ;;ggc:comment-cannot-update-reason
                                 ))
  :abstract t)

(defclass ggc:repository-node ()
  ((repository :initarg :repository :type ggc:repository))
  :abstract t)

(defclass ggc:has-reactions ()
  ((reactions :initarg :reactions :type ggc:reaction-connection))
  :abstract t)

(provide 'github-graphql-client-interfaces)
;;; github-graphql-client-interfaces.el ends here
