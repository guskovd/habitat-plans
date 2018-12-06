. ../tmp/env.ps1

function getLatestRelease ($repo) {
    $uri = "https://api.github.com/repos/$repo/releases/latest?access_token=$GITHUB_TOKEN"
    echo "web request uri: $uri"
    return $(Invoke-RestMethod -Uri "$uri").tag_name
}
