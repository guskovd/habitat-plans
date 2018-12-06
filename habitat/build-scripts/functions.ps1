function getLatestRelease ($repo) {
    return $(Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest").tag_name
}
