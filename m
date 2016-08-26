From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: designware-baytrail: Fix the Kconfig dependency
 fix
Date: Fri, 26 Aug 2016 17:46:40 +0200
Message-ID: <20160826154640.GB1608@katana>
References: <20160722102403.5c2d3c7e@endymion>
 <20160825202425.GH1614@katana>
 <20160826174041.720d29bb@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51571 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753585AbcHZPqp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Aug 2016 11:46:45 -0400
Content-Disposition: inline
In-Reply-To: <20160826174041.720d29bb@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I applied a patch from Jarkko on 19.6.2016 which also changed the
> > dependencies. Not sure if it is equal to your change, but this patch
> > doesn't apply anymore.
>=20
> As I understand it, Jarkko's patch sets the same dependencies my patch
> was setting, just expressed differently. So we are good, you can drop
> my patch.

Will do, thanks for the heads up!


--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXwGRgAAoJEBQN5MwUoCm2HrMP/idNC9GMggfCSF1crUtY4JeR
AGOIB3t/LrRb1nEPBGFk5M0Kr7KRSbwMdK/yrjy9bLpXHfyU2EOD7MdauC2svdRl
z8Fdg4cyQyfuxrZPdh9D8DpJcewM+OTcPjNLcSGoqO8KuxA1tOHLRMUtHBtHezwh
YFz98XJwtNwtLihKi1WSN7WhEo02QFU44Q9ZOVY3tEczKEJzbLnUo5YB4gJ5x0eJ
vFg1Nmki6TOJwco9uNyf/rlIx3+C2N5DwV5z1fW2jfAo9IHF0IXtF3sMTWnKMAnp
GPtCNiHy2GhND5g57mvzHeTngCptSe6nQVzwgmGnzeQwE6shTeO2wMGDY3GFNC0P
fZTxdifHJ15aI84wAILdzGZoc3Sy0ot2vgG/T2iSXp+ra+wB4KT+AE9hLJKf6xeV
Ls5xLFbAFCNd93r4UOmxCuzdrjICpbiBrHXLATNy1C8dyE/qhNLisWCUlbB+yJNS
CqiMwOEdNvtuGhfSCDxdjd4JmlV/fdOU9AbXUvDSTj837zdqeipgs2i9bmE2G4/0
EJM2m40QJ3w0FBCz/nvB8QpNEYNMFkQ2/Nut02aXNHEUjbsIIJPqU5KT/kqgGmAt
tUMnBnDT+MviyTaUmSdV/za24PTQzOuMRiTmq7et7K2W7bSSsH10gmpa/DHYpOuG
7fduKbq8n+iP4eEAuuAT
=V8Ph
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
