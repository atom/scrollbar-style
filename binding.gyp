{
  "targets": [
    {
      "target_name": "scroller-style-observer",
      "include_dirs": [ "<!(node -e \"require('nan')\")" ],
      "sources": [
        "src/scroller-style-observer.mm"
      ],
      "link_settings": {
        "libraries": [
          "-framework", "AppKit"
        ]
      }
    }
  ]
}
