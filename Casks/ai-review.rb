cask "ai-review" do
  version "0.5.2"
  sha256 "c08ba50b43ea1bf7f4e2f098fff6805884d2c078a6361fceee03d2c1555a19a1"

  url "https://github.com/mrmans0n/ai-review/releases/download/v#{version}/AI.Review-#{version}-arm64.dmg"
  name "AI Review"
  desc "Desktop code review tool for AI-generated diffs"
  homepage "https://github.com/mrmans0n/ai-review"

  depends_on arch: :arm64

  app "AI Review.app"
  binary "#{appdir}/AI Review.app/Contents/MacOS/AI Review", target: "air"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/AI Review.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.nacholopez.ai-review",
    "~/Library/Caches/com.nacholopez.ai-review",
  ]
end
