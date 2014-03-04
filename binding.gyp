{
  "targets": [
    {
      "target_name": "scroller-style",
      "include_dirs": [ "<!(node -e \"require('nan')\")" ],
      "sources": [
        "src/scroller-style.mm"
      ],
      "link_settings": {
        "libraries": [
          "-framework", "AppKit"
        ]
      }
    }
  ]
}
