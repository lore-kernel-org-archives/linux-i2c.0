From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: core: Reduce stack size of
 acpi_i2c_space_handler()
Date: Tue, 12 May 2015 21:05:05 +0200
Message-ID: <20150512190505.GB4449@schokonusskuchen.bad>
References: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1430311477-21759-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430311477-21759-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 03:44:37PM +0300, Jarkko Nikula wrote:
> sizeof(struct i2c_client) is 1088 bytes on a CONFIG_X86_64=3Dy build and
> produces following warning when CONFIG_FRAME_WARN is set to 1024:
>=20
> drivers/i2c/i2c-core.c: In function =E2=80=98acpi_i2c_space_handler=E2=80=
=99:
> drivers/i2c/i2c-core.c:367:1: warning: the frame size of 1152 bytes is
> larger than 1024 bytes [-Wframe-larger-than=3D]
>=20
> This is not critical given that kernel stack is 16 kB on x86_64 but lets
> reduce the stack usage by allocating the struct i2c_client from the heap.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Besides it should be squashed with the previous patch, I'm fine with
this. Mika?

> ---
>  drivers/i2c/i2c-core.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 051aa3a811a8..3f25d758d83e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -258,7 +258,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_ad=
dress command,
>  	struct acpi_connection_info *info =3D &data->info;
>  	struct acpi_resource_i2c_serialbus *sb;
>  	struct i2c_adapter *adapter =3D data->adapter;
> -	struct i2c_client client;
> +	struct i2c_client *client;
>  	struct acpi_resource *ares;
>  	u32 accessor_type =3D function >> 16;
>  	u8 action =3D function & ACPI_IO_MASK;
> @@ -269,6 +269,12 @@ acpi_i2c_space_handler(u32 function, acpi_physical_a=
ddress command,
>  	if (ACPI_FAILURE(ret))
>  		return ret;
> =20
> +	client =3D kzalloc(sizeof(*client), GFP_KERNEL);
> +	if (!client) {
> +		ret =3D AE_NO_MEMORY;
> +		goto err;
> +	}
> +
>  	if (!value64 || ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
>  		ret =3D AE_BAD_PARAMETER;
>  		goto err;
> @@ -280,74 +286,73 @@ acpi_i2c_space_handler(u32 function, acpi_physical_=
address command,
>  		goto err;
>  	}
> =20
> -	memset(&client, 0, sizeof(client));
> -	client.adapter =3D adapter;
> -	client.addr =3D sb->slave_address;
> +	client->adapter =3D adapter;
> +	client->addr =3D sb->slave_address;
> =20
>  	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> -		client.flags |=3D I2C_CLIENT_TEN;
> +		client->flags |=3D I2C_CLIENT_TEN;
> =20
>  	switch (accessor_type) {
>  	case ACPI_GSB_ACCESS_ATTRIB_SEND_RCV:
>  		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_byte(&client);
> +			status =3D i2c_smbus_read_byte(client);
>  			if (status >=3D 0) {
>  				gsb->bdata =3D status;
>  				status =3D 0;
>  			}
>  		} else {
> -			status =3D i2c_smbus_write_byte(&client, gsb->bdata);
> +			status =3D i2c_smbus_write_byte(client, gsb->bdata);
>  		}
>  		break;
> =20
>  	case ACPI_GSB_ACCESS_ATTRIB_BYTE:
>  		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_byte_data(&client, command);
> +			status =3D i2c_smbus_read_byte_data(client, command);
>  			if (status >=3D 0) {
>  				gsb->bdata =3D status;
>  				status =3D 0;
>  			}
>  		} else {
> -			status =3D i2c_smbus_write_byte_data(&client, command,
> +			status =3D i2c_smbus_write_byte_data(client, command,
>  					gsb->bdata);
>  		}
>  		break;
> =20
>  	case ACPI_GSB_ACCESS_ATTRIB_WORD:
>  		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_word_data(&client, command);
> +			status =3D i2c_smbus_read_word_data(client, command);
>  			if (status >=3D 0) {
>  				gsb->wdata =3D status;
>  				status =3D 0;
>  			}
>  		} else {
> -			status =3D i2c_smbus_write_word_data(&client, command,
> +			status =3D i2c_smbus_write_word_data(client, command,
>  					gsb->wdata);
>  		}
>  		break;
> =20
>  	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
>  		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_block_data(&client, command,
> +			status =3D i2c_smbus_read_block_data(client, command,
>  					gsb->data);
>  			if (status >=3D 0) {
>  				gsb->len =3D status;
>  				status =3D 0;
>  			}
>  		} else {
> -			status =3D i2c_smbus_write_block_data(&client, command,
> +			status =3D i2c_smbus_write_block_data(client, command,
>  					gsb->len, gsb->data);
>  		}
>  		break;
> =20
>  	case ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE:
>  		if (action =3D=3D ACPI_READ) {
> -			status =3D acpi_gsb_i2c_read_bytes(&client, command,
> +			status =3D acpi_gsb_i2c_read_bytes(client, command,
>  					gsb->data, info->access_length);
>  			if (status > 0)
>  				status =3D 0;
>  		} else {
> -			status =3D acpi_gsb_i2c_write_bytes(&client, command,
> +			status =3D acpi_gsb_i2c_write_bytes(client, command,
>  					gsb->data, info->access_length);
>  		}
>  		break;
> @@ -361,6 +366,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_ad=
dress command,
>  	gsb->status =3D status;
> =20
>  err:
> +	kfree(client);
>  	ACPI_FREE(ares);
>  	return ret;
>  }
> --=20
> 2.1.4
>=20

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUk7gAAoJEBQN5MwUoCm2TXgP/ijQMIYU3kx4FW2tjMiwlEG0
MVCzjw+9zidrhqKl2dGaJBfK2Zz2qW8CAKYsHSfsJJQmC/e1oLhCUU2Ba2ivMmje
1C4/fv7JcvQiSu/SEunNnkLMZpqBxXnYjTvgR4ieYiqMl/HmvIhKgEbBa+i5lTLU
8iS4IkjgijZYZgy48MK2Z2hSx2TYBOvrHn6BcymAa88y/ELYZqvMshh5tO7M6Lg6
gNIeuHku2lMZPt5sQFzSdkzWD9INHEKgDnxtUitFcejVVqWGTt/6wWWEthNAbS4Y
z9oYmpa+WOuEzqmIXzEb4oxwHE/XQnS88RlTmtPXfeZ+OTWKPamdcG9/XPK28fPz
Pf6oEyiDCwQR6GvRNeCB0I2lQdXdLq4MTjP5jXuRR9RYM47AZTI9kEENvjGH60/G
IUTIF9O4zLlexr4hZ7Ou13ODC8Lv9gXDjnxxogwGHK4M+rBmhc8OxkVBzDKfCx78
QzLSYVHg+2eU8LxQrz46qC+eawzY7WvIkFQnglawpLFuC+vzfuj4E68leij0zNK8
fZWQmY9lHm9r/WPB57zfARKZ/n/xnEdXGyEsT1p4hVwv7qtocNKLHpL0ZWDY++HC
spTeOYiAmHmsQyQ/xsWmiJ2ziz6AvYXPO2KQP8E/451P2+r1ANIrWS0RYsLtmFUv
+j9+z/pKmm1iYdAArayV
=1BI+
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
