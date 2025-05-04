/**
 * @name Environment variable in command execution
 * @description Detects environment variables used in command execution contexts
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id custom/go-env-injection
 * @tags security
 *       external/cwe/cwe-78
 */

import go

from CallExpr getenvCall, CallExpr execCall
where
  getenvCall.getTarget().hasQualifiedName("os", "Getenv") and
  (
    execCall.getTarget().hasQualifiedName("os/exec", "Command") or
    execCall.getTarget().hasQualifiedName("os/exec", "CommandContext")
  ) and
  exists(DataFlow::Node source, DataFlow::Node sink |
    source.asExpr() = getenvCall and
    sink.asExpr() = execCall.getAnArgument() and
    DataFlow::localFlow(source, sink)
  )
select getenvCall, "Environment variable used in command execution context"
