;; Title: 
;; BitStacks DAO: Decentralized Governance on Bitcoin's Layer 2
;; 
;; Summary:
;; A secure, Bitcoin-anchored DAO protocol enabling decentralized governance and treasury management
;; through Stacks Layer 2 smart contracts, combining Bitcoin's security with scalable execution.

;; Description:
;; BitStacks DAO implements a comprehensive governance system leveraging Stacks' Clarity language
;; for Bitcoin-compliant smart contracts. This DAO features:
;; - Member-managed governance with reputation-based voting power
;; - Bitcoin-denominated treasury with transparent fund allocation
;; - Time-limited proposals with STX-based voting mechanisms
;; - Cross-DAO collaboration capabilities for ecosystem partnerships
;; - Reputation system with activity-based decay and staking rewards
;; - Fully on-chain operations settled to Bitcoin blocks for auditability
;;
;; Built for the Stacks L2 ecosystem, this contract enables enterprise-grade decentralized
;; organizations while maintaining compliance with Bitcoin's security model. The reputation system
;; incentivizes active participation through staking rewards and governance impact, while
;; Clarity's inherent safety features prevent common vulnerabilities in financial operations.
;;
;; Key innovation points:
;; 1. Bitcoin-finalized governance decisions through Stacks L2 anchoring
;; 2. Hybrid reputation model combining staking and participation metrics
;; 3. Gas-efficient voting system optimized for L2 execution
;; 4. Cross-DAO communication primitives for decentralized ecosystem coordination

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-MEMBER (err u101))
(define-constant ERR-NOT-MEMBER (err u102))
(define-constant ERR-INVALID-PROPOSAL (err u103))
(define-constant ERR-PROPOSAL-EXPIRED (err u104))
(define-constant ERR-ALREADY-VOTED (err u105))
(define-constant ERR-INSUFFICIENT-FUNDS (err u106))
(define-constant ERR-INVALID-AMOUNT (err u107))

;; Data variables
(define-data-var total-members uint u0)
(define-data-var total-proposals uint u0)
(define-data-var treasury-balance uint u0)

;; Data maps
(define-map members principal 
  {
    reputation: uint,
    stake: uint,
    last-interaction: uint
  }
)

(define-map proposals uint 
  {
    creator: principal,
    title: (string-ascii 50),
    description: (string-utf8 500),
    amount: uint,
    yes-votes: uint,
    no-votes: uint,
    status: (string-ascii 10),
    created-at: uint,
    expires-at: uint
  }
)

(define-map votes {proposal-id: uint, voter: principal} bool)

(define-map collaborations uint 
  {
    partner-dao: principal,
    proposal-id: uint,
    status: (string-ascii 10)
  }
)