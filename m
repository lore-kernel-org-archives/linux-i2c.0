From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Tue, 17 Sep 2013 11:48:52 +0100
Message-ID: <20130917104852.GN21013@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1861747.RtS0ZLgUUN@vostro.rjw.lan>
 <20130916233111.GB21013@sirena.org.uk>
 <1820315.QOOAzSjac3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1820315.QOOAzSjac3-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 03:25:25AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 17, 2013 12:31:11 AM Mark Brown wrote:

> > It shouldn't even need to do that, it should just be able to rely on the
> > controller to power itself up when asked to do work.   This is how the
> > existing implementations are done - the controller power management is
> > totally transparent to the slave.

> If both the I2C client and I2C controller have corresponding objects in the
> ACPI namespace and the client's object is a child of the controller's object,
> then in order to power up the client we need to power up the controller even
> if no transactions are going to be carried out.  That's what the spec simply
> requires us to do in that case.

Like I said I think this should be handled by the power domains (or
otherwise in the ACPI specific code) - we shouldn't be needing to modify
individual drivers to work around thoughtlessness in the ACPI spec.

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSODORAAoJELSic+t+oim90iEP/jU3tnrrfTERoFK9K9fLZegB
LjrFc+cOXOE7/J+FOckwqDiSV/xgmyvP59+XTdI/62Cx0+oc9XeAz5Y7k7DaIHws
bHGcen9K9SjQPlajRodHZR1VE7PB6Wp4yfm/wMInvl0k8gC6M0NUuz22VKP2UQVk
UsUT6K/Dx7eA2OtAKCId70rwQwUVhDW4UGwlSSMcwAY/+k0X1U2aB5C2OXZXH5Qs
xMYHJa+6eJ3Gsgf+uSL02+RiPbYy2MXgwTRTI874Fh54yy6RxFc8SyuMveBfCxwI
Nq0KuDdZ52KOIhWrM9orPEQXXNIjtnboH9zNlOQAqDeWOZ94nDYLyvQk5QHeNoUs
q2Db3eC7kQ109u1CkQOB294BxyAl8EHKYKV3BoQTy0YS39ZTh75F8BL6t3Dscc0I
UjcKH9hrIk2eLgGsaAwePbrrTTcqybQrNT9FCiSTJHeuzN/9/APEZ2nisC3oaeaz
gDX59vyoT38AhrLcvlYQr2uh0ZwbYFsfmt1P4KwncLzYsSQP07zJS9riL5983gg6
8EL0WAv4mHjW4bvyEIMQZfATfL20ydi0fnfbtH+AYQK7/58GEnHWkc/Wtthr2vLt
Fwhdmjh3HiZIGs7Y9eKsHCWRMPtoDaoTBO3H3qoPGU+qF0EM+966g/7e9YYdGFPo
996UUDK4oT2TID4tAOLS
=UP9s
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
