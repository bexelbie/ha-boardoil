require "yaml"
require "tmpdir"
require "fileutils"
require "open3"

workflow = YAML.load_file(File.expand_path("../.github/workflows/check-upstream-release.yml", __dir__))
step = workflow.fetch("jobs").fetch("check").fetch("steps").find { |item| item["name"] == "Prepend changelog" }

Dir.mktmpdir("boardoil-changelog-") do |dir|
  FileUtils.mkdir_p("#{dir}/boardoil")
  path = "#{dir}/boardoil/CHANGELOG.md"
  history = "## 1.7.0\n\nExisting release notes.\n"
  File.write(path, history)

  %w[1.8.0 1.9.0].each do |version|
    output, status = Open3.capture2e(
      { "VERSION" => version, "UPSTREAM_TAG" => "v#{version}" },
      "bash", "-eo", "pipefail", "-c", step.fetch("run"), chdir: dir
    )
    raise output unless status.success?

    expected = "## #{version}\n\n- Update BoardOil to #{version}.\n\n" \
      "[Upstream release notes](https://github.com/dozigden/boardoil/releases/tag/v#{version})\n\n"
    raise "Changelog entry or release history changed" unless File.read(path) == expected + history
    history = File.read(path)
  end
end

puts "Changelog generation preserves release history."
