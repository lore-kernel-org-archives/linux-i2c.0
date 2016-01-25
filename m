From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/1] i2c: core: replace boolean variable by integer
Date: Mon, 25 Jan 2016 10:55:44 +0200
Message-ID: <1453712144.2521.213.camel@linux.intel.com>
References: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65062 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbcAYIzN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jan 2016 03:55:13 -0500
In-Reply-To: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>

On Thu, 2015-11-19 at 18:11 +0200, Andy Shevchenko wrote:
> There is a warning when compiling i2c-core.c
> drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
>=20
> Replace boolean exdpression by a plain bitwise AND since I2C_M_RD is
> a bit 0
> and thus we are on the safe side.

Wolfram, any news about this change? Last time I remember you talked
about your series which makes this change obsolete.

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Alexander Sverdlin <aleaxander.sverdlin@nokia.com>
> ---
> Changelog v3:
> - add tag
> - rephrase commit message
> =C2=A0drivers/i2c/i2c-core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 040af5c..873ca1c 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2591,7 +2591,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t
> count)
> =C2=A0static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
> =C2=A0{
> =C2=A0	/* The address will be sent first */
> -	u8 addr =3D (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
> +	u8 addr =3D (msg->addr << 1) | (msg->flags & I2C_M_RD);
> =C2=A0	pec =3D i2c_smbus_pec(pec, &addr, 1);
> =C2=A0
> =C2=A0	/* The data buffer follows */

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
