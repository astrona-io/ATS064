---
draft: true
exam_objectives:
- State Store
---
# Summary

A state store retains retrievable versions of desired declarations under controlled access. Git is a common implementation, but the important contracts are version identity, history, audit and agent access. Mutable references select versions and must not be confused with content identity. Review and retention policy determine whether earlier intent remains trustworthy and recoverable. Keeping history does not justify storing plaintext secrets or granting every reader write access.
