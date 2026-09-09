cask "workx" do
  version "0.1.0"
  sha256 "1c7d6ef2cc1c498ec5348b9a5bc4a86a2cb4840dc8ca2c069948aeec072c964e"

  url "https://github.com/RonanXiao/workx/releases/download/rust-v#{version}/Workx-#{version}-arm64.dmg"
  name "Workx"
  desc "Independent coding agent derived from OpenAI Codex"
  homepage "https://github.com/RonanXiao/workx"

  depends_on formula: "workx"
  depends_on macos: :monterey

  app "Workx.app"
end
