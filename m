From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: add bcm59056 regulator driver
Date: Tue, 4 Feb 2014 17:28:36 +0000
Message-ID: <20140204172836.GH22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-5-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+TFC1kkuuXJmyCU6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391516352-32359-5-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+TFC1kkuuXJmyCU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 07:19:10AM -0500, Matt Porter wrote:

> +static unsigned int bcm59056_get_mode(struct regulator_dev *dev)
> +{
> +	return REGULATOR_MODE_NORMAL;
> +}
> +
> +static int bcm59056_set_mode(struct regulator_dev *dev, unsigned int mode)
> +{
> +	if (mode == REGULATOR_MODE_NORMAL)
> +		return 0;
> +	else
> +		return -EINVAL;
> +}

These do nothing, don't implement them.

> +	if (bcm59056->dev->of_node)
> +		pmu_data = bcm59056_parse_dt_reg_data(pdev,
> +						      &bcm59056_reg_matches);

It'd seem a bit neater to put the OF check into the parse function but
meh.

> +	if (!pmu_data) {
> +		dev_err(&pdev->dev, "Platform data not found\n");
> +		return -EINVAL;
> +	}

Like I said when reviewing the binding this should not cause the driver
to fail to load.

> +		/*
> +		 * Regulator API handles empty constraints but not NULL
> +		 * constraints
> +		 */
> +		if (!reg_data)
> +			continue;

It should do...  if not then make it so since that'd mean most drivers
are buggy.

--+TFC1kkuuXJmyCU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8SNBAAoJELSic+t+oim9QioQAIw1I4kSTRw1PhNzOg0ZSoo9
TibrHRWXuthOrvf52eTwyZ/i3251wpIcH/+fTJC7EQz884p8DlaihrCq4NO8ZGXm
KgTMNsGAvTT6cex9i+2somZ1paNT4FWg94HFTrJwnmW7Ce53Zl5bUJQ6dC57Q6AQ
1RxW6ZEotnqE6q/b7xbGzwXfJeQi2QizaQO/HF0lF9qiVu5j6yoKiZVrTSUYhS/W
NYnrTUvFTeZDhcy1a3xms3SBPrfwlH/JRYC8e/lT/VWVjnecu+fAvYmWdQ/9h77z
eFKvjmeopnRndpdHKcJG5MAuv2eNM0FRCAH3l/5SMYjmwPkwfv38NMHIWXbdeZAY
m6adOL8c1RFZdnklmoWXsBsEo41nqgSWtV/ZTRCiOZFKRY+slItZy3AV7geAigKI
YgfsnqqEwzRaVTlbB4cXoIxOoxYsteFCA8FYEqZa4yGzx0BED6jxvMeTSEk/x/CU
dTQyD3ub0Oh1m/EZnWeCmew935Rzk9Qoi/6CgTdE8SI80PfExE54yD+R1X15InUE
81RXNLibBzEAdQRS4nfSMm9A8YcvDO4BnoM9y4Dh0W9bmZhwUcAYEW1lSXscnnMU
j5TGX6XsdKaXYUu/qwFz7F4km9m8ICZ9+kmSEBiQUMHNzq1AFOpHrwf4lvZb+LkU
qYcf2/jE6RXp3/MIrLHf
=KDaY
-----END PGP SIGNATURE-----

--+TFC1kkuuXJmyCU6--
