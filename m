From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 02/12] eeprom: at24: remove nvmem regmap dependency
Date: Mon, 2 May 2016 09:32:54 +0200
Message-ID: <20160502073254.GA2015@tetsubishi>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59081 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbcEBHdI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 May 2016 03:33:08 -0400
Content-Disposition: inline
In-Reply-To: <1461526096-29584-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, andrew@lunn.ch


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 24, 2016 at 08:28:06PM +0100, Srinivas Kandagatla wrote:
> This patch moves to nvmem support in the driver to use callback instead
> of regmap.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Andrew, since you did the NVMEM implementation, could you have a look at
this? That would be awesome. Thanks!

> ---
>  drivers/misc/eeprom/Kconfig |   1 -
>  drivers/misc/eeprom/at24.c  | 103 ++++++++++----------------------------=
------
>  2 files changed, 22 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index cfc493c..2d70464 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -3,7 +3,6 @@ menu "EEPROM support"
>  config EEPROM_AT24
>  	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
>  	depends on I2C && SYSFS
> -	select REGMAP
>  	select NVMEM
>  	help
>  	  Enable this driver to get read/write support to most I2C EEPROMs
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 089d694..de550a6 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -23,7 +23,6 @@
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/nvmem-provider.h>
> -#include <linux/regmap.h>
>  #include <linux/platform_data/at24.h>
> =20
>  /*
> @@ -69,7 +68,6 @@ struct at24_data {
>  	unsigned write_max;
>  	unsigned num_addresses;
> =20
> -	struct regmap_config regmap_config;
>  	struct nvmem_config nvmem_config;
>  	struct nvmem_device *nvmem;
> =20
> @@ -252,10 +250,10 @@ static ssize_t at24_eeprom_read(struct at24_data *a=
t24, char *buf,
>  	return -ETIMEDOUT;
>  }
> =20
> -static ssize_t at24_read(struct at24_data *at24,
> -		char *buf, loff_t off, size_t count)
> +static int at24_read(void *priv, unsigned int off, void *val, size_t cou=
nt)
>  {
> -	ssize_t retval =3D 0;
> +	struct at24_data *at24 =3D priv;
> +	char *buf =3D val;
> =20
>  	if (unlikely(!count))
>  		return count;
> @@ -267,23 +265,21 @@ static ssize_t at24_read(struct at24_data *at24,
>  	mutex_lock(&at24->lock);
> =20
>  	while (count) {
> -		ssize_t	status;
> +		int	status;
> =20
>  		status =3D at24_eeprom_read(at24, buf, off, count);
> -		if (status <=3D 0) {
> -			if (retval =3D=3D 0)
> -				retval =3D status;
> -			break;
> +		if (status < 0) {
> +			mutex_unlock(&at24->lock);
> +			return status;
>  		}
>  		buf +=3D status;
>  		off +=3D status;
>  		count -=3D status;
> -		retval +=3D status;
>  	}
> =20
>  	mutex_unlock(&at24->lock);
> =20
> -	return retval;
> +	return 0;
>  }
> =20
>  /*
> @@ -372,13 +368,13 @@ static ssize_t at24_eeprom_write(struct at24_data *=
at24, const char *buf,
>  	return -ETIMEDOUT;
>  }
> =20
> -static ssize_t at24_write(struct at24_data *at24, const char *buf, loff_=
t off,
> -			  size_t count)
> +static int at24_write(void *priv, unsigned int off, void *val, size_t co=
unt)
>  {
> -	ssize_t retval =3D 0;
> +	struct at24_data *at24 =3D priv;
> +	char *buf =3D val;
> =20
>  	if (unlikely(!count))
> -		return count;
> +		return -EINVAL;
> =20
>  	/*
>  	 * Write data to chip, protecting against concurrent updates
> @@ -387,70 +383,23 @@ static ssize_t at24_write(struct at24_data *at24, c=
onst char *buf, loff_t off,
>  	mutex_lock(&at24->lock);
> =20
>  	while (count) {
> -		ssize_t	status;
> +		int status;
> =20
>  		status =3D at24_eeprom_write(at24, buf, off, count);
> -		if (status <=3D 0) {
> -			if (retval =3D=3D 0)
> -				retval =3D status;
> -			break;
> +		if (status < 0) {
> +			mutex_unlock(&at24->lock);
> +			return status;
>  		}
>  		buf +=3D status;
>  		off +=3D status;
>  		count -=3D status;
> -		retval +=3D status;
>  	}
> =20
>  	mutex_unlock(&at24->lock);
> =20
> -	return retval;
> -}
> -
> -/*----------------------------------------------------------------------=
---*/
> -
> -/*
> - * Provide a regmap interface, which is registered with the NVMEM
> - * framework
> -*/
> -static int at24_regmap_read(void *context, const void *reg, size_t reg_s=
ize,
> -			    void *val, size_t val_size)
> -{
> -	struct at24_data *at24 =3D context;
> -	off_t offset =3D *(u32 *)reg;
> -	int err;
> -
> -	err =3D at24_read(at24, val, offset, val_size);
> -	if (err)
> -		return err;
> -	return 0;
> -}
> -
> -static int at24_regmap_write(void *context, const void *data, size_t cou=
nt)
> -{
> -	struct at24_data *at24 =3D context;
> -	const char *buf;
> -	u32 offset;
> -	size_t len;
> -	int err;
> -
> -	memcpy(&offset, data, sizeof(offset));
> -	buf =3D (const char *)data + sizeof(offset);
> -	len =3D count - sizeof(offset);
> -
> -	err =3D at24_write(at24, buf, offset, len);
> -	if (err)
> -		return err;
>  	return 0;
>  }
> =20
> -static const struct regmap_bus at24_regmap_bus =3D {
> -	.read =3D at24_regmap_read,
> -	.write =3D at24_regmap_write,
> -	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> -};
> -
> -/*----------------------------------------------------------------------=
---*/
> -
>  #ifdef CONFIG_OF
>  static void at24_get_ofdata(struct i2c_client *client,
>  		struct at24_platform_data *chip)
> @@ -482,7 +431,6 @@ static int at24_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
>  	struct at24_data *at24;
>  	int err;
>  	unsigned i, num_addresses;
> -	struct regmap *regmap;
> =20
>  	if (client->dev.platform_data) {
>  		chip =3D *(struct at24_platform_data *)client->dev.platform_data;
> @@ -612,19 +560,6 @@ static int at24_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>  		}
>  	}
> =20
> -	at24->regmap_config.reg_bits =3D 32;
> -	at24->regmap_config.val_bits =3D 8;
> -	at24->regmap_config.reg_stride =3D 1;
> -	at24->regmap_config.max_register =3D chip.byte_len - 1;
> -
> -	regmap =3D devm_regmap_init(&client->dev, &at24_regmap_bus, at24,
> -				  &at24->regmap_config);
> -	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "regmap init failed\n");
> -		err =3D PTR_ERR(regmap);
> -		goto err_clients;
> -	}
> -
>  	at24->nvmem_config.name =3D dev_name(&client->dev);
>  	at24->nvmem_config.dev =3D &client->dev;
>  	at24->nvmem_config.read_only =3D !writable;
> @@ -632,6 +567,12 @@ static int at24_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>  	at24->nvmem_config.owner =3D THIS_MODULE;
>  	at24->nvmem_config.compat =3D true;
>  	at24->nvmem_config.base_dev =3D &client->dev;
> +	at24->nvmem_config.reg_read =3D at24_read;
> +	at24->nvmem_config.reg_write =3D at24_write;
> +	at24->nvmem_config.priv =3D at24;
> +	at24->nvmem_config.stride =3D 4;
> +	at24->nvmem_config.word_size =3D 1;
> +	at24->nvmem_config.size =3D chip.byte_len;
> =20
>  	at24->nvmem =3D nvmem_register(&at24->nvmem_config);
> =20
> --=20
> 2.5.0
>=20

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXJwKlAAoJEBQN5MwUoCm2LqEQAKYRqDPyaF2b52f6DbduwJOA
ouNKKhwF4xz/9AZCd/Z9T2+H0t/zYtv3jUpuPPdOPdm0qtNg/Ybu2r0097+yz3nY
2Sg+AoWnfS6B01qXZ3ak2Jnp9IT6x8bWDowdcfW0MPG+OVdY8fEy3RO4pseLUVPs
tZDQZcwOXI/qmKs2rtfOcxNDbp7+npbdeU6FyUNgJhVC987PkJrxMlQ8nZVWvRSX
vFK0sw6ca00PRiQyTCtvqpMjLa/viUyMxFObEh6xMbxv3nHyHCqKBLB366+FhGWM
qi5apFEvBVLb6j9sgO05hoYV14QW8HthkEmmIqfQd/YoSHBRsuHvAzbKvH7HArXj
WXKGVZOI1tfyEXNQKxvP8sCuhJU9ni5bLdMyemmVp/NaX9ceiuxb9ak5aHHvoMEJ
smaHEFFjjAPl7/wLBLfb0fGNMgGjYsga4VRQw7+MTttYR249eQGg40XgjGBCA+Xn
qnvs+CRPy8vqcTLQ06U+p3y+5wVqV3IeT9CLr91rk6pnfKYH0ReGhRdVpUypQssx
bDLW777vtQmRGzwdmHIqkbIIMwn7vX6mv6FSzbROHmMistUaQYR9tL34C5ueMOcb
IRWnEOCXl0nFnQz77MbLQEdFFm9NCfQzPlpplRAEHzGjoQriMqx0aLoCC7MOGVEW
BdIws04KgXRXKvNUPxwY
=I1dt
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
