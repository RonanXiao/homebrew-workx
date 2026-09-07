class Workx < Formula
  desc "Independent coding agent derived from OpenAI Codex"
  homepage "https://github.com/RonanXiao/workx"
  url "https://github.com/RonanXiao/workx/archive/b295dcf2b939caed22c5505bbdb92c59d0b67cf9.tar.gz"
  version "0.0.1"
  sha256 "afc072ef811a34a06803c47f6863830a58a583c6d1f25f7f1e215e9f7950c9da"
  license "Apache-2.0"

  head "https://github.com/RonanXiao/workx.git", branch: "main"

  depends_on "openssl@3"
  depends_on "pkg-config"
  depends_on "python@3.13"
  depends_on "rust"

  def install
    if OS.linux?
      odie "Workx Homebrew formula currently supports macOS only"
    end

    ENV["WORKX_REPO_ROOT"] = buildpath.to_s
    ENV["OPENSSL_DIR"] = formula_opt_prefix("openssl@3")
    ENV.prepend_path "PKG_CONFIG_PATH", formula_opt_lib("openssl@3")/"pkgconfig"

    target = Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"

    system "python3", "scripts/build_workx_package.py",
           "--variant", "workx",
           "--package-version", version.to_s,
           "--cargo-profile", "release",
           "--target", target,
           "--package-dir", "pkg"

    libexec.install "pkg/bin"
    libexec.install "pkg/workx-resources"
    libexec.install "pkg/workx-path"
    libexec.install "pkg/workx-package.json"

    bin.install_symlink libexec/"bin/workx" => "workx"
    bin.install_symlink libexec/"bin/workx-code-mode-host" => "workx-code-mode-host"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/workx --version")
  end
end
