From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] i2c: core: Add support for best effort block
 read emulation
Date: Wed, 15 Apr 2015 17:55:10 +0200
Message-ID: <20150415155510.GB914@katana>
References: <1427294000-32406-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427294000-32406-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 04:33:20PM +0200, Irina Tirdea wrote:
> There are devices that need to handle block transactions
> regardless of the capabilities exported by the adapter.
> For performance reasons, they need to use i2c read blocks
> if available, otherwise emulate the block transaction with word
> or byte transactions.
>=20
> Add support for a helper function that would read a data block
> using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
> I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.
>=20
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>=20
> Hi,
>=20
> This is a new API proposal to handle i2c block emulation in the
> core instead of the driver code.
>=20
> This is needed for a set of iio sensor changes ([1], [2], [3])
> that would otherwise duplicate this code. There are also some
> usages of this functionality in the kernel (e.g. eeprom driver at24).
>=20
> Please let me know what you think.

I am open to add something like this. One change I'd like to request is
to introduce a user, e.g. convert at24.

>=20
> Thanks,
> Irina
>=20
> [1] https://lkml.org/lkml/2015/2/16/408
> [2] https://lkml.org/lkml/2015/2/16/413
> [3] https://lkml.org/lkml/2015/2/16/402
>=20
>  drivers/i2c/i2c-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c.h    |  3 +++
>  2 files changed, 65 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index fe80f85..2579f7d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2907,6 +2907,68 @@ trace:
>  }
>  EXPORT_SYMBOL(i2c_smbus_xfer);
> =20
> +/**
> + * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @length: Size of data block; SMBus allows at most 32 bytes
> + * @values: Byte array into which data will be read; big enough to hold
> + *	the data returned by the slave.  SMBus allows at most 32 bytes.

Sidenote: SMBus3 allows 255 byte, but we don't support that (yet), so
this is okay for now.

> + *
> + * This executes the SMBus "block read" protocol if supported by the ada=
pter.
> + * If block read is not supported, it emulates it using either word or b=
yte
> + * read protocols depending on availability.

Here I'd like to see a warning that people should double-check if their
I2C slave does support that. Sometimes one can't exchange a block
transfer with a byte transfer.

> + */
> +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *c=
lient,
> +					      u8 command, u8 length, u8 *values)
> +{
> +	u8 i;
> +	int status;
> +
> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		length =3D I2C_SMBUS_BLOCK_MAX;
> +
> +	if (i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		return i2c_smbus_read_i2c_block_data(client, command,
> +						     length, values);
> +	} else if (i2c_check_functionality(client->adapter,
> +					   I2C_FUNC_SMBUS_READ_WORD_DATA |
> +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {

What about skipping the need for READ_BYTE_DATA and dump the byte which
was maybe read too much?

> +		for (i =3D 0; (i + 2) <=3D length; i +=3D 2) {
> +			status =3D i2c_smbus_read_word_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status & 0xff;
> +			values[i+1] =3D status >> 8;
> +		}
> +		if (i < length) {
> +			status =3D i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status;
> +			i++;
> +		}
> +		return i;
> +	} else if (i2c_check_functionality(client->adapter,
> +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +		for (i =3D 0; i < length; i++) {
> +			status =3D i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status;
> +		}
> +		return i;
> +	}
> +
> +	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%d\n",
> +		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
> +		I2C_SMBUS_BYTE_DATA);
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);

Thanks,

   Wolfram


--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLoneAAoJEBQN5MwUoCm2uuAP/2WxLymPKE+ngCVX7aVK7/9P
6h+tkjBaW+6i5kFLfF81PvxY5ID3PvZJrQn1nAGkoEe3ZufDRkDo6d4aoNV9ojXJ
JGKimoXbl3MBINOl0CzgK7iXLOAjkEklYm4ikuZR+N1MOqhzUrKGZxDRWx4ML0CA
SNvfLafT8kHlhfJPfWx6qzR3VLE2dS9LEm2ogQ+kXzABBYGYnapP2LJslHdMLdTX
fLt+SRn9EfUBSzcg5TmgluHuLeE2IsoSp9ZK3q7eu4QlwDagGq8cv5rhks/fmuDY
Wu9y5RLjilu0PVSnIbZhBlvy26d2zR1D1bIDX8GH9jRTM6Uvnfz9oRARZ6cQGJHb
a4MEF1vtPGKYAeq2jtX62OJmso4uamWn6Bcpq6JgZkuxs8XpDLmuFlWR8E1Kt+V0
X0WKl6XLyPtSDaYcfs78Vr5+VksAoCoKvb1AKbj4R7c01kiVQI3E0ptldwTL3TCx
ytGGYi91P2J3GFKvtWtCTQwBjz1GKMYuAVoK9JWGZFtTLV0zW2FTR2hvIxxC7EuV
ABGXVgtpelSxqKKuv16TNgvf/8/xVUbHe+kVTyXbUZcyydYmoamnrtJ51LwzFw1H
AZ4nM4e6dFDpRrgt0pNX3bf5/dKYrl2rGTY0RwYkjUkFrrCmtV3qbNcR1/c24UtZ
iFs+8ZQtmme6UlOOnXlf
=w4TX
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
