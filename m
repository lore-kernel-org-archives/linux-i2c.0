From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: Add acpi support to enumerate i2c mux clients
Date: Wed, 3 Jun 2015 01:19:54 +0900
Message-ID: <20150602161953.GA12451@katana>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#ifdef CONFIG_ACPI
> +static void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
> +					  struct device *mux_dev)
> +{
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	handle = ACPI_HANDLE(mux_dev);
> +	if (!handle)
> +		return;
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_i2c_add_device, NULL,
> +				     adap, NULL);
> +
> +	if (ACPI_FAILURE(status))
> +		dev_warn(mux_dev, "mux adapter slave enumeration fails\n");
> +}
> +#else /* !CONFIG_ACPI */
> +static inline void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
> +						 struct device *mux_dev) { }
> +#endif /* CONFIG_ACPI */

IMO, this shares too much code with acpi_i2c_register_devices(). And it
pulls in ACPI into mux.c which is not really needed.

What about naming the above function
acpi_i2c_register_devices_from_dev() and let acpi_i2c_register_devices()
then call it as a helper function, all this in i2c-core.c?

Thanks for your patience BTW...


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbdepAAoJEBQN5MwUoCm2QsgP/3r/8IxaX8v+nSAF8T7EjbDd
bXUeq5fUmx0rW7yoqBsRzh/hTU8R+ndC+fexfTpK/GLLajuT102tThvkt9oYAoxW
4weDcgWzRMzLajrTPpJWpaTe4382vSf0/0MRfyTs2ps40lvTzoa+KQTV21RDzeXp
+JnFJUuEgPIrDvl/2vR1Bg/FprjNc/iRQMn9YUoo+52VpxdXhe8nEeh66BvfuRH0
rvUntZMFHWsVJk4CNz8Ej/usNoL96d5fcb4BRA6eNmLmzU2DkhkIhT916YYQQSlR
iV1K4i8gcqwBG/UXpVvBrOtQsg7jT6UriXdbVeWSWprrlod3S1XNfiLpfwCS8Y2+
l+X8GNEe1Frl2D6FjuFR8CGSJKjlcZhzrZ0KTwQL2k5Zb1KulYF7HwmPJsTSEGp1
soB0cC8niz2yQQqwrXnT9f7sQJUrXd0I580XwarRTq+OqXyWstu3vwftvP5sSzhr
4lhORuX09E2evunmoDf2mlfZ9VYH4ynXGbDye0s9SrkCfuoEc8JCGUDKHoTcVE4P
xJiWQ3lwwGutBwX58rxgdiGj/aeIlC5fNcjUg1cuNUATPANCz52W+kIrL/vS+4Hu
/m1aNHX8Ib0LrQe1ouNO4r39NwYGC94Sxcnf6Z5tbpJS2WylvcwFnE0cDcOVBqcL
AezP6xUxtrlK5ENw4UCP
=OnFE
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
