{
  "targets": [
    {
      "target_name": "scrollbar-style-observer",
      "include_dirs": [ "<!(node -e \"require('nan')\")" ],
      "conditions": [
        ['OS=="mac"', {
          "sources": [
            "src/scrollbar-style-observer-mac.mm",
          ],
          "link_settings": {
            "libraries": [
              "-framework", "AppKit"
            ]
          }
        }],  # OS=="mac"
        ['OS=="win"', {
          "sources": [
            "src/scrollbar-style-observer-non-mac.cc",
          ],
          'msvs_settings': {
            'VCCLCompilerTool': {
              'ExceptionHandling': 1, # /EHsc
              'WarnAsError': 'true',
            },
          },
          'msvs_disabled_warnings': [
            4018,  # signed/unsigned mismatch
            4267,  # conversion from 'size_t' to 'int', possible loss of data
            4530,  # C++ exception handler used, but unwind semantics are not enabled
            4506,  # no definition for inline function
            4996,  # function was declared deprecated
          ],
        }],  # OS=="win"
        ['OS=="linux"', {
          "sources": [
            "src/scrollbar-style-observer-non-mac.cc",
          ],
        }],  # OS=="linux"
      ]
    }
  ]
}
