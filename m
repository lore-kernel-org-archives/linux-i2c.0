From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] i2c: eeprom: at24: Provide an EEPROM framework interface
Date: Wed, 13 May 2015 22:36:46 +0200
Message-ID: <20150513203646.GI4004@lukather>
References: <1431502697-31333-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431502697-31333-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matt Porter <mporter@konsulko.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-i2c@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pantelis,

On Wed, May 13, 2015 at 10:38:17AM +0300, Pantelis Antoniou wrote:
> For DT and in-kernel users there is no interface to the
> at24 EEPROMs so provide an EEPROM framework interface.
>=20
> This allows us to use AT24 based EEPROMs and reference them
> from within the DT tree.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

You should probably mention that the EEPROM framework hasn't been
merged yet.

> ---
>  drivers/misc/eeprom/at24.c | 222 +++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 174 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2d3db81..afa719a 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2005-2007 David Brownell
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
> + * Copyright (C) 2015 Pantelis Antoniou, Konsulko Group
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -23,6 +24,9 @@
>  #include <linux/of.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/at24.h>
> +#include <linux/regmap.h>
> +#include <linux/eeprom-provider.h>
> +#include <linux/io.h>
> =20
>  /*
>   * I2C EEPROMs from most vendors are inexpensive and mostly interchangea=
ble.
> @@ -63,12 +67,16 @@ struct at24_data {
>  	 * but not from changes by other I2C masters.
>  	 */
>  	struct mutex lock;
> -	struct bin_attribute bin;
> =20
>  	u8 *writebuf;
>  	unsigned write_max;
>  	unsigned num_addresses;
> =20
> +	struct regmap_config *regmap_config;
> +	struct regmap *regmap;
> +	struct eeprom_config *eeprom_config;
> +	struct eeprom_device *eeprom_dev;
> +
>  	/*
>  	 * Some chips tie up multiple I2C addresses; dummy devices reserve
>  	 * them for us, and we'll use them with SMBus calls.
> @@ -131,6 +139,8 @@ static const struct i2c_device_id at24_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, at24_ids);
> =20
> +static DEFINE_IDA(at24_ida);
> +
>  /*----------------------------------------------------------------------=
---*/
> =20
>  /*
> @@ -301,17 +311,6 @@ static ssize_t at24_read(struct at24_data *at24,
>  	return retval;
>  }
> =20
> -static ssize_t at24_bin_read(struct file *filp, struct kobject *kobj,
> -		struct bin_attribute *attr,
> -		char *buf, loff_t off, size_t count)
> -{
> -	struct at24_data *at24;
> -
> -	at24 =3D dev_get_drvdata(container_of(kobj, struct device, kobj));
> -	return at24_read(at24, buf, off, count);
> -}
> -
> -
>  /*
>   * Note that if the hardware write-protect pin is pulled high, the whole
>   * chip is normally write protected. But there are plenty of product
> @@ -432,21 +431,10 @@ static ssize_t at24_write(struct at24_data *at24, c=
onst char *buf, loff_t off,
>  	return retval;
>  }
> =20
> -static ssize_t at24_bin_write(struct file *filp, struct kobject *kobj,
> -		struct bin_attribute *attr,
> -		char *buf, loff_t off, size_t count)
> -{
> -	struct at24_data *at24;
> -
> -	if (unlikely(off >=3D attr->size))
> -		return -EFBIG;
> -
> -	at24 =3D dev_get_drvdata(container_of(kobj, struct device, kobj));
> -	return at24_write(at24, buf, off, count);
> -}
> -
>  /*----------------------------------------------------------------------=
---*/
> =20
> +/* panto: using the EEPROM framework macc is superfluous */
> +

Is it? it was kind of one of the point to be able to remove the memory
accessors stuff (which is only used by that driver btw).

