## Firefox

### User Agent Switcher and Manager

`Options` > `Custom Mode`
```json
{
  "bing.com": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1788.0",
  "*": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"
}
```

## Obsidian
launch with
`bash -c 'sed -i '\''s/"open":true/"open":false/g'\'' ~/.config/obsidian/obsidian.json; ~/Applications/Obsidian-1.3.5-arm64.AppImage'`
