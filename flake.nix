{
	description = "TLG's pyenv";

	outputs = { nixpkgs, ... }: {
		packages.x86_64-linux = rec {
			default = monstrosity;
			monstrosity = nixpkgs.legacyPackages.x86_64-linux.python3.withPackages(ps: with ps; [
				requests mysql-connector boto3 pandas pylint backoff celery
				sqlalchemy flask python-dotenv markdown behave
				(
					buildPythonPackage rec {
						pname = "heroku3";
						version = "5.2.1";
						src = fetchPypi {
							inherit pname version;
							hash = "sha256-81U6FU6fWVc0vlEp7fXZHHDE4KpYI30exYTHIfrdC88=";
						};
						doCheck = false;
						propagatedBuildInputs = [
							# Specify dependencies
							dateutil
							requests
						];
					}
				)
				(
					buildPythonPackage rec {
						pname = "cloudflare";
						version = "2.11.6";
						src = fetchPypi {
							inherit pname version;
							hash = "sha256-ZTHUyvFguvME0Jl0JRzwWmJOaWPUz4RFeMEVTvupb14=";
						};
						doCheck = false;
						propagatedBuildInputs = [
							# Specify dependencies
							dateutil
							requests
							jsonlines
							pyyaml
							beautifulsoup4
						];
					}
				)
			]);
		};
	};
}
