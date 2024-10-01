# Go dev setup

brew install go-task/tap/go-task

echo "Install Go formatting tools"
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest