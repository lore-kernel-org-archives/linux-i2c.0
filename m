From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] i2c: core: fix a code to suppress a warning
Date: Thu, 22 Oct 2015 14:48:03 +0300
Message-ID: <1445514483.22669.47.camel@linux.intel.com>
References: <1442574399-26131-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54764 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbbJVLsH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 07:48:07 -0400
In-Reply-To: <1442574399-26131-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On Fri, 2015-09-18 at 14:06 +0300, Andy Shevchenko wrote:
> There is a warning when compiling i2c-core.c
> drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
>=20
> Fix it by using a plain bitwise AND since I2C_M_RD is a bit 0 and
> thus we are
> on the safe side.

Wolfram, as of today I didn't see this in linux-next. Should I amend
this one somehow?

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/i2c/i2c-core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5f89f1e..a732107 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2555,7 +2555,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t
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
