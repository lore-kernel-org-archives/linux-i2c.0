From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
Date: Sun, 25 Oct 2015 09:25:02 +0100
Message-ID: <20151025082502.GB2159@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44695 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbbJYIZ3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 04:25:29 -0400
Content-Disposition: inline
In-Reply-To: <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, robert.jarzmik@free.fr, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "Jett.Zhou" <jtzhou@marvell.com>, Yi Zhang <yizhang@marvell.com>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 11:29:36AM +0530, Vaibhav Hiremath wrote:
> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
> of standard & fast mode in pxa910/988; so this patch adds these two new
> entries to "struct pxa_reg_layout" and "struct pxa_i2c".
>=20
> As discussed in the previous patch-series, the idea here is to add standa=
rd
> DT properties for ilcr and iwcr configuration fields.
> In case of Master ilcr is used for low/high time and in case of slave mode
> of operation iwcr is used for setup/hold time.
>=20
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Fixed this checkpatch warning:

CHECK: Please don't use multiple blank lines
#82: FILE: drivers/i2c/busses/i2c-pxa.c:157:
+
+

and applied to for-next, thanks!


--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLJHeAAoJEBQN5MwUoCm2jLwQAIjGLtit/jD/Db2pStrceMpg
4SrNvH0g93opUupaOQtT6/gXT+67/R6QCiJWtC07u6V+P4CRtzGPi9fllHCrL5ww
Y23TRF9ki0LSjCZ5iwJ47ZVZDvj4xfmZtYhPyTLg6yaFwHj4gNrSFi587WsO/BQy
1eBp60f4qTHk73xunKTzBKB1SMvnnVgECwoTeiuUqoe6ufuLjACHymY41J7OSoTl
Dey5sznnDzoyt3dS+kwzap4HGZjUX7/uLq1q0rxqnsgqH4lVcrvtlJ2RRFlsIQTd
KCv7akhVm/Log1nLHLBMmlG4Qa2AiALnx/tnlegS9jijMsrelmoI8qbUBm3XNpdl
zd6zFWCJDcqLOFLpbxPq9lhPvn4BN4N7lDzqfTUT4gFXh6ZiD2W8ErHb7GDMOyWC
uRS486mRy0244Jn5S82r59USnM87InLyaEuHxifeDslq9QFVgEtl4TjCgSUt5Wrt
wUVgbsEaBITw3GmkiF1zUrmbfOnTSNW7KpXiJ1t+uZiQ/2x9EoUgtCttQrusB04q
cGcKVr+JVDVnu/k3ChN+4LagkR3JixlDZyR83PGxWehhi1tVJN2O/NlFkfWOm6RL
GN8RS15YvTYfeiXaXce8BZpz3cFNwUzoUSPwOfYvx7cTfKnNXmMxcCsxHRFNUBGw
Rc8BrUBaswp7OKfP62E/
=AJmD
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
