From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Thu, 15 Sep 2016 21:41:47 +0200
Message-ID: <20160915194146.GB7863@katana>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50093 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755049AbcIOTmT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Sep 2016 15:42:19 -0400
Content-Disposition: inline
In-Reply-To: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
> This patchset adds a specific compatible string in the Meson I2C driver
> for the Amlogic Meson gxbb SoC.
>=20
> Other patch series (pinctrl and device tree) are being sent to complete
> the i2c support on meson gxbb
>=20
> Neil Armstrong (2):
>   i2c: meson: add gxbb compatible string
>   dt-bindings: i2c-meson: add gxbb compatible string

Squashed both patches and applied to for-next, thanks!


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2vl6AAoJEBQN5MwUoCm2CyEP/086DOOEtIlDpYTX2yQIHb78
7LK6RVSsT2VZnd2ncj4+jH410hMKMtkT05evfmjoYQ30fy+9peS3r9WrWDNRcpn0
YLvJc+oBw+ME0l/FG31ckHHj0bVqFdPn2sLa6oA4zM/xYWeUWaBYQ8CAP261JTE8
lpOlerdeeabUtmmtrqY/GcW27pCdzz7/gmlj6E+elE3nN3hI6ialkpef32uVPFAH
RILcKMY48L/z7OYhf1xjU80rgFR6Eab0XTOgubUpO4a6M0BM95V/KUd+lH0d8zzw
atLGjuWhijTbN7Jv2MtsgBN15QFbOtb3DwYMs7QJmUFD0J4kxJrVpEPlvkYnyLJR
cvnrXEYIJYiyRuM3rxSSqjrq46TtjoMvnRi7pf/SG2L0kwyM1191V+vsMojy9w8m
UjLCW6gYzJ9rZIZMZvn8Dau2JJyHrLa7NyV4fFBvAanF0FQZrFYX5uBMxCIlz9Rt
Gv4pKwXGpH94YwDLxx1XRg+nB1NY9oO2pmGltnkxJxLAF7z60/7SlHem0P4TUr7e
/C/t47/Jnk+ERGzYOGUSRG9jRZo5of1NKXAuxDsIca/aNlCDNpqnMZeQveMY0egw
e1pJsogT4LGPBFlKDRhhEImLOD1zWVMlpZZ1xXhIDleuNt6NGZFK+CYWpCq5MQ4b
XBXLnMK9iDuyK6b8uhOQ
=bfFd
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
