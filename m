From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: ismt: Add Intel DNV PCI ID
Date: Tue, 12 Apr 2016 23:45:07 +0200
Message-ID: <20160412214507.GH1526@katana>
References: <1460119268-23338-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59692 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757409AbcDLVpW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 17:45:22 -0400
Content-Disposition: inline
In-Reply-To: <1460119268-23338-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, scott.lawson@intel.com, alexandra.yates@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 03:41:08PM +0300, Mika Westerberg wrote:
> Intel DNV has the same iSMT SMBus host controller than Intel Avoton. Add
> DNV PCI ID to the list of supported devices.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-current, thanks!


--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDWxjAAoJEBQN5MwUoCm2ON4QALWdO0HGKDxBOiDgIwyFfUFV
UYCM7ohqXGH4T7pFGt1KK1nDw+8ZR/O0HhvKnu2HYuDXGAkQnBFZqf3GXkCv/lZ8
zyOq4PnO1g3iiPAVu9z9KyYPAlR9GFfrOUFo9p3OnfpmcG0bTmy/+pRoYatBqyKp
UroRNf8rPRAyTYpGKMjfy6HGj2vrk3ZJk9TlvHJC+BQ/vpmaNr24pJ6plgHq1otA
tBLjRJMzITyYbFxijmlNtPK2VdrZz7d3FBPZTm16GCQ2mQR4/inXzdT5dk71vhrf
PYk10/THsBBfVb9723M+YnJHIQ0qmHJQWN3ffj1gznDtGy14Xhk8pn+FHz+Bn94o
XtE5YCKz+cmH/dlEsjv/Tmr0pc3GkAZrpW0VX3nop++RzbybGnPp10LtaSCqoqyi
QUIwKbCNriVVfFaOiT1Sg8+8YRP7yC8OPDCR6HEXQyWl/ygfjflV0pOvgof+e/2S
rYpKC/3TzsRBTbtYyPOOuiGUQ16zGdCIGG8sAUpoNK/FqO1tFdK5PXjg/LeiHoJ1
ZY4fktQbxNqM3eNYosaT4KM9/7hVrCGUWwWZx+aDd3yH+2M5y3nPsE1VIRMHLeS+
EJuYRiDDOCXGdXsa9HKfL5y9hUUcpYz5sscQ6lqATFrRzROwXsnVT2drLKDQI1b1
dxCcRm9Ho+GdwvMALoJg
=0P9c
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--
