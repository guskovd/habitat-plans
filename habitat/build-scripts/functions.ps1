function getLatestRelease ($repo) {
    return $(Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest?access_token=$GITHUB_TOKEN").tag_name
}
