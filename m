From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: passing two interrupts two an I2C driver
Date: Thu, 22 Aug 2013 14:19:23 +0100
Message-ID: <20130822131923.GJ26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com>
 <520E7417.3090606@wwwdotorg.org>
 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
 <5214AA52.2060209@samsung.com>
 <1377088624.10707.23.camel@hornet>
 <20130821175446.GI26118@sirena.org.uk>
 <1377163408.10707.29.camel@hornet>
 <20130822112619.GD26118@sirena.org.uk>
 <1377171844.10707.32.camel@hornet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3NJww9yp20AXRsxZ"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377171844.10707.32.camel@hornet>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3NJww9yp20AXRsxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 12:44:04PM +0100, Pawel Moll wrote:
> On Thu, 2013-08-22 at 12:26 +0100, Mark Brown wrote:

> > Yes, that's probably the most straightforward thing - we'd need to
> > either have the bindings specify which interrupt must be first for
> > reading i2c->irq or just have the drivers always do a name based lookup
> > if there's more than one interrupt.

> ... or make sure that of_i2c_register_devices() does *not* set i2c->irq
> (or rather: set it to 0) when there is more than one interrupt in the
> tree...

Yes, that'd be a really good idea if the drivers are always getting the
interrupts by name, provides a backup.

--3NJww9yp20AXRsxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFg/YAAoJELSic+t+oim9gbEQAJoZoZ4nn5LOR9tEPktUmhcD
eV1kgDY9q0lJse4NQyJp9rzid+6pqqWhUnmA1h38MhDX+UQWHlrAQE6jhjH4wL/T
mwZQDTXvt8YN8g3iMrW6kaZhpwXg3tqcKF2GSICL2eTwdS1gIVb039Z9dfjKqeFt
UG+JplhBpfDgQm+qN3JfxYwhVAjLISzx6EMcB7YxNECrlXj4uJiiunGhTb+TNhSi
gsTUumMcJDtNlkV03pfBK8KQBHaGCnPZpg7Xojz8Y3+rQW0s2e5zz2Htqu9RVD8U
Ttx1Y3sX/OF8XVR6bOWooWmPTU7Zj3ZoeRwURZXUdgE3gcoxrTMwATkcF1WSbcr2
TRP4i+jgknCgt8AeqZkQe8W0TTdW6ftQkks5fn9e+INsxbfymmJD+dRv+48j5HBu
3gwXxquDgj1KMNF62EDabD/bCW3PReVFoo79QPlYrUT2EPGES9v8dmdkvxDp8zM0
B+RijOluu729Ey3tW2dsii4dOpTrPt4YWkuvR2xCMVUeuE5DL18DYQ74Iu1HrF7K
RUlarGOMGx5jnCVKzrR2UWvkGoovQROIZ8XEQxY5Uf8lv9exiQf/Wdk3DN65GG7e
q72+LxBWj7viwPikSeN+XOvzAiv2MJLGMQSdgEFWDKFtQ44Na4YYQrCWzgAqXjCE
pe0i87kl5mhHCBHmzp3/
=BMWY
-----END PGP SIGNATURE-----

--3NJww9yp20AXRsxZ--
