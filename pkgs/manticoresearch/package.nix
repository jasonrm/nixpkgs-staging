{
  stdenv,
  lib,
  fetchurl,
  cmake,
  expat,
  boost17x,
  flex,
  jemalloc,
  bison,
  libmysqlclient,
  enableXmlpipe2 ? false,
  enableMysql ? true,
}:
stdenv.mkDerivation rec {
  pname = "manticore";
  version = "3.6.0";

  src = fetchurl {
    url = "https://repo.manticoresearch.com/repository/manticoresearch_source/release/manticore-3.6.0-210504-96d61d8-release-source.tar.gz";
    # url = "https://github.com/manticoresoftware/manticoresearch/archive/${version}.tar.gz";
    sha256 = "1xg1slpmbvwb1sl8m2zbb91qfr2qm5aigq8rbskjgy6a6z41j2ij";
    # sha256 = lib.fakeSha256;
  };

  preConfigure = ''
    substituteInPlace cmake/GetBoostContext.cmake \
      --replace 'set(Boost_USE_STATIC_LIBS ON)' '# set(Boost_USE_STATIC_LIBS ON)' \
      --replace 'set(Boost_USE_STATIC_RUNTIME ON)' '# set(Boost_USE_STATIC_RUNTIME ON)'
  '';

  cmakeFlags =
    [
      "-DBOOST_ROOT=${boost17x.dev}"
      "-DWITH_STEMMER=OFF"
      "-DUSE_GALERA=OFF"
      "-DWITH_ICU=OFF"
      "-DDISABLE_TESTING=ON"
    ]
    ++ lib.optionals (!enableMysql) [
      "-DWITH_MYSQL=0"
    ];

  nativeBuildInputs = [
    cmake
    bison
    flex
  ];

  buildInputs =
    [
      jemalloc
      boost17x
    ]
    ++ lib.optionals enableMysql [
      libmysqlclient
    ]
    ++ lib.optionals enableXmlpipe2 [
      expat
    ];

  meta = with lib; {
    description = "Open source text search engine for big data and stream filtering";
    homepage = "https://manticoresearch.com/";
    license = licenses.gpl2;
    platforms = platforms.all;
    maintainer = ["jason@mcneil.dev"];
  };
}
