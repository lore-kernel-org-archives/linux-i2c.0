From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: support 88pm80x in 80x driver
Date: Wed, 4 Jul 2012 16:33:08 +0100
Message-ID: <20120704153307.GE4111@opensource.wolfsonmicro.com>
References: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
 <201207041137.49020.arnd@arndb.de>
 <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DEE@sc-vexch3.marvell.com>
 <201207041527.13954.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xFHWmGwbilGjB8dh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207041527.13954.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yu Tang <ytang5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilbur Wang <wwang27-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xFHWmGwbilGjB8dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 03:27:13PM +0000, Arnd Bergmann wrote:
> On Wednesday 04 July 2012, Qiao Zhou wrote:

> > >On the other hand, I think it probably makes sense to drop the irq_base
> > >member in this struct and rely on irq domains to allocate them dynamically
> > >as mentioned before.

> > Do you mean that both regmap_add_irq_chip and mfd_add_devices api pass -1 as
> > the irq_base, so that system can dynamically allocate the irq_base for it?

> regmap_add_irq_chip should pass -1, mfd_add_devices should pass 0.
> Mark can probably correct me if that's wrong.

That's right.

I do need to grovel through the irqdomain code and try to figure out if
the stuff added recently for MFDs to pass an irqdomain about would also
support doing the same mapping.  Unfortunately all the irqdomain code I
found that I didn't write was rather tied to DT which makes things more
obscure, it's not clear what's for irqdomain and what's for DT.

--xFHWmGwbilGjB8dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9GIlAAoJEBus8iNuMP3dkg0P/AtgAcRbp4Rc7gdNxaGU7u09
qAyWxbMH1KEXJ8wors9WAPXWm0BG60nn3E+ge9D/GXkdVdhlldqk5JaFVbShSy3/
YQ4lBaSOYqINGu5SIONy8pyRFicH9qD6YuL8s3s4faMJfwsOTiuv7gESbid9tGt9
tVudK9NdUBqZwsCJe9dlcw1OAELm1478hILVZca0O+gHdPf3QslFR30ttfRxMXJE
hkhlyR0bYbw8I5aODlJ/sRXfNd0v/v4/B5MjR81mKxqfXNMhiWCWIx0hiFcFZgan
4+XnH22fQPfeHOh3A/TYIBSrwOTlWhRwfCp+TRWSGcDX82dPN9/ebAGeYHTzEpXJ
xtlz2JblgqYYZR1Tn8wmcyR6nnOigHD3oUGJypHQ+KzTCYnDc93p9UDSOctT2Mam
WwSdsDKdmJ1xs+VVjVTBP67/k5RVvShXjF3utTm5P3mdkcDGDjSGUnGwyV+92OQu
gLovXLHjx6wZpvUvz9rD8uU+u01kwjkgaeyj6WNvgRsim+FkVGFM/W/8FS0rRk1/
wK3ifcWFStCMm29Qp93Q9oZx8mVdzHzkarkb54ljxWRqj1+eLyo5llWUNGwktPj5
SDG3QXtoSKkcjQzOI1Sa+Abo5y2DLub1mqqtHpNEpY4+Y7lGZGX1VlUbyMgbpHBd
KW2g8h/ucYJVZhPewjOP
=WPRL
-----END PGP SIGNATURE-----

--xFHWmGwbilGjB8dh--
