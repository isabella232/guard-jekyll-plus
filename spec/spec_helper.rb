RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run focus: ENV['CI'] != 'true'
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  # config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  # config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.before do
    %w(cp rm_r rm mkdir mkdir_p).each do |meth|
      allow(FileUtils).to receive(meth) do |*args|
        fail "stub me: FileUtils.#{meth}(#{args.map(&:inspect).join(', ')})"
      end
    end

    %w(exist?).each do |meth|
      allow(File).to receive(meth) do |*args|
        fail "stub me: File.#{meth}(#{args.map(&:inspect).join(', ')})"
      end
    end

    %w([]).each do |meth|
      allow(Dir).to receive(meth) do |*args|
        fail "stub me: Dir.#{meth}(#{args.map(&:inspect).join(', ')})"
      end
    end
  end
end
