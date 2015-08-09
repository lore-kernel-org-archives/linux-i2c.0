From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: core: add support for read commands longer than byte
Date: Sun, 9 Aug 2015 09:40:06 +0200
Message-ID: <20150809074006.GC1526@katana>
References: <1437744042-24471-1-git-send-email-cmo@melexis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437744042-24471-1-git-send-email-cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Cc: "Simon G. Vogl" <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2015 at 03:20:42PM +0200, Crt Mori wrote:
> If you want to send more than 1 byte as command to slave you need to go a=
way
> from the smbus (which has a 8 bit command defined in specification). i2c =
has
> no such limitation in specification and since we want to have a longer th=
an
> 1 byte command, we need additional function to handle it. With outside
> buffers we have also avoided endianness problems (if we would just define=
 a
> u16 command instead of u8). Also there are now no limitations (as per i2c
> specification) of command length.
> Addressed read function is when we have a slave device which accepts comm=
ands
> longer than byte or some subcommands in same write string before issuing a
> repeat start before read cycle to read more than byte (or byte) from slave
> device.
>=20
> Signed-off-by: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>

I don't see much gain over using i2c_transfer directly to be honest. Do
you see much use of that in the kernel? Any other gain I missed? And if
at all, the function should be probably named i2c_write_then_read or
something.

> ---
>  drivers/i2c/i2c-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    |  4 ++++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 069a41f..bccf83f 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2980,6 +2980,46 @@ int i2c_slave_unregister(struct i2c_client *client)
>  EXPORT_SYMBOL_GPL(i2c_slave_unregister);
>  #endif
> =20
> +/**
> + * i2c_addressed_read - writes read commands with desired length and read
> + * desired length of data.
> + * @client: Handle to slave device
> + * @command: Pointer to command location
> + * @cmd_len: Number of command bytes on command location
> + * @data: Pointer to read data location
> + * @data_len: Expected number of read bytes
> + *
> + * Addressed read on slave device when command is longer than byte. Retu=
rns
> + * negative errno on error and 0 on success.
> + */
> +s32 i2c_addressed_read(const struct i2c_client *client, u8 *command,
> +		       u16 cmd_len, u8 *data, u16 data_len)
> +{
> +	s32 status;
> +	struct i2c_msg msg[2] =3D	{
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D client->flags,
> +			.len =3D cmd_len,
> +			.buf =3D command,
> +		},
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D client->flags | I2C_M_RD,
> +			.len =3D data_len,
> +			.buf =3D data,
> +		},
> +	};
> +
> +	status =3D i2c_transfer(client->adapter, msg, 2);
> +
> +	if (status < 0)
> +		return status;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(i2c_addressed_read);
> +
>  MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
>  MODULE_DESCRIPTION("I2C-Bus main module");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index e83a738..d3cc1af 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -121,6 +121,10 @@ extern s32 i2c_smbus_read_i2c_block_data(const struc=
t i2c_client *client,
>  extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *clien=
t,
>  					  u8 command, u8 length,
>  					  const u8 *values);
> +
> +s32 i2c_addressed_read(const struct i2c_client *client, u8 *command,
> +		       u16 cmd_len, u8 *data, u16 data_len);
> +
>  #endif /* I2C */
> =20
>  /**
> --=20
> 2.1.4
>=20

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxwPVAAoJEBQN5MwUoCm2KygQAKDFDFlNDLig6iqZ5rjH5gdx
aZLvflgOKfxWBsc57A8mEH10MWJhPF8hp/Jmwxq8K27uA/ny22jyX8Ux/Pxy0qtE
G2QAOX3b0o1Yz5WeCYTtXVeARJ+sVSwdSvcEihOuNpqxz2aTCgiJYtdMEneTsihm
UI6Dj+UqOysUVPHnB2eqJXI6lf96fDbRzyc4mv3qa07KzpB4Z5e8JBCmBMb2EZPK
gKxZaPCIM4M+7yQLeX8fV79emBT+6H+tXyLBUO2a0dwkji2qYSBxlGRKzaMdILFE
H/4gwQ+/978m5lohwZxn6niWIjqXds2NIw28+08YpDPpc6EcFwmV2EgmrzLBBiJO
fC0r2Hyj5Wdh+nrxUAMQTnHojUJuZWnkZyyX7y8gTzBNAPgrqht8/Zi6UgGHRvp5
132Qf4xIbcy49iyyeMZT/xjnrGS+w8vIja6S+5hfba0kGVjI+8O6nudNMWq+tKQS
VY/DoLAkhd8FU53nIW6yojUG0NA4VRux8JYPTrekgsbtYoSg+odh/AQDCF9SrzdK
k8Njrxyy2C8SDv2qE5t8BVy4FhQv3e/V1JKvG7K0PncPKEWc2WZOdNtSsXXsw37M
FOllOGSFQYas5tx00xTozeXL6KDQu3+M8BapBGLldTMrTXWWwVQGGxKKAAydpUTe
7TprlWlORL1MehKQxz+p
=refz
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
