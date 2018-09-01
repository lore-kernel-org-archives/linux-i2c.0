From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 5/7] i2c: designware: add MSCC Ocelot support
Date: Sat, 1 Sep 2018 14:44:16 +0200
Message-ID: <20180901124416.GC1196@kunai>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
 <20180831151114.25739-6-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831151114.25739-6-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microchip.com>
List-Id: linux-i2c@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +int dw_i2c_of_configure(struct platform_device *pdev)

I made this 'static' as well.


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKiaAACgkQFA3kzBSg
KbYlpQ/8Dpz1rwpriPCRczKfGEpM49wx/FAypJOs0rSQQEjDcMgpYjRhUGZOHdL/
o/chajkvs1hyXilHjudAb99SuEqZyHk9cOJIoSurborwizJfsVRnZ0NIdb3BuWVb
XN8+eZ7CrEbWCOwv/PPC3glB9hkysLMOSU1xk4QPhTtAn1jv7LKd0ZN2HcALb6Ux
gTqjOxw26USwhuxswSP2LPO53SfHvdu83skDAtJSIcyDFRbDoXJELJBUzLvDS+LH
WuVNBSfUVKRGPK0GH/wB3ZQly5te0GDrMO6k1NQeJ8swGasTapDU9seEKAfcN0JO
NRsDDY0eJ/XcFMS2ew2+EH7B59rEhLuvNuZm6KvCf1xMcVeH01qGapOt17pQFkL7
1Aswcr/R512cI37O+HtwZY941lHX4f2/8nJ0LXnerxxJFZT1AnmBtoIuJRfCN+HV
EqezURSkVhHH6XhUxmsPPcG0L5IcHbu0RHbPaHa1AAVREk0anYXFyIY1JogrUHqs
XXowZch8YpIGsqLcussrU+noU49VCMuyllLr7K8pQHBvggTsuE3XFhGK9zTG5EFP
a0H3rHKDCCMH46F9s11MhvlCvRbjKd6vDKzzHCV/yU7qVP4h4sGcGEmjk2p8+pGq
n9MCZAfkMuoMpAwoACOP2TzGQonf0ZDMIzuPqux/+zMBE3foM0M=
=0MVY
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
