cask "workx" do
  version "0.1.0"
  sha256 "cbe1cd0dace8faf74756cf8c5aed07ea7ad09b3ce8e037f711d0f48dcd5819f6"

  url "https://github.com/RonanXiao/workx/releases/download/rust-v#{version}/Workx-#{version}-arm64.dmg"
  name "Workx"
  desc "Independent coding agent derived from OpenAI Codex"
  homepage "https://github.com/RonanXiao/workx"

  depends_on formula: "workx"
  depends_on macos: :monterey

  app "Workx.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Workx.app"]
  end
end
