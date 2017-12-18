#!/bin/bash

# return PID for a port
function pid_for_port {
  sudo lsof -i :$@
}

function git_push {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    args="$@"

    # filter -d command since I never want this
    if [[ "$args" =~ "-d" ]]; then
      args=""
    fi

    if [[ "$branch" != "HEAD" ]]; then
      if [[ "$branch" =~ "master" ]]; then
        echo "push master, Are you sure? (y/n)"
        read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          if [[ -n $args  ]]; then
            echo 'no force push master'
          else
            git push origin $branch
          fi
        else
          echo 'git push aborted.'
        fi
      # branch is not master, allow force option if passed
      else
        git push origin $branch $args
      fi
    else
      echo 'not on a branch'
    fi
  else
    echo 'Not a git repo'
  fi
}

function git_rebase {
  curbranch=`git rev-parse --abbrev-ref HEAD`
  git checkout master
  git pull origin master
  git checkout $curbranch
  git rebase master
}

# Top Hat ShopifyApp
function tophat_shopify_app {
  if [[ ! -d "shopify_app" ]]; then
    echo "shopify_app gem is not in this directory"
    return
  fi

  usage='usage: tophat_shopify_app <api_key> <api_secret>'

  if [[ -z "$1" ]]; then
    echo $usage
    return
  fi

  if [[ -z "$2" ]]; then
    echo $usage
    return
  fi

  currentDir=$(pwd)

  echo 'rails new testapp'
  rails new testapp

  cd testapp

  echo 'add shopify_app gem'
  echo "gem 'shopify_app', path: '$currentDir/shopify_app'" >> Gemfile
  bundle install

  echo 'run shopify_app generator'
  spring stop
  rails g shopify_app --api_key $1 --secret $2

  echo 'migrate db'
  bundle exec rake db:migrate

  echo 'start server'
  bundle exec rails server -b localhost
}