class Workx < Formula
  desc "Independent coding agent derived from OpenAI Codex"
  homepage "https://github.com/RonanXiao/workx"
  version "0.0.4"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/RonanXiao/workx/releases/download/rust-v0.0.4/workx-package-aarch64-apple-darwin.tar.gz"
    sha256 "8425a06295300f6ee33b98adfaca70f216fa12387f2fd1ad66229f2206b8165c"
  else
    url "https://github.com/RonanXiao/workx/archive/refs/tags/rust-v0.0.4.tar.gz"
    sha256 "5a03e5d0c07ccfeb9827a351233ff1618767e2ff25b24028f208bbc199c10458"
  end

  head "https://github.com/RonanXiao/workx.git", branch: "main"

  on_intel do
    depends_on "openssl@3"
    depends_on "pkg-config"
    depends_on "python@3.13"
    depends_on "rust"
  end

  def install
    if build.head? || !Hardware::CPU.arm?
      if OS.linux?
        odie "Workx Homebrew formula currently supports macOS only"
      end

      ENV["WORKX_REPO_ROOT"] = buildpath.to_s
      ENV["OPENSSL_DIR"] = formula_opt_prefix("openssl@3")
      ENV.prepend_path "PKG_CONFIG_PATH", formula_opt_lib("openssl@3")/"pkgconfig"
      ENV["CARGO_NET_GIT_FETCH_WITH_CLI"] = "true"
      ENV["CARGO_HTTP_MULTIPLEXING"] = "false"
      ENV["CARGO_TERM_PROGRESS"] = "always"
      ENV["CARGO_TERM_COLOR"] = "always"

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
    else
      libexec.install "bin"
      libexec.install "workx-resources"
      libexec.install "workx-path"
      libexec.install "workx-package.json"
    end

    bin.install_symlink libexec/"bin/workx" => "workx"
    bin.install_symlink libexec/"bin/workx-code-mode-host" => "workx-code-mode-host"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/workx --version")
  end
end
