# Github Action for running detekt with reviewdog

This action allows running [detekt](https://github.com/detekt/detekt) with [reviewdog](https://github.com/reviewdog/reviewdog) on pull requests

## Examples

### `github-pr-check` - used by default
`reviewdog_reporter: github-pr-check`  
`github-pr-check` reporter reports results to [GitHub Checks](https://github.com/reviewdog/reviewdog#reporter-github-checks--reportergithub-pr-check)

![Example comment made by the action with github-pr-check](./assets/screenshot_pr_check.png)

### `github-pr-review`
`reviewdog_reporter: github-pr-review`
`github-pr-review` reporter reports results to GitHub PullRequest review comments.

![Example comment made by the action with github-pr-review](./assets/screenshot_pr_review.png)

## License
MIT. See `LICENSE`

## Inspiration
* [action-ktlint](https://github.com/ScaCap/action-ktlint) - Action for running ktlint with reviewdog
