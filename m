From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND] i2c: Remove setting for 1 second timeout from
 adapter drivers
Date: Thu, 3 Dec 2015 21:52:28 +0100
Message-ID: <20151203205228.GC8509@katana>
References: <1449054154-32273-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36058 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315AbbLCUwc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Dec 2015 15:52:32 -0500
Content-Disposition: inline
In-Reply-To: <1449054154-32273-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 01:02:34PM +0200, Jarkko Nikula wrote:
> I2C adapter drivers that are using 1 second timeout can leave the timeout
> unset and let the i2c-core.c: i2c_register_adapter() to set it instead.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

My take on this is that I prefer the explicit (and thus visible)
assignment. What the core does was intended as a fallback to prevent
strange things happening with a 0 value.


--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYKuMAAoJEBQN5MwUoCm2eF8P/2v86758tuZNs9tlES410kY0
PY0j/nPQCR+DmG/W/78lolfcxuKx86mpXOQRKB6Dlx9mc2kVFfjwEtVo8D2dum9h
VMxjY3gPLirgUgLMzdB3R4DnmTBKXMm+Y6HkimiSq2rxV1rojuQyow7HqPl90hV7
NLg2MfGv/0Mbk7lRQNe3wd++MJmDAIGV7J796STg3+pJLsCC9uLxR38IuWsR/STV
bAbZIJAQ6pUYTs/BrZCOs1SOc0FLoEsQW0IDD7upGdlDX1FTf+ndZIUzQCU1iEsM
Sj37haqKjw4d3CFcrSywRNs3I5x6oaOKtpiqV8zf2Gz16BXNle5/lld1kxoKZi8Y
d07de60S/96TpRZVHM0Klz/IO81UmUBNcG+TD56fgiWVR9P9KS/r9FxiBK0XN1ha
xjjz/UUmfl6IkMNj8vg72v4TxmQpRSh2269oM789JMs/pZt9xNabK2nmUSb0l38p
hYE6flvdyzGSC3P9w7LzYK8cS0HplL7i4wd69oAMaFakq0luCa93JvNNdxe88fJK
KUVJy3Fmf5JLZ38R88u8XR4y+XHSwnOt1roTXRSt/YhrFDASopSL3HFNnDepLXyA
T16vBril5frMckbW3E0xChHi6BO9YvSs8ubtWdeo6wjWEG9rxIM/5chtB9XkiwSH
bnofwayL6OS9UESADkpb
=6MHA
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
