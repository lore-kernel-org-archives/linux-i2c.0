From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 7 May 2012 18:08:32 +0100
Message-ID: <20120507170832.GO17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBPbvmIlJjvpbu6L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336155805-18554-15-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--zBPbvmIlJjvpbu6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2012 at 07:23:24PM +0100, Lee Jones wrote:

Once again, please try to make sure your changelog matches the
subsystem.  This also isn't consistent with the other regulator change
further up the series :(

You've also not included any binding documenation here, binding
documentation should be included for new bindings.

> =20
> +static __devinit int
> +ab8500_regulator_of_probe(struct platform_device *pdev, struct device_no=
de *np)
> +{
> +	struct regulator_init_data *ab8500_regulator;
> +	struct device_node *child;
> +	int err, value, i, id =3D 0;
> +
> +	/* Initialise regulator registers to platform specific values. */
> +	for (i =3D 0; i < ARRAY_SIZE(ab8500_reg_init); i++) {
> +		err =3D of_property_read_u32(np, ab8500_reg_init[i].of_name, &value);
> +		if (err < 0)
> +			return err;
> +
> +		err =3D ab8500_regulator_init_registers(pdev, i, value);
> +		if (err < 0)
> +			return err;

You should be using of_regulator_match() for this (I think it's supposed
to do an equivalent job...) rather than open coding.

> +	/* Register each ab8500 regulator found in the Device Tree. */
> +	for_each_child_of_node(np, child) {
> +		ab8500_regulator =3D of_get_regulator_init_data(&pdev->dev, child);

Definitely don't do this - you should unconditionally register all the
regulators that physically exist, this allows users to inspect their
state even if they aren't used.

It's possible the original driver has this bug (I didn't check but=20

> +		if (strcmp(ab8500_regulator->constraints.name, "dummy"))
> +			ab8500_regulator_register(pdev, ab8500_regulator, id, child);

This is really broken - the whole purpose of allowing users to specify a
name in the constraints is to allow them to assign a name that's
meaningful for their board so they can tie the software in with the
schematic which we will display in diagnostics.  Forcing them to specify
magic strings as the supply name defeats this and makes diagnostics from
the kernel more obscure.

>  	pdata =3D dev_get_platdata(ab8500->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "null pdata\n");
> +	if (!pdata && !np) {
> +		dev_err(&pdev->dev, "null pdata and no device tree found\n");
>  		return -EINVAL;
>  	}

Neither should be mandatory.

--zBPbvmIlJjvpbu6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqAGJAAoJEBus8iNuMP3drREQAILkX/J6FDfLp/eQQD9f2L3c
DDSUrWeWBYVN/Jr29vjwAPKvP3/UYoprJxvtCucVkVmBZ12tI+C7AAFY2hpb4Dzq
VUVHkRKLsrmbxqKLmkWz8smo3EPdwE6zJNC5ZQ2ACsleuH5QwF4Rh+wZWr0X7m4s
ojJfQ9TwqP2ak3NZcg94TCTujJA4wh6+VpNIeR2vi4fzaC/DdRiMxvDEV3erpoKg
uRHG8iv91zhUyBesMO6V5X+sHK5r2niB4C0SNOAdCzt4Xe2ehpIsL5Olm0El2Sp2
b8PfoY7jDkuKv6o4NqUkuEKykS5K9mpc2qIm+K/qAeUOiXyBKE8ZlYD74Kiz4AjW
Vf5AV5f6tWByzIjKU/RIHMnFPLuCVINZOqG86eZ6VnisKJjL69ry5AWzzupZrIJi
DMI77z+mHGCnZ6NYnFrvLFt7Sth6rSnHAPTiZZT9Fekq/EZmW2uPxYfcTLMJOJCB
ouvNTOr1+5lKXshZNJYy8cXmrNbagi8gOhZENitkCmBBp89FtXnFpmBATZwHG+4b
u0ofAlYJd6SFiRLwbHDvxk0yHITdFZnNpDfNwJ7jPWNYD8Q/TW+PFoj4U0dN8qjM
vP0OSgllhilbiJsIjkwc7S4fDmcKepWcZGEO/c/7Z9c5U2Y7isxgxks72OMwX4Zh
YbYZi/XXr5FOrPWxpPXc
=ud9Z
-----END PGP SIGNATURE-----

--zBPbvmIlJjvpbu6L--
