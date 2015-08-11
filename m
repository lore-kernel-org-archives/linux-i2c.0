From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 17:39:16 +0200
Message-ID: <20150811153916.GD1525@katana>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434657458-16553-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 12:57:38PM -0700, York Sun wrote:
> Based on i2c-mux-gpio driver, similarly the register-based mux
> switch from one bus to another by setting a single register.
> The register can be on PCIe bus, local bus, or any memory-mapped
> address. The endianness of such register can be specified in device
> tree if used, or in platform data.
>=20
> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Thanks for this driver!

=2E..

> +- no-read: The existence indicates reading the register is not allowed.

Given that we have "read-only" properties already, I'd prefer this one
to be "write-only".

> +For each i2c child node, an I2C child bus will be created. They will
> +be numbered based on their order in the device tree.

This is a Linux specific detail (which can be overridden by aliases), so
it should not be in this document, I'd say.

> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index f6d313e..77c1257 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -29,6 +29,17 @@ config I2C_MUX_GPIO
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mux-gpio.
> =20
> +config I2C_MUX_REG
> +	tristate "Register-based I2C multiplexer"
> +	help
> +	  If you say yes to this option, support will be included for a
> +	  register based I2C multiplexer. This driver provides access to
> +	  I2C busses connected through a MUX, which is controlled
> +	  by a sinple register.

Typo here. And keep the sorting, please.

>  obj-$(CONFIG_I2C_MUX_GPIO)	+=3D i2c-mux-gpio.o
> +obj-$(CONFIG_I2C_MUX_REG)	+=3D i2c-mux-reg.o

Keep the sorting, please.

>  obj-$(CONFIG_I2C_MUX_PCA9541)	+=3D i2c-mux-pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+=3D i2c-mux-pca954x.o
>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+=3D i2c-mux-pinctrl.o

> +	adapter =3D of_find_i2c_adapter_by_node(adapter_np);
> +	if (!adapter) {
> +		dev_err(&pdev->dev, "Cannot find parent bus\n");

I don't think we should print something when deferring.

> +		return -EPROBE_DEFER;
> +	}
> +	mux->parent =3D adapter;
> +	mux->data.parent =3D i2c_adapter_id(adapter);
> +	put_device(&adapter->dev);
> +
> +	mux->data.n_values =3D of_get_child_count(np);
> +	if (of_find_property(np, "little-endian", NULL)) {

You should check for a "big-endian" property as well, no?

> +		parent =3D i2c_get_adapter(mux->data.parent);
> +		if (!parent) {
> +			dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
> +				mux->data.parent);
> +			return -EPROBE_DEFER;

Ditto about printing when deferred probing.

> +static int i2c_mux_reg_remove(struct platform_device *pdev)
> +{
> +	struct regmux *mux =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i =3D 0; i < mux->data.n_values; i++)
> +		i2c_del_mux_adapter(mux->adap[i]);
> +
> +	i2c_put_adapter(mux->parent);
> +
> +	dev_dbg(&pdev->dev, "Removed\n");

No need for that debug. The driver core has debug output for that.

Thanks,

   Wolfram


--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyhckAAoJEBQN5MwUoCm2C/QP/i08lVX7AfqjfzPDca+1rQgZ
L/Y0id9d1ojxxanuLgcvnGxCMSR1ATXtk8Zo+azpPX9ijvGwnV93utGqH7fLNJDl
GL0PaQ1Xo5fG9LkPTcue0uTLvDxoZuHMetrzGrcrVxvGDd7uz9S0N2sFnNyy25Tx
DrUzKM9KQhyObGxGqbOykFcTLI+3+rlvHNrnJcQssxACrnfwgFPkz5aJwN6n92Uf
wmwor9P9zH2eYkeGVm/OQbBRP+kBRwYV/t6LveohugfUU9+iTpM9AEb2VEHZ3XDx
ehZ7ywqtG6CxUdbKkCLzvxrS9iRu7vSdWZNGcJXr6PqMW9vcd/VHWsPj92mo7yrQ
8WBDBjVh9Xfg7oP5fnHsX1S878zVerzLL2i/iGBix2PG68+dRSG31jfDHzpo1Uza
l793dX/Sdl+OA7EPIgisxs1bbtiUXPSX4HCq3ooCHoNWgDz+MFkINIwPHVlXgBOV
C4uZkTg0rv9K3vSllbJucn579rydTqjy/fUjAeuI0baP2gVYtTrRJjAOevWnGWwW
XitJAi7yB9wpKmjTcJZ3sPQ2LzL3K6wZBtvxgy1d6psJUZ2QH39lFWueBIsLQCYR
W9idO12QPQZKk2aPX1a/VTJRTCUNKhtRhjdiiW3sZclD7bMhTtkTCWF7HmoTyipc
hqP3DbJDV0CEBOFgK8lJ
=621N
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
