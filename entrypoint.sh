#!/bin/sh
set -e

# 自分のアプリに合わせて必要なコマンドを修正してください
rails db:migrate

rm -f tmp/pids/server.pid && bin/rails s