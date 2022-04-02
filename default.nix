with import <nixpkgs> {};
(
let
    pyexecjs = python310.pkgs.buildPythonPackage rec {
      pname = "PyExecJS";
      version = "1.5.1";

      src = python310.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "NMwdBwl2kYGD/3vcCtcfgVeokcknCMAMX7v/enafUFw=";
      };
      propagatedBuildInputs = [python310.pkgs.six];
      doCheck = false;

      meta = {
        homepage = "https://github.com/doloopwhile/PyExecJS";
      };
    };
in python310.withPackages (ps: [ pyexecjs python310Packages.requests
python310Packages.certifi
python310Packages.charset-normalizer
python310Packages.idna
python310Packages.python-dotenv
python310Packages.urllib3
python310Packages.pillow
python310Packages.websocket-client
])
).env
