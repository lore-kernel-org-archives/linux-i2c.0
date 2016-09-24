From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i801: Add support for Kaby Lake PCH-H
Date: Sat, 24 Sep 2016 10:57:59 +0200
Message-ID: <20160924085759.GD1434@katana>
References: <20160923085601.166121-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58856 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756764AbcIXI6F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 04:58:05 -0400
Content-Disposition: inline
In-Reply-To: <20160923085601.166121-1-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 11:56:01AM +0300, Mika Westerberg wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Intel Kaby Lake PCH-H has the same legacy SMBus host controller than Intel
> Sunrisepoint PCH. It also has same iTCO watchdog on the bus.
>=20
> Add Kaby Lake PCH-H PCI ID to the list of supported devices.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kAXAAoJEBQN5MwUoCm2cWYP/jiFaOkYkFjUOXGU55jg4dXO
w+t7oxPpzyhrmhW+iAIg2VRluflqjsFFIauMSacekH7sBTX2crYD2Dnhl01dppR2
tsMT8uhMkgGXarRDRGFti64CoVI6wSAoa/8hVAm5oK65S8gda0QT841JlUbfjTT/
MNE+qUa0xuBl8Pg2z33pE12Wu6vSPCdg1YRrW5jZNQKdirkyFlh+KUbzhVMh0KBJ
3HcotQT9HS0ZhR5RBzcZucYVtCFEJFsnRRQmkBef6K47lvgfMMrQLE/mODbb3Q9F
i7GJcWBZPWfdTesMvojBu5uNe8/D+DuV36cvtxKpyFQXPcohTXLznGI+2rThbU1m
kWaTrlUd6m7gWaYrj+7hk2Bxq4/JeMIi1RQ42v0hkOw7Ke1TNZBaN0+qtW7kdKO4
b+uYm/3pXWTWiIgeZXXq49zU1S7nTrPSS9AzhzjeUTVnFDIOCDRIdCweZRfsslam
iiqF80SJoyNOrbAHxo4oBCXPpxkO/v8pQcgPReSA6NlRQIUO4HYec0WTywd83038
KV10bCvK7DwmkoUCx2P+8bQxAtF67IZYbLDpG1D4FoYay+ag9GXztEjVPCyA3nQm
7rOOBwoXDZgRK4mbBkyCaY68Tm3SWrr0pDXCYsfh3at6yO2CB4pVP/X3KYqgUFUE
PFEVw0k4htAk9Mu34BTK
=czcn
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
