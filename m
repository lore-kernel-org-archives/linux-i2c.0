From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V8] i2c: imx: implement bus recovery
Date: Fri, 23 Oct 2015 14:43:51 +0200
Message-ID: <20151023124351.GO13380@katana>
References: <1445603334-7661-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35253 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbJWMn6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 08:43:58 -0400
Content-Disposition: inline
In-Reply-To: <1445603334-7661-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de, hkallweit1@gmail.com


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 08:28:54PM +0800, Gao Pan wrote:
> Implement bus recovery methods for i2c-imx so we can recover from
> situations where SCL/SDA are stuck low.
>=20
> Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> pinctrl to gpio mode by calling pinctrl sleep set function, and then
> use GPIO to emulate the i2c protocol to send nine dummy clock to recover
> i2c device. After recovery, set i2c pinctrl to default group setting.
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to for-next, thanks!


--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKiuHAAoJEBQN5MwUoCm25GQP/0wVYHKwsI8U04iG7hrGNfIi
96MhCczXuqp+SIbvu8FcVlsavhqc7bOCaRMS0mDkYzyYtwf9b6t2DnASEkzYeOpd
C8D/VCGlKIXOQ9WS701wjrrZ1robG0P3g3EKRZbQgAcO5Hgc16CeypoUxSUtSOSA
xu13bv//90loF3v/aQoZMAA8FsSBvnYRDfEkVRtand1VAv7fxmjB2jHQwkYFyeMY
DPrJdkNvDWubXm9OPpCIKV7ZtECwKu7tZjZ5xE0CaZHIiA9jlx6UVaXOBFogfBQG
SOxRrKbuUF5GTF8ZggsX6d5YjgLa/SGtXvXehux5mjPS9Q20jThY+/wUO1s6XMGE
LJyiY5eWOH7giWCdqoxcF8s8F+LJDOVmSZi4LbbyRBXEKh2P0Pzrq5r3MXd2KbRL
heV26JlKck834Ybt74Y2Kweqi7QlbusZDIK5KdOQ5A/xzS3DWW6DJepJV+nSuADb
/E3i+znMqsErs/jNqJJBek9Qx/A9df9giSmsNwJwpsqKGo38TpjuPX2gHrZhj00h
EHxIsOQa4mSmv+WoxkDgKvqKUFdsWMxEiKLNqkOBJ3ykeVDKDlRpwNRgN+IJohEb
gfAfq8k0p/WHOWXfSScvtlAy4BR3y7QWKRkV66Yny+6k9RkILZ8VqzsxkGrnKrbn
0iXWhY0QwPmfdoFUKX6K
=HARB
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
