cask "ai-review" do
  version "0.3.7"
  sha256 "6b397e74ff7e97aff02cd5c9df847584b8cc96969a5f13967859e892465d1b6b"

  url "https://github.com/mrmans0n/ai-review/releases/download/v#{version}/AI.Review_#{version}_aarch64.dmg"
  name "AI Review"
  desc "Desktop code review tool for AI-generated diffs"
  homepage "https://github.com/mrmans0n/ai-review"

  depends_on arch: :arm64

  app "AI Review.app"
  binary "#{appdir}/AI Review.app/Contents/MacOS/ai-review", target: "air"

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
