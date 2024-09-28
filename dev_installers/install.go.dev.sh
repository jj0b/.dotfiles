# Go

brew install go-task/tap/go-task

echo "Add ~/go/bin to PATH"
set -gx PATH $PATH ~/go/bin

echo "Install Go formatting tools"
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest