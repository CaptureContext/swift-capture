TEST_RUNNER_CI = $(CI)
MAKEFILE_PATH="./swift-package-action/Makefile"

SCHEME = "Capture"
PLATFORM = iOS
CONFIG = debug

default: test-all

test-all: test-examples
	$(MAKE) CONFIG=debug test-library
	$(MAKE) CONFIG=release test-library

xcodebuild:
	@make xcodebuild $(COMMAND) \
		-f $(MAKEFILE_PATH) \
		SCHEME="$(SCHEME)" \
		PLATFORM=$(PLATFORM) \
		CONFIG=$(CONFIG)

build-for-library-evolution:
	@make build-for-library-evolution \
		-f $(MAKEFILE_PATH) \
		SCHEME="$(SCHEME)" \

test-docs:
	@make test-docs \
		-f $(MAKEFILE_PATH) \
		SCHEME="$(SCHEME)" \
		PLATFORM=macOS

test-example:
	@make test-example \
		-f $(MAKEFILE_PATH) \
		SCHEME="$(SCHEME)" \
		PLATFORM=iOS

test-integration:
	@make test-integration \
		-f $(MAKEFILE_PATH) \
		SCHEME="Integration" \
		PLATFORM=iOS

benchmark:
	@make benchmark -f $(MAKEFILE_PATH)

format:
	@make format -f $(MAKEFILE_PATH)
