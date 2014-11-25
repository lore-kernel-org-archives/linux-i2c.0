From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Date: Tue, 25 Nov 2014 18:53:16 +0100
Message-ID: <20141125175316.GB9716@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141116171605.4750.17472.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2014 at 10:47:46PM +0530, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.
>=20
> Signed-off-by: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

=2E..

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 917c358..71ad6e1 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1044,4 +1044,15 @@ config SCx200_ACB
>  	  This support is also available as a module.  If so, the module
>  	  will be called scx200_acb.
> =20
> +config I2C_OPAL
> +	tristate "IBM OPAL I2C driver"
> +	depends on PPC_POWERNV
> +	default y
> +	help
> +	  This exposes the PowerNV platform i2c busses to the linux i2c layer,
> +	  the driver is based on the OPAL interfaces.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called as i2c-opal.
> +
>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 78d56c5..350aa86 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
>  obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o
>  obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
> +obj-$(CONFIG_I2C_OPAL)		+=3D i2c-opal.o

Please keep it proprly sorted.

> +	rc =3D of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
> +		return -EIO;
> +	}

You introduce new bindings which need to be documented in
Docuemntation/devicetree/bindings/i2c.

They should be posted as a seperate patch with
devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org CCed, so they can comment on it. This is
required these days and especially important..

> +	adapter =3D devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return -ENOMEM;
> +
> +	adapter->algo =3D &i2c_opal_algo;
> +	adapter->algo_data =3D (void *)(unsigned long)opal_id;
> +	adapter->dev.parent =3D &pdev->dev;
> +	adapter->dev.of_node =3D of_node_get(pdev->dev.of_node);
> +	pname =3D of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
> +	if (pname)
> +		strlcpy(adapter->name, pname, sizeof(adapter->name));
> +	else
> +		strlcpy(adapter->name, "opal", sizeof(adapter->name));

=2E.. because I'd like to get an ack from them because of this binding. I
don't know if we can just say "this comes from firmware, so we must
support it" (although you wrote the firmware IIUC) or if we have to
judge if this is a HW description which should go into DT? I am open
meanwhile that the adapter name does not need to be static anymore.
However, I don't know much about server world and FW, so maybe they can
assist.

An example binding in that document would also be very helpful.


> +static struct platform_driver i2c_opal_driver =3D {
> +	.probe	=3D i2c_opal_probe,
> +	.remove	=3D i2c_opal_remove,
> +	.driver	=3D {
> +		.name		=3D "i2c-opal",
> +		.owner		=3D THIS_MODULE,

owner not needed.

Thanks,

   Wolfram

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdMIMAAoJEBQN5MwUoCm21x0QAIbGIMv3dKaqWySbuWkCiFvI
Bmh0G9Lpfz1PesH07zDiZezNZTZMwYVmwuTKgMCPl4YQ4M037PEjulJFWB3CUvgw
E+vKiCNRfrYsUqywhutVDr06OfuJnHROGeyTGgGL26ioeTYjEjxYEySThPyoS44+
Xq5XRS70UCqFANC4yuttKf3FmazIUEzujkbm51vynhc+Uxi6is1MLxM74ptRTyLw
p/96jQnYh3vwjQX/rdhYDmjfi4DrrD33xkRoauZpAyuLluULjChsIjByM4md7RvA
mOeqSguSVilRQszqu7ND8gf25tO93XHO4o9Vb1zYQTBGP4+p47xAVIdGvbX4RkAI
ox00SRSGeB3aB5vKA5UgCPXsfjGQXUj8Y+TsUxs75aTApCwu5mboyJsM+ZNVlS5e
fMNjx433YL2idFTUVoorMKq6UXPKJ+d8Cx00C9WjU3bnf/258RfaQnPS2J/VNtrk
3po8QerVdOJWP5ukXniZ6JDBAVALmIKxPBeqIRFnmn63zAPavEv8bQE4qB1Q50up
N0jnFiU/m/jsCnJwuWDthSl++9weg7d9Tm5ZkdgNdr1Y/QtmiJYyOSkfUucQ8eyX
KP+APQi2G47TV+pbEs/g70DCa0pHK7IIo44kzRFmQ2YA37MUvb6LYp1YyqGFnbYU
v6eoXbG5ZcfgR/FVBUY0
=C2yK
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
