From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: add bcm59056 regulator driver
Date: Tue, 4 Feb 2014 23:22:11 +0000
Message-ID: <20140204232211.GE22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-5-git-send-email-mporter@linaro.org>
 <20140204172836.GH22609@sirena.org.uk>
 <20140204212914.GB16179@beef>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yOJWIPlLSoQhvV9Y"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204212914.GB16179@beef>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--yOJWIPlLSoQhvV9Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 04:29:14PM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 05:28:36PM +0000, Mark Brown wrote:

> > > +		/*
> > > +		 * Regulator API handles empty constraints but not NULL
> > > +		 * constraints
> > > +		 */
> > > +		if (!reg_data)
> > > +			continue;

> > It should do...  if not then make it so since that'd mean most drivers
> > are buggy.

> Ahh, I see there is a check for NULL in the core. Will drop.

It was missing in some older kernels (much older now IIRC) - it's
possible that comment was written before this got fixed.

--yOJWIPlLSoQhvV9Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8XYgAAoJELSic+t+oim9oVYP/i6v0RZ4Ap2e4KRoPm5nnYU+
qIEqClNVIpawWV2CncXcYPcggrzxGMw6x2uUulllZyJ/GA4k2kzm7Neg3vWRIl+a
+6AxfW367UG1E1dPkW7VEmqlCEvROx8eMx63U0H2N1IiaME43ctpVcMX4mD7fFSP
ERS4dzzJ1CpenJ5LwZhIZ1V4BqVCcy60FFIfIKvXoCB/G3RBdMIn2HNVgxw2V1Wn
FSstQ4L6ResNYYkMBcSP/gbkYJw9WusCIldjyMORLyYJAxp5VD15WsEWQUhoatTN
BrwZbre/YgwdIxxHUe+pZZM+wFcwD+JKOkpbnC11sa/xXOxSmdf4IdxTNY/G9IXR
V19ToFeYPEO2BE1TIEDOUToADpMlwKE8Jhmama/bKBLqrIF1U0RTM2XE18zYi/uB
45doFvwoL7lLK/LiJCZv292ZdkmoVMIe8SW3BlwWCHhvwUlM37Nr4xwtjC1Szh1/
YbA4XwThZruC3fcU4p+/5MqS5e9bjFrTzLZIy/0D6qPI+/M3lxVoZ/4kavRAACVD
XlWZhqXeFdEAO1w3xO2+l7hIOPs9a1+sq76PMTlpQWTpnFO3/gnRkBy+DNPwJM1h
cyRrQpPzeF3oseKO38l3XI3WNOYf9Ln5kJDX5g+i4SrdK+lOmiBNnalHvt58OWDf
CvR+SsAt969QV+n+T8at
=N8bu
-----END PGP SIGNATURE-----

--yOJWIPlLSoQhvV9Y--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
