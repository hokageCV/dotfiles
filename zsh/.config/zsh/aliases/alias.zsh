
# git


unalias grbimy 2>/dev/null
grbimy() {
  author=$(git log --pretty=format:"%an" | head -1)
  commits=$(mycommits)

  if [[ -z "$commits" || "$commits" -eq 0 ]]; then
    echo "No commits found for rebasing."
    return 1
  fi

  echo "Rebasing $commits commits of $author"
  echo "Press Enter to continue..."
  read # This waits for user input

  git rebase -i HEAD~$commits
}

