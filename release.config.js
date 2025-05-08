module.exports = {
  branches: [
    'main',
    { name: 'develop', prerelease: true },
    { name: 'beta', prerelease: true }
  ],
  plugins: [
    // Analyze commits to determine release type
    ['@semantic-release/commit-analyzer', {
      preset: 'conventionalcommits',
      releaseRules: [
        { type: 'feat', release: 'minor' },
        { type: 'fix', release: 'patch' },
        { type: 'perf', release: 'patch' },
        { type: 'revert', release: 'patch' },
        { type: 'docs', release: false },
        { type: 'style', release: false },
        { type: 'chore', release: false },
        { type: 'refactor', release: 'patch' },
        { type: 'test', release: false },
        { type: 'build', release: false },
        { type: 'ci', release: false },
        { breaking: true, release: 'major' }
      ],
      parserOpts: {
        noteKeywords: ['BREAKING CHANGE', 'BREAKING CHANGES']
      }
    }],
    
    // Generate release notes
    ['@semantic-release/release-notes-generator', {
      preset: 'conventionalcommits',
      presetConfig: {
        types: [
          { type: 'feat', section: '🚀 Features' },
          { type: 'fix', section: '🐛 Bug Fixes' },
          { type: 'perf', section: '⚡ Performance Improvements' },
          { type: 'revert', section: '⏪ Reverts' },
          { type: 'docs', section: '📚 Documentation', hidden: false },
          { type: 'style', section: '💄 Styles', hidden: true },
          { type: 'chore', section: '🔧 Miscellaneous Chores', hidden: true },
          { type: 'refactor', section: '♻️ Code Refactoring' },
          { type: 'test', section: '✅ Tests', hidden: true },
          { type: 'build', section: '🏗️ Build System', hidden: true },
          { type: 'ci', section: '👷 CI/CD', hidden: true }
        ]
      },
      writerOpts: {
        commitsSort: ['subject', 'scope']
      }
    }],
    
    // Update changelog
    ['@semantic-release/changelog', {
      changelogFile: 'CHANGELOG.md',
      changelogTitle: '# Changelog\n\nAll notable changes to this project will be documented in this file.\n\nThe format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),\nand this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).\n\n<!-- markdownlint-disable MD024 -->'
    }],
    
    // Execute custom commands during release
    ['@semantic-release/exec', {
      verifyReleaseCmd: 'echo "Verifying release for ${nextRelease.version}"',
      generateNotesCmd: 'echo "Generating notes for ${nextRelease.version}"',
      prepareCmd: 'echo "Preparing release ${nextRelease.version}"',
      publishCmd: 'echo "Publishing release ${nextRelease.version}"',
      successCmd: 'echo "Successfully released ${nextRelease.version}"',
      failCmd: 'echo "Failed to release ${nextRelease.version}"'
    }],
    
    // Commit changelog and package updates
    ['@semantic-release/git', {
      assets: [
        'CHANGELOG.md',
        'package.json',
        'package-lock.json',
        'docs/changelog.md'
      ],
      message: 'chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}'
    }],
    
    // Create GitHub release
    ['@semantic-release/github', {
      successComment: false,
      failComment: false,
      failTitle: false,
      labels: ['release'],
      assignees: ['kpeacocke'],
      assets: [
        {
          path: 'CHANGELOG.md',
          label: 'Changelog'
        }
      ],
      addReleases: 'bottom'
    }]
  ],
  
  // Additional configuration
  preset: 'conventionalcommits',
  tagFormat: 'v${version}',
  
  // Git configuration
  repositoryUrl: 'https://github.com/kpeacocke/terraform-github-repo.git',
  
  // Debug mode for troubleshooting
  debug: false,
  
  // Dry run mode for testing
  dryRun: false
}