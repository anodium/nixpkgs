{ lib
, stdenv
, gettext
, fetchurl
, webkitgtk_4_1
, pkg-config
, gtk3
, glib
, gnome
, sqlite
, itstool
, libxml2
, libxslt
, gst_all_1
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "yelp";
  version = "41.1";

  src = fetchurl {
    url = "mirror://gnome/sources/yelp/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "sha256-RWpkFWR7zusBWbkLNVP/MocozymmCPzggCQjJQTMuHQ=";
  };

  nativeBuildInputs = [
    pkg-config
    gettext
    itstool
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    glib
    webkitgtk_4_1
    sqlite
    libxml2
    libxslt
    gnome.yelp-xsl
    gnome.adwaita-icon-theme
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "yelp";
    };
  };

  meta = with lib; {
    homepage = "https://wiki.gnome.org/Apps/Yelp";
    description = "The help viewer in Gnome";
    maintainers = teams.gnome.members;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
