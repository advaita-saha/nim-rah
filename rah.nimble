# Package

packageName   = "rah"
version       = "0.1.0"
author        = "advaita-saha"
description   = "Nim wrapper for rah protocol in FPGA <-> CPU communication"
license       = "MIT"


# Dependencies

requires "nim >= 2.2.4"


# let cfg =
#   " --outdir:build -f -c --verbosity:0" &
#   " --styleCheck:usages --styleCheck:error --skipParentCfg" &
#   " -d:release -d:kzgExternalBlstNoSha256 -d:kzgExternalBlst"

# # Helper functions
# proc test(args, path: string) =
#   if not dirExists "build":
#     mkDir "build"
#   exec "nim " & getEnv("TEST_LANG", "c") & " " & getEnv("NIMFLAGS") & " " &
#     cfg & " " & args & " " & path

# task test, "Run all tests":
#   test "--mm:refc", "tests/test_all"
#   if (NimMajor, NimMinor) > (1, 6):
#     test "--mm:orc", "tests/test_all"