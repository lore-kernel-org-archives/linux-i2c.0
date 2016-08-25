From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/8] i2c: designware: Support fast mode plus and high
 speed
Date: Thu, 25 Aug 2016 21:55:26 +0200
Message-ID: <20160825195526.GD1614@katana>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46958 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbcHYT4o (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 15:56:44 -0400
Content-Disposition: inline
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 05:02:46PM +0300, Jarkko Nikula wrote:
> Patches here were posted before for v4.8 but got dropped due merge
> conflicts with changes coming from ACPI subsystem.
>=20
> http://www.spinics.net/lists/linux-i2c/msg24699.html
> http://www.spinics.net/lists/linux-i2c/msg24857.html
>=20
> I promised to resend both sets together since my set doesn't have much use
> without Weifeng's set and my patches are done on top of it.
>=20
> Patches 1-4/8 are same than before. Patch 5/8 had tiny conflict with the
> ed1bf03470b8 ("i2c: designware-pci: Make bus number allocation robust")
> because both added the DW_IC_CON_SPEED_MASK.
>=20
> Patches 6-7/8 are a bit larger due conflicts with the
> commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure
> notifications"). No changes in patch 8/8.

Applied to for-next, thanks!


--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXv00tAAoJEBQN5MwUoCm2ojUQAKCt9MBDAOcrax09P0SjLnpZ
EkSjhc4mWpArQixwohI0a53dUsQ+GLdAWCGtEW70vJYL7YEAVNAoTcfivb2zEjg1
2KzzuyI8N4OwSDHejvvB3oEsEB2iC9hAHN1A4PHl38jY//VSerFqpHmDrBD2fYi7
d1n8dDu67yrU+Pj318o5xQrSFDZ1XSbayt32tjZvjghoWtvDfY6mhk0qxzfy4rUj
XK5S5Lgxo4NMX2p67XqoDMMn+gdt6iAvq3BDwMD+WYX+MXX45ALWluZG1iTazo8I
GQMK//aIaXH3p9TaGk8nUatHTdEYP9BFmb678CyZefnJHCk25U6tbuZObkypJwHz
2RfEAziV1hr+2f7ORL+ZqVA2e5mYEsovKKiYBSQd+Ugh7QtiaIn9/n1kOdEMZnLI
Jewlx3eBG3gobCHNK2LX9SMe28GcyDAK0z0MoMbMdqLdbwtCsxMQmcMgQWi/wM1g
9nRBqLPl7VoWOCZSwUUUTfJK2MYLXs1MO1flxfrd7S4vbRAgxWKnAc6UI3q7Gpv/
i9vvfBrAFcVHuZUAKh+3WOAg/KYyD6X3gG+CbG+jlt3W/ZHjuk1AFNGJncvpxTyb
KJJDU7bhy4HC8+mHiQDND0eU4IjZxEtSK1oUSm9ConZhctrtpUHGp+TRuyYENpfh
VFR8Fe62RrQWMedrtjj0
=+1BO
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
