From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: allow configuration of imx driver for ColdFire
 architecture
Date: Tue, 25 Oct 2016 11:24:41 +0200
Message-ID: <20161025092440.GD1597@katana>
References: <1476669245-3678-1-git-send-email-gerg@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49205 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755975AbcJYJYp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 05:24:45 -0400
Content-Disposition: inline
In-Reply-To: <1476669245-3678-1-git-send-email-gerg@linux-m68k.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-i2c@vger.kernel.org, angelo@sysam.it


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2016 at 11:54:05AM +1000, Greg Ungerer wrote:
> The i2c controller used by Freescales iMX processors is the same
> hardware module used on Freescales ColdFire family of processors.
>=20
> We can use the existing i2c-imx driver on ColdFire family members.
> Modify the configuration to allow it to be selected when compiling
> for ColdFire targets.
>=20
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Applied to for-current, thanks!


--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyTYAAoJEBQN5MwUoCm2nR4P/RNVYzQR99iRc/2aEOh7JfR/
vzF374pPeWPnJRta5bAkjux73Ghp+aB5H0uANwxfQX5fQ+OJuww5SMq1pxc3QGHz
+U88HybmA33S4b9h5sB6tlLs8KkqzHxgfpvgJJcYe3pP/A6eGSM3B/IQvaVR1pSe
Y+Mk9YZ9aDX6ycvJ5CUEUiMFdKZaxo77my5kvJSGcQVKz13QtZaThAuFpASN1X2E
15JS687dU5SG9KUx1U973GZuEnIDMAzfUkfTMjDd62hsm12LRxVxnQRj2TW5N4HI
6bX0HTOoNIybFP8mZs3PaAqFiketZHx3bti5rmeGIZtDOSFBx/+LPBvwek/tsUP7
BiefmYmKD8HIKUUmBg1npevA0JeocJsNYM8INWdshJkX1Ckr7aOGlr/3aaOVovl7
S1ZZA5GhDYHCGHgUyHVxIgLInznwkwA9D+ZBLME95FQE+a0ota+dqZ49VUyH4GbA
WIlbjWOwn5O9YzjILMlv3DksRMXPSr1mA91kKYyyL39aAqjN5PhUdwsbgsano9+w
m99ylLMPjZ6MfSz2AVR6nlJKX15Wp76zxlP9lGZaIc2nM43Peq/UXSgB1wxXfOaj
TuQrp9ODmNErWDg6Z2eZLl0aUs9tPToQWfp1+iQhoJDVWrjjK2oGCN6Jz6VR6suS
wIOqj+nyRWJv35Bdcq4T
=xI8Q
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
