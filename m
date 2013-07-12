From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Fri, 12 Jul 2013 12:00:47 +0100
Message-ID: <20130712110047.GA3135@katana>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com>
 <20130705195512.GJ27646@sirena.org.uk>
 <CAHp75VeasHGariq=v005NSUTe_+e471NYbEoSzPJXcFNgsfKNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeasHGariq=v005NSUTe_+e471NYbEoSzPJXcFNgsfKNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Briefly looking into ACPI tables we have and mechanisms that we can
> use in ACPI case, I doubt we may apply all the ideas, probably some of
> them, though I didn't get yet where to read about in details. What I
> could say now is that the patch provided by Bin Gao is definitely no
> go.

Laurent explained to me what V4L did and now does. It used to be the way
tha V4L drivers did register I2C slaves according to platform_data. Now,
with DT the slaves get instanciated earlier, so they now use notifiers
to know when the slaves are in place. Something like this should
probably be done here, too, instead of unregistering and re-registering.


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3+HfAAoJEBQN5MwUoCm2bmAQALGb3HN11Xjr8sv4ubKOqJIE
E/2fc0dC1wwqfeOn7q3quqaxmeUqpelWGDyigkLkELfOuiopFDNRHdskD67cvziG
cXhy8Ll3fTY3A62u001r8L70eFpSbfKlaHd5lSiFI8jLP0zHihc/blmE0L8LHiOb
mKxulbv6+l3FdueIvTbRuwaA+CDvkLLOoewFN7w6cxasP1ncqL9UcFHxjPSxSZ4P
dKBMTtqi//2gKugU0LTYT6Y0tG++qieeTUNppZDldpfZaktAxVdsEahVid8x8dbj
gUObr8wFgwyV5sZVcrNgXgomBwGdm7pWe2hZTholQnW6asglw0KT0WuuK24ZnBaH
4b+18zGclNw0oH1Se0s49KxCf5yAc2IWEPUSDMGE7axiuu1OgPY07fT4yO4VTEGh
jgeCmIpcomrdOAeUPFNGNVC5O+GxWhvsppCGc1MF7rm6IdGCIx0HCat++xU6FkNz
pswxwMsE9rrG4hCsX1Y5gwGH2DArXl5VCwJWeoNYlJez9AEkDg02RwS/KSS+1p77
45b5HiSLJKSVrWPvfsMDMj+NSFkX9q4MhIaD31AP2r4DWjkRUuqbv7o0xJ2tVCtl
Oe/7C0+E/T3dLFnxyPI41nKAhXcOLyKR4mzrKt2X2x34kq+QQCmN0GcP7btQwrZF
KQuq8WIURVmLlmZ8jBhS
=uyrr
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
