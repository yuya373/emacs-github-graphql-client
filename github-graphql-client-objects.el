;;; github-graphql-client-objects.el ---              -*- lexical-binding: t; -*-

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
(require 'github-graphql-client-interfaces)
(require 'github-graphql-client-connections)

;; TODO https://developer.github.com/v4/reference/object/project/
(defclass ggc:project (ggc:node ggc:updatable) ())

;; https://developer.github.com/v4/reference/object/pageinfo/
(defclass ggc:page-info ()
  ((end-cursor :initarg :end-cursor :type (or null string))
   (has-next-page :initarg :has-next-page :type boolean)
   (has-previous-page :initarg :has-previous-page :type boolean)
   (start-cursor :initarg :start-cursor :type (or null string))))

;; TODO https://developer.github.com/v4/reference/object/user/
(defclass ggc:user
    (ggc:node
     ggc:actor
     ggc:repository-owner
     ggc:uniform-resource-locatable
     ) ())
(defclass ggc:team (ggc:node)
  ((description :initarg :description :type string)
   (edit-team-resource-path :initarg :edit-team-resource-path :type ggc:uri)
   (edit-team-url :initarg :edit-team-url :type ggc:uri)
   (invitations :initarg :invitations :type ggc:organization-invitation-connection)
   (name :initarg :name :type string)
   (organization :initarg :organization :type ggc:organization)
   (privacy :initarg :privacy :type ggc:team-privacy)
   (resource-path :initarg :resource-path :type ggc:uri)
   (slug :initarg :slug :type string)
   (url :initarg :url :type ggc:uri)))
;; https://developer.github.com/v4/reference/object/organization/
(defclass ggc:organization
    (ggc:node ggc:actor ggc:project-owner ggc:repository-owner ggc:uniform-resource-locatable)
  ((members :initarg :members :type ggc:user-connection)
   (projects :initarg :projects :type ggc:project-connection)
   (repositories :initarg :repositories :type ggc:repository-connection)
   (teams :initarg :teams :type ggc:team-connection)
   (is-invoiced :initarg :is-invoiced :type boolean)
   (name :initarg :name :type string)
   (new-team-resource-path :initarg :new-team-resource-path :type ggc:uri)
   (new-team-url :initarg :new-team-url :type ggc:uri)
   (organization-billing-email :initarg :organization-billing-email :type string)
   ;; (saml-identify-provider)
   (team :initarg :team :type ggc:team)
   (teams-url :initarg :teams-url :type ggc:uri)
   (viewer-can-administer :initarg viewer-can-administer :type boolean)
   (viewer-can-create-teams :initarg :viewer-can-create-teams :type boolean)
   (viewer-is-a-member :initarg :viewer-is-a-member :type boolean)))

(defclass ggc:rate-limit ()
  ((cost :initarg :cost :type integer)
   (limit :initarg :limit :type integer)
   (remaining :initarg :remaining :type integer)
   (reset-at :initarg :reset-at :type string)))

;; https://developer.github.com/v4/reference/object/codeofconduct/
(defclass ggc:code-of-conduct ()
  ((body :initarg :body :type string)
   (key :initarg :key :type string)
   (name :initarg :name :type string)
   (url :initarg :url :type ggc:uri)))

;; https://developer.github.com/v4/reference/interface/gitobject/
(defclass ggc:git-object ()
  ((abbreviated-oid :initarg :abbreviated-oid :type string)
   (commit-resource-path :initarg :commit-resource-path :type ggc:uri)
   (commit-url :initarg :commit-url :type ggc:uri)
   (oid :initarg :oid :type ggc:git-object-id) ;; TODO
   (repository :initarg :repository :type ggc:repository)))

;; https://developer.github.com/v4/reference/object/ref/
(defclass ggc:ref (ggc:node)
  ((name :initarg :name :type string)
   (prefix :initarg :prefix :type string)
   (repository :initarg :repository :type ggc:repository)
   (target :initarg :target :type ggc:git-object)))


(defclass ggc:reactable ()
  ((reaction-groups :initarg :reaction-groups :type list ;; ggc:reaction-group
                    )
   (viewer-can-react :initarg :viewer-can-react :type boolean)))
(defclass ggc:reaction-group ()
  ((users :initarg :users :type ggc:reacting-user-connection)
   (content :initarg :content :type ggc:reaction-content)
   (created-at :initarg :created-at :type ggc:datetime)
   (subject :initarg :subject :type ggc:reactable)
   (viewer-has-reacted :initarg :viewer-has-reacted :type boolean)))
;; TODO https://developer.github.com/v4/reference/object/commit/
(defclass ggc:commit ()
  ())
(defclass ggc:commit-comment
    (ggc:node ggc:comment ggc:deletable ggc:updatable ggc:updatable-comment
              ggc:reactable ggc:repository-node
              ggc:has-reactions)
  ((commit :initarg :commit :type ggc:commit)
   (path :initarg :path :type string)
   (position :initarg :position :type integer)
   ))

(defclass ggc:review-request (ggc:node)
  ((pull-request :initarg :pull-request :type ggc:pull-request)
   (reviewer :initarg :reviewer :type ggc:user)))

(defclass ggc:pull-request-review
    (ggc:node ggc:comment ggc:deletable ggc:updatable ggc:updatable-comment ggc:repository-node
              ggc:has-comments)
  ((body-text :initarg :body-text :type string)
   (commit :initarg :commit :type ggc:commit)
   (state :initarg :state :type ggc:pull-request-review-state)
   ))
(defclass ggc:suggested-reviewer ()
  ((is-author :initarg :is-author :type boolean)
   (is-commenter :initarg :is-commenter :type boolean)
   (reviewer :initarg :reviewer :type ggc:user)))

(defclass ggc:pull-request
    (ggc:node ggc:assignable ggc:closable ggc:comment ggc:updatable ggc:updatable-comment
              ggc:labelable ggc:lockable ggc:reactable ggc:repository-node ggc:subscribable
              ggc:uniform-resource-locatable
              ggc:has-comments ggc:has-participants ggc:has-reactions)
  ((commits :initarg :commits :type ggc:pull-request-commit-connection)
   (timeline :initarg :timeline :type ggc:pull-request-timeline-connection)
   (base-ref :initarg :base-ref :type ggc:ref)
   (base-ref-name :initarg :base-ref-name :type string)
   (body-text :initarg :body-text :type string)
   (head-ref :initarg :head-ref :type ggc:ref)
   (head-ref-name :initarg :head-ref-name :type string)
   (head-repository :initarg :head-repository :type ggc:repository)
   (head-repository-owner :initarg :head-repository-owner :type ggc:repository-owner)
   (is-cross-repository :initarg :is-cross-repository :type boolean)
   (merge-commit :initarg :merge-commit :type ggc:commit)
   (mergeable :initarg :mergeable :type ggc:mergeable-state)
   (merged :initarg :merged :type boolean)
   (merged-at :initarg :merged-at :type ggc:datetime)
   (number :initarg :number :type integer)
   (potential-merge-commit :initarg :potential-merge-commit :type ggc:commit)
   (review-requests :initarg :review-requests :type ggc:review-request-connection)
   (reviews :initarg :reviews :type ggc:pull-request-review-connection)
   (state :initarg :state :type ggc:pull-request-state)
   (suggested-reviewers :initarg :suggested-reviewers :type list ;; (list ggc:suggested-reviewer)
                        )
   (title :initarg :title :type string)
   ))
(defclass ggc:label (ggc:node)
  ((issues :initarg :issues :type ggc:issue-connection)
   (color :initarg :color :type string)
   (name :initarg :name :type string)
   (pull-requests :initarg :pull-requests :type ggc:pull-request-connection)
   (repository :initarg :repository :type ggc:repository)))
(defclass ggc:issue-comment
    (ggc:node ggc:comment ggc:deletable ggc:updatable ggc:updatable-comment
              ggc:reactable ggc:repository-node ggc:has-reactions)
  ((body-text :initarg :body-text :type string)
   (issue :initarg :issue :type ggc:issue)
   (reaction-groups :initarg :reaction-groups :type list ;; ggc:reaction-group
                    )
   (repository :initarg :repository :type ggc:repository)))
;; https://developer.github.com/v4/reference/object/milestone
(defclass ggc:milestone (ggc:node)
  ((creator :initarg :creator :type ggc:actor)
   (description :initarg :description :type string)
   (due-on :initarg :due-on :type ggc:datetime)
   (number :initarg :number :type integer)
   (repository :initarg :repository :type ggc:repository)
   (resource-path :initarg :resource-path :type ggc:uri)
   (state :initarg :state :type ggc:milestone-state)
   (title :initarg :title :type string)
   (url :initarg :url :type ggc:uri)
   ))
(defclass ggc:issue
    (ggc:node ggc:assignable ggc:closable
              ggc:comment ggc:updatable ggc:updatable-comment
              ggc:labelable ggc:lockable ggc:reactable
              ggc:repository-node  ggc:subscribable
              ggc:uniform-resource-locatable
              ggc:has-comments ggc:has-participants ggc:has-reactions)
  ((timeline :initarg :timeline :type ggc:issue-timeline-connection)
   (body-text :initarg :body-text :type string)
   (milestone :initarg :milestone :type ggc:milestone)
   (number :initarg :number :type integer)
   (state :initarg :state :type ggc:issue-state)
   (title :initarg :title :type string)
   ))

;; TODO https://developer.github.com/v4/reference/object/protectedbranch/
(defclass ggc:protected-branch (ggc:edge)
  ((push-allowances :initarg :push-allowances :type ggc:push-allowance-connection)
   (review-dismissal-allowances :initarg :review-dismissal-allowances :type ggc:review-dismissal-allowance-connection)
   (creator :initarg :create :type ggc:actor)
   (has-dismissable-stale-reviews :initarg :has-dismissable-stale-reviews :type boolean)
   (has-required-reviews :initarg :has-required-reviews :type boolean)
   (has-required-status-checks :initarg :has-required-status-checks :type boolean)
   (has-restricted-pushes :initarg :has-restricted-pushes :type boolean)
   (has-strict-required-status-check :initarg :has-strict-required-status-check :type boolean)
   (is-admin-enforced :initarg :is-admin-enforced :type boolean)
   (repository :initarg :repository :type ggc:repository)
   (required-status-check-contexts :initarg :required-status-check-contexts :type list ;; string
                                   )
   ))

;; https://developer.github.com/v4/reference/object/repository/
(defclass ggc:repository
    (ggc:node ggc:project-owner ggc:subscribable ggc:starrable ggc:uniform-resource-locatable
              ggc:repository-info)
  ((commit-comments :initarg :commit-comments :type ggc:commit-comment-connection)
   (forks :initarg :forks :type ggc:repository-connection)
   (issues :initarg :issues :type ggc:issue-connection)
   (mentionable-users :initarg :mentionable-users :type ggc:user-connection)
   (projects :initarg :projects :type ggc:project-connection)
   (protected-branches :initarg :protected-branches :type ggc:protected-branch-connection)
   (pull-requests :initarg :pull-requests :type ggc:pull-request-connection)

   (code-of-conduct :initarg :code-of-conduct :type ggc:code-of-conduct)
   (default-branch-ref :initarg :default-branch-ref :type ggc:ref)
   (disk-usage :initarg :disk-usage :type integer)
   (issue :initarg :issue :type ggc:issue)
   ))

(defclass ggc:resource ()
  ((url :initarg :url :type string)))

(defclass ggc:topic ()
  ((name :initarg :name :type string)
   (related-topics :initarg :related-topics :type list)))



(provide 'github-graphql-client-objects)
;;; github-graphql-client-objects.el ends here
