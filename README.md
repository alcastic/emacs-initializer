# Personal GNU Emacs configuration

Configuration focuses on Golang.
In order to make this configuration works:
  * Golang must be installed on the system.
  * Next golang dependencies must be installed on the system:
      
      ```
      $ go install golang.org/x/tools/gopls@latest
      $ go install golang.org/x/tools/cmd/goimports@latest
      ```

First time opening emacs, next elisp function must be executed:

      ```
      M-x all-the-icons-install-fonts RET
      ```
