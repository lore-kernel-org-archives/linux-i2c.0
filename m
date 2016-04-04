From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/18] i2c: guarantee that I2C_M_RD will be 0x0001
 forever
Date: Mon, 04 Apr 2016 13:26:11 +0300
Message-ID: <1459765571.2503.15.camel@linux.intel.com>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
	 <1459709101-24462-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15480 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbcDDKZP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Apr 2016 06:25:15 -0400
In-Reply-To: <1459709101-24462-2-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Sun, 2016-04-03 at 20:44 +0200, Wolfram Sang wrote:
> There is code out there in user space and kernel space which relies
> on
> I2C_M_RD being bit 0 to simplify their bit operations. Add a comment
> to
> make sure this will never break. Do proper sorting of the defines
> while
> we are here.

Didn't see a comment as stated though.

>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> =C2=A0include/uapi/linux/i2c.h | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> index b0a7dd61eb353a..adcbef4bff610a 100644
> --- a/include/uapi/linux/i2c.h
> +++ b/include/uapi/linux/i2c.h
> @@ -68,14 +68,15 @@
> =C2=A0struct i2c_msg {
> =C2=A0	__u16 addr;	/* slave address			*
> /
> =C2=A0	__u16 flags;
> -#define I2C_M_TEN		0x0010	/* this is a ten bit
> chip address */
> =C2=A0#define I2C_M_RD		0x0001	/* read data, from
> slave to master */
> -#define I2C_M_STOP		0x8000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> -#define I2C_M_NOSTART		0x4000	/* if
> I2C_FUNC_NOSTART */
> -#define I2C_M_REV_DIR_ADDR	0x2000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> -#define I2C_M_IGNORE_NAK	0x1000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> -#define I2C_M_NO_RD_ACK		0x0800	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> +					/* I2C_M_RD is guaranteed to
> be 0x0001! */
> +#define I2C_M_TEN		0x0010	/* this is a ten bit
> chip address */
> =C2=A0#define I2C_M_RECV_LEN		0x0400	/* length will
> be first received byte */
> +#define I2C_M_NO_RD_ACK		0x0800	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> +#define I2C_M_IGNORE_NAK	0x1000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> +#define I2C_M_REV_DIR_ADDR	0x2000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> +#define I2C_M_NOSTART		0x4000	/* if
> I2C_FUNC_NOSTART */
> +#define I2C_M_STOP		0x8000	/* if
> I2C_FUNC_PROTOCOL_MANGLING */
> =C2=A0	__u16 len;		/* msg length		=09
> 	*/
> =C2=A0	__u8 *buf;		/* pointer to msg data	=09
> 	*/
> =C2=A0};

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
