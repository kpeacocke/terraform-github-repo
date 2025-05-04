/**
 * @name Hardcoded GitHub tokens
 * @description Finds potential hardcoded GitHub tokens in Go code
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision medium
 * @id custom/go-github-tokens
 * @tags security
 *       external/cwe/cwe-798
 */

import go

from BasicLit lit
where 
  lit.getKind() = 9 and // STRING literal
  (
    lit.getValue().regexpMatch("ghp_[A-Za-z0-9]{36}") or
    lit.getValue().regexpMatch("github_pat_[A-Za-z0-9_]{82}") or
    lit.getValue().regexpMatch("gho_[A-Za-z0-9]{36}") or
    lit.getValue().regexpMatch("ghu_[A-Za-z0-9]{36}")
  )
select lit, "Potential hardcoded GitHub token"