>  /*
>   * This lets other kernel code access the eeprom data. For example, it
>   * might hold a board's Ethernet address, or board-specific calibration
> @@ -492,6 +480,91 @@ static void at24_get_ofdata(struct i2c_client *clien=
t,
>  { }
>  #endif /* CONFIG_OF */
> =20
> +static int regmap_at24_read(void *context,
> +			    const void *reg, size_t reg_size,
> +			    void *val, size_t val_size)
> +{
> +	struct i2c_client *client =3D context;
> +	struct at24_data *at24;
> +	unsigned int offset;
> +	int ret;
> +
> +	/* reg bits is hardcoded to 32 bits */
> +	BUG_ON(reg_size !=3D 4);
> +	offset =3D __raw_readl(reg);
> +
> +	at24 =3D i2c_get_clientdata(client);
> +	if (at24 =3D=3D NULL)
> +		return -ENODEV;
> +
> +	/* val bytes is always 1 */
> +	BUG_ON(at24->regmap_config->val_bits !=3D 8);
> +
> +	ret =3D at24_read(at24, val, offset, val_size);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D val_size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int regmap_at24_gather_write(void *context,
> +				    const void *reg, size_t reg_size,
> +				    const void *val, size_t val_size)
> +{
> +	struct i2c_client *client =3D context;
> +	struct at24_data *at24;
> +	unsigned int offset;
> +	int ret;
> +
> +	at24 =3D i2c_get_clientdata(client);
> +	if (at24 =3D=3D NULL)
> +		return -ENODEV;
> +
> +	BUG_ON(reg_size !=3D 4);
> +	offset =3D __raw_readl(reg);
> +
> +	/* val bytes is always 1 */
> +	BUG_ON(at24->regmap_config->val_bits !=3D 8);
> +
> +	ret =3D at24_write(at24, val, offset, val_size);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D val_size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int regmap_at24_write(void *context, const void *data, size_t cou=
nt)
> +{
> +	struct i2c_client *client =3D context;
> +	struct at24_data *at24;
> +	unsigned int reg_bytes, offset;
> +
> +	at24 =3D i2c_get_clientdata(client);
> +	if (at24 =3D=3D NULL)
> +		return -ENODEV;
> +
> +	reg_bytes =3D at24->regmap_config->reg_bits / 8;
> +	offset =3D reg_bytes;
> +
> +	BUG_ON(reg_bytes !=3D 4);
> +	BUG_ON(count <=3D offset);
> +
> +	return regmap_at24_gather_write(context, data, reg_bytes,
> +			data + offset, count - offset);
> +}
> +
> +static struct regmap_bus regmap_at24_bus =3D {
> +	.read =3D regmap_at24_read,
> +	.write =3D regmap_at24_write,
> +	.gather_write =3D regmap_at24_gather_write,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,

I wouldn't expect the content of the EEPROM to change of endianness
when we change the kernel's.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU7XeAAoJEBx+YmzsjxAgmjwQAJTi+M7MRT7IatNNUFB8F+Eb
RVhYKqZLKcM0N7SlHb+RZ8+AZR7iefkIzxvJKAGnJ7gZQCElpbggVE55RCApYEru
bToDFE+pRzGGo1I+Nt9MT4PgWORSl6lBJ+hEbKDtG7GpqW+WFrDazY5bbkwGLCue
zvrynincpAwJNxq+V4WjA+mesARJZ5VthhXH7zDDz9j9N2DVT2ZYwMawEEf0prds
O10LRi8PJ+9a2kFsyD7E6DfTnllu1LYEVUTwT9j5OIcV8l1JLEPsd2go5pNnq/r3
QPQ5VEtWbRRE4Kp462dRFSwte3e12lG4mTcTL9MgINOa0aFs41SS4+xkAa9J96VC
LY6t9j2rXAFC1ed74GEuV431TIQronTinaVa3pk70NHrQH6BD5HFUUhevGZywyzz
18DJrf7tVZacDTorYGAtiFjZwI6rROq712M/SlmN5syhDyP3DrNUMjOiaq927dUB
cNQkmlnPY3KCuqmMKnnUKhi61Myc3Gy3zLUFr6Yg4wU9yQ9HNmcn27h5Ytn4hql7
3NdVI74DNUx+M1q7tz18eNgl5jd4NZ9qqUIl17p4QQBwoN/S0LTMeSoitCz3Y984
7Zjjuxn6iEOQ64zH42XjSdpX6wkeJTkdsfGhc42i6ag12Hn0gi5iKJqTf2P86RRu
BYUDO6N2UlZO5uFnM3hY
=KxRo
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
