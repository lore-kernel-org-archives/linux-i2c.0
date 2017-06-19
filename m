From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: add sc18is600 driver
Date: Mon, 19 Jun 2017 18:20:54 +0200
Message-ID: <20170619162054.4v2fpk2cowd3bqbe@ninjato>
References: <20170613154748.7018-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6bfgasygbjihd6z4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170613154748.7018-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6bfgasygbjihd6z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This is identical to the patch [0], that I send 3 months
> ago and got zero feedback from I2C maintainers.

I2C has not enough reviewers, this is a known issue. Pointing it out
alone does not really help. You could have reviewed your own patch;
after 3 months, one sometimes sees issues not noticed before. Or look at
other driver reviews to find out about common issues in new drivers
(like the suggested error codes on transmission failures)...

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cp2120.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-cp2120.txt
> new file mode 100644
> index 000000000000..95e06e74f288
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cp2120.txt
> @@ -0,0 +1 @@
> +Please see binding for i2c-sc18is600

I'll leave it to Rob, but since there is no driver 'i2c-cp2120', I'd
rather drop it.


> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sc18is600.txt b/Do=
cumentation/devicetree/bindings/i2c/i2c-sc18is600.txt
> new file mode 100644
> index 000000000000..d0d9e680a5d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-sc18is600.txt

And Rob will ask you to send bindings as seperate patches, so I'll do
already, too.


> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 144cbadc7c72..a6e776c1795e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -210,6 +210,16 @@ config I2C_NFORCE2_S4985
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-nforce2-s4985.
> =20
> +config I2C_SC18IS600
> +	tristate "NXP SC18IS600"
> +	depends on SPI && REGMAP
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  NXP SC18IS600 SPI to I2C-bus interface.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-sc18is600.
> +

It should rather go to the "External I2C/SMBus adapter drivers" section.

>  config I2C_SIS5595
>  	tristate "SiS 5595"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 30b60855fbcd..29971aebd238 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_I2C_ISMT)		+=3D i2c-ismt.o
>  obj-$(CONFIG_I2C_NFORCE2)	+=3D i2c-nforce2.o
>  obj-$(CONFIG_I2C_NFORCE2_S4985)	+=3D i2c-nforce2-s4985.o
>  obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o
> +obj-$(CONFIG_I2C_SC18IS600)	+=3D i2c-sc18is600.o

Ditto.

>  obj-$(CONFIG_I2C_SIS5595)	+=3D i2c-sis5595.o
>  obj-$(CONFIG_I2C_SIS630)	+=3D i2c-sis630.o
>  obj-$(CONFIG_I2C_SIS96X)	+=3D i2c-sis96x.o
> +static int sc18is600_read(struct sc18is600dev *dev, struct i2c_msg *msg)
> +{
> +	u8 header[] =3D { SC18IS600_CMD_RD, msg->len, msg->addr << 1 };
> +	struct spi_transfer xfer[1] =3D { 0 };
> +
> +	xfer[0].tx_buf =3D header;
> +	xfer[0].len =3D sizeof(header);
> +
> +	dev_dbg(&dev->spi->dev, "r(addr=3D%x, len=3D%d)", msg->addr, msg->len);

Maybe you could drop these? We have tracing messages and core debug
messages for printing message destination addresses and lengths. Just
saying...

And what Andy said (thanks!). But looks quite good, in general.

Regards,

   Wolfram


--6bfgasygbjihd6z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH+eYACgkQFA3kzBSg
KbauBg/9FmqvC3ISZgN3+PLHXG8MiovUDkVmfIGbs0cLswtMGBG5KJEh6JDqhUrs
38y1SdmTAs8UTyi+kRUgoLAeRBa1UERwT/NnQeevAUQxGqTLwysheltPYGiBz6JZ
OR8bBjXVdOKP76wc0/oUYoOqsdYI6LE6xQhNjleZf8bE/ekq5PX9mcQ5aJrEAtz/
+kLPVnrHKfpdJokd7WUoDPARgpHXgCWeLU5ofItgEZQbZxDOYcaWbuURgDYtFgNc
AauAeKTIUbxaiWVq9E6IMPu2HJsHEh95lXH/Q+4THOcx14Dm3pvtn7LXeMV8mgo4
Sts70lHNitTgd+RVQqrTbxyRc++HynkOyLTyAkIiTUSxysVAkbGzaJA9ZRAt2ZB2
h+pm6vf7y0FGtuNcxh5p2FX+ykWStTYYTuiy6Wr4H4XyuBTIw7DBE2vWQyEODdqh
N60KhWEkekDUuFazlwxoWHaKAr/cwnufwJApf7NxgeWka8btZT3a6iODeWSSSGcR
hUu/FIXfWqdkcJtQY3S9cviqpBC1DxRItxGNtVE8VaRPnZ4wvHSFUNuReZ3WjRSV
zQ/mkDIv40v2ZnjYlqQzbOaeWduwK0BZILsp9ImYV7+fymTPzIyq41aJWzd0bhfk
PcF25JUWyeoNNhBk1yaY5UcHhOUg1my+NwbML7zyt55uF7d8ViY=
=vKs5
-----END PGP SIGNATURE-----

--6bfgasygbjihd6z4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
