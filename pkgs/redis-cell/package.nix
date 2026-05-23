{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "redis-cell";
  version = "v0.5.0";

  src = fetchFromGitHub {
    owner = "brandur";
    repo = pname;
    rev = version;
    sha256 = "sha256-ikRUTHw5XMWC8E9jAMM5gRfXnXUhfq2It/WN1u+AAD0=";
  };

  cargoHash = "sha256-qPPH/6wz9KYahyV+4u/T61AiQX/K8YvtgpjLxqi4iNk=";

  meta = with lib; {
    description = "A Redis module that provides rate limiting in Redis as a single command.";
    license = licenses.mit;
    homepage = "https://github.com/brandur/redis-cell";
    maintainer = ["jason@mcneil.dev"];
  };
}
