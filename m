From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Tue, 3 Mar 2015 20:11:53 +0100
Message-ID: <20150303191153.GA7862@katana>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
 <54F5E120.3090705@alitech.com>
 <1425400650.17965.53.camel@synopsys.com>
 <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
 <20150303172145.GA7076@katana>
 <54F5F38D.5050309@alitech.com>
 <1425409412.14897.157.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425409412.14897.157.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I am all for centralizing printouts. I recommended this at my ELCE
> > > talk last year, too. However, you need to keep in mind that irqs
> > > are sometimes optional and you don't want error messages for those
> > > irqs. IMO worthwhile, but not a low hanging fruit...
> >=20
> > There is a lot of truth in that. Thus the initial dev_dbg() suggestion
> > to go half way. I still think that Andy's proposal (or a variation
> > thereof to catch the optional irqs case) should be the ultimate goal
> > but I agree that this is more than a quick patch and that it's
> > probably way out of scope here.
>=20
> Yes, I was thinking even about some wrapper on top of platform_get_irq()
> since it seems there are no messaging done inside platform.c, though
> devm_* functions usually have it.

When I had a look a few months ago, the situation with devm_* was messy.
Some rightfully printed errors, some rightfully didn't, some vice versa,
some the other way around, and some did something else...

For driver authors, it is hard to see/remember which devm function does
it and which doesn't. IMO a good cleanup will get rid of this mess. I
started sketching something but especially clks and irqs are basically
everywhere and so it easily grew out of the fun-time project scale,
sadly.


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9gd4AAoJEBQN5MwUoCm21NoQAJJle9y/XkbHNEMHx4gMwMX/
jf9yJT6fBfqvQrGqn9qS1b6CQ0olgAG56p4GCgKWM3nD2/lR19YvyLb52iYnht0D
QZdE74Je0IDQ24xBmNcYRGqWfTYO/HlsO5FyFKOKhPXpLxX/9v7QcAX9pZJOQwJW
otdfHa3lWubmzvEY+lrqXi4CYd72qc8Bu5YFjpJy/CPSpIz7L1LBSz9o8tHBgNjb
rQIiMxIj07kO73MmpmRds8ejjgdQmYpbwYu9jFJsIk4YnoXcoAXUgrKeNfKwCMKA
bdTvxTlvywksoQbXaoIw5mnv4kMLlNvhSVTIsG8k0kwtmSaUw3U+J53yvMfjLkIg
k8+YpAR5bjScrtEtNpdQPGcZF5HDyRg3sPf5vRX80e4F+1ZRyUAwRV8khgZpoGSc
eq8uLnQ9ycu5SNPJUs/cEB5G1eP33IFUg/vFy66t3g+7u2nXRQYQ6lNJ9AFPtfBd
5Zuxf/Ro3yGmYgAvgM5GhGnCvrOjNmQbsmSy0angsZ2YFq9rLm2MH5saA8YEA5Ai
ZB0LUxFZoBpWp6OpGzM6PMDWwSvP33OstNngfM/v9Cdw1ymypomqseakLxz/cnZG
bVIrVYAGLrPAtjNNcNpLNb80uzcAf6UgGFm7YZ2bX/Z8oOtuELXLiH9+A6izD5nG
wEpHiY2D/Z84BGelEWFh
=FcUs
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
