From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 08:58:35 +0100
Message-ID: <20100311085835.34c6cd51@hyperion.delvare>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268268932-23447-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?UTF-8?B?RHJlw58=?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, 11 Mar 2010 01:55:32 +0100, Wolfram Sang wrote:
> Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requi=
rement.
>=20
> Reported-by: Albrecht Dre=C3=9F <albrecht.dress-KvP5wT2u2U0@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Depends on:
>=20
> http://thread.gmane.org/gmane.linux.drivers.i2c/5496
>=20
> ([PATCH V2] at24: Fall back to byte or word reads if needed)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 88c20da..d2deea4 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -541,6 +541,7 @@ static int at24_probe(struct i2c_client *client, =
const struct i2c_device_id *id)
>  	at24->bin.attr.mode =3D chip.flags & AT24_FLAG_IRUGO ? S_IRUGO : S_=
IRUSR;
>  	at24->bin.read =3D at24_bin_read;
>  	at24->bin.size =3D chip.byte_len;
> +	sysfs_bin_attr_init(&at24->bin);

I think it would make more sense to move the initialization _before_
manually setting other struct members. You don't know what
sysfs_bin_attr_init does or will do in the future.

> =20
>  	at24->macc.read =3D at24_macc_read;
> =20

I presume the at25 driver needs the same fix?

--=20
Jean Delvare
