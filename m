From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/18] i2c: core: use new 8 bit address helper function
Date: Mon, 04 Apr 2016 13:27:50 +0300
Message-ID: <1459765670.2503.16.camel@linux.intel.com>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
	 <1459709101-24462-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20219 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbcDDK0x (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Apr 2016 06:26:53 -0400
In-Reply-To: <1459709101-24462-4-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Sun, 2016-04-03 at 20:44 +0200, Wolfram Sang wrote:

Even simple short commit message? Same to the rest.

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> =C2=A0drivers/i2c/i2c-core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0f2f8484e8ec1f..778d316de9f8ca 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2652,7 +2652,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t
> count)
> =C2=A0static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
> =C2=A0{
> =C2=A0	/* The address will be sent first */
> -	u8 addr =3D (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
> +	u8 addr =3D i2c_8bit_addr_from_msg(msg);
> =C2=A0	pec =3D i2c_smbus_pec(pec, &addr, 1);
> =C2=A0
> =C2=A0	/* The data buffer follows */

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
