cask "workx" do
  version "0.1.0"
  sha256 "4538ce3af972e0d88de618f67530b9cad7298981032ceb3fa049360b4a13f162"

  url "https://github.com/RonanXiao/workx/releases/download/rust-v#{version}/Workx-#{version}-arm64.dmg"
  name "Workx"
  desc "Independent coding agent derived from OpenAI Codex"
  homepage "https://github.com/RonanXiao/workx"

  depends_on formula: "workx"
  depends_on macos: ">= :monterey"

  app "Workx.app"
end
