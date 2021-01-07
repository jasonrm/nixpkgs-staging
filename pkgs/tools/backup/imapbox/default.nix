{ lib
, pkgs
, python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
  pname = "imapbox";
  version = "120513e";

  src = fetchFromGitHub {
    owner = "polo2ro";
    repo = pname;
    rev = version;
    sha256 = "12xqqadv7v22kdalnkny8g55iww6fc2kw8429pyw5404brci8fjn";
    # sha256 = lib.fakeSha256;
  };

  buildPhase = ''
    ${python3Packages.python.interpreter} -O -m compileall .
  '';

  propagatedBuildInputs = with python3Packages; [
    six
    chardet
    pdfkit
  ];


  doCheck = false;

  installPhase = ''
    mkdir -p $out/share
    chmod 755 imapbox.py
    cp -r *.py *.pyc $out/share/
  '';

  postFixup = ''
    makeWrapper "$out/share/imapbox.py" "$out/bin/imapbox" \
      --set PYTHONPATH "$PYTHONPATH" \
      --set PATH ${python3Packages.python}/bin
  '';

  meta = with lib; {
    description = "Dump imap inbox to a local folder in a regular backupable format: html, json and attachements";
    homepage = "https://github.com/polo2ro/imapbox";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}