From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: passing two interrupts two an I2C driver
Date: Thu, 22 Aug 2013 12:26:19 +0100
Message-ID: <20130822112619.GD26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com>
 <520E7417.3090606@wwwdotorg.org>
 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
 <5214AA52.2060209@samsung.com>
 <1377088624.10707.23.camel@hornet>
 <20130821175446.GI26118@sirena.org.uk>
 <1377163408.10707.29.camel@hornet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DHdTHwZuIuFUI+Ax"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377163408.10707.29.camel@hornet>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DHdTHwZuIuFUI+Ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 10:23:28AM +0100, Pawel Moll wrote:

> If the platform data used to carry the (custom) irq data, the DT-powered
> driver could interrogate the DT on is own, couldn't it? Of course there
> should be some helper available, maybe something of that sort? (warning,
> untested)

Yes, that's probably the most straightforward thing - we'd need to
either have the bindings specify which interrupt must be first for
reading i2c->irq or just have the drivers always do a name based lookup
if there's more than one interrupt.

--DHdTHwZuIuFUI+Ax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFfVYAAoJELSic+t+oim9ONsP/iYNTF+3/wIQsNuaC/C01sdQ
GaDviOE9s4xnMmSb1uXLFYKm+E2pwFeHFv4x5Rf4cOhL9Sl21zvN/9VRrQqjWpJ2
OZ4abc317QLyxMLVgcL5C+2ixbnS6BfFiBGhIpi3t49rhipuLCPnSragj4XeLEp+
Et0/00GR7pzwvnNYG88ArIjqlZ0rv+w842d8VqMAkYy9soVlwbn8PdstLqdM4W6b
W1DJHVblq56YS/n2c0Wko2rHni8yLVFSHvAynsJWWJ3eJuPKAigzK7XoLT/QVONT
y4B+zSQdPljnIQY9YscqXLumnS7ci5nP02q7zU9bhm9EiL4tYooi3B2uv5dG71IA
6hTgvaFHzd5lxhfUR1MKfeMvyUCqUIrsUg5i7LKoeSCCE93Kr92jU11z9k4EJJ4T
3Gk4JacUMNvtD8pbOP8zveCIuBIRdzcA5DfPrBACPfD6+fZAbi9C0ELT0iNo25Jn
rxhLDqT1NwQ/52q7Xv8irK8kjHF8b9Sw1l0skH0hQ4sUjZbVXiCnJCUPp1H6IbWt
zXLxVpot9eEldGQasOQDdAxm8RKGliaw//10wAeIguGU0iOdz7IER7JkNn8AOnV3
A30+Eaqv3yCFhAOE3Y9MG4oVP+HhNK5sqNX1d1TMiCdxYbJbys/QCUCvhyrz1UNE
7peLoT05yBuO8yBXfwl9
=1l1X
-----END PGP SIGNATURE-----

--DHdTHwZuIuFUI+Ax--
