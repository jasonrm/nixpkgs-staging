{ stdenv
, fetchurl
, cmake
, expat
, boost17x
, flex
, jemalloc
, bison
, libmysqlclient
, enableXmlpipe2 ? false
, enableMysql ? true
}:
stdenv.mkDerivation rec {
  pname = "manticore";
  version = "3.5.4";

  src = fetchurl {
    url = "https://github.com/manticoresoftware/manticoresearch/archive/${version}.tar.gz";
    sha256 = "0f78x1q6dr376p6zl4dnx4gfw62d0108924mrm654w985x634538";
    # sha256 = stdenv.lib.fakeSha256;
  };

  preConfigure = ''
    substituteInPlace cmake/GetBoostContext.cmake \
      --replace 'set(Boost_USE_STATIC_LIBS ON)' '# set(Boost_USE_STATIC_LIBS ON)' \
      --replace 'set(Boost_USE_STATIC_RUNTIME ON)' '# set(Boost_USE_STATIC_RUNTIME ON)'
  '';

  cmakeFlags = [
    "-DBOOST_ROOT=${boost17x.dev}"
    "-DWITH_STEMMER=OFF"
    "-DUSE_GALERA=OFF"
    "-DWITH_ICU=OFF"
    "-DDISABLE_TESTING=ON"
  ] ++ stdenv.lib.optionals (!enableMysql) [
    "-DWITH_MYSQL=0"
  ];

  nativeBuildInputs = [
    cmake
    bison
    flex
  ];

  buildInputs = [
    jemalloc
    boost17x
  ] ++ stdenv.lib.optionals enableMysql [
    libmysqlclient
  ] ++ stdenv.lib.optionals enableXmlpipe2 [
    expat
  ];

  # CXXFLAGS = with stdenv.lib; concatStringsSep " " (optionals stdenv.isDarwin [
  #   # see upstream bug: http://sphinxsearch.com/bugs/view.php?id=2578
  #   # workaround for "error: invalid suffix on literal
  #   "-Wno-reserved-user-defined-literal"
  #   # workaround for "error: non-constant-expression cannot be narrowed from type 'long' to 'int'"
  #   "-Wno-c++11-narrowing"
  # ]);

  meta = {
    description = "Open source text search engine for big data and stream filtering";
    homepage = "https://manticoresearch.com/";
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.all;
    maintainers = with stdenv.lib.maintainers; [ ];
  };
}
