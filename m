From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: attach/detach SPI device to the ACPI power
 domain
Date: Thu, 10 Oct 2013 10:38:39 +0100
Message-ID: <20131010093839.GD21581@sirena.org.uk>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381327461-10562-4-git-send-email-mika.westerberg@linux.intel.com>
 <20131009175528.GV21581@sirena.org.uk>
 <20131010061256.GB3521@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KYWjQn08oZ6edC5T"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131010061256.GB3521-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--KYWjQn08oZ6edC5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 09:12:56AM +0300, Mika Westerberg wrote:
> On Wed, Oct 09, 2013 at 06:55:28PM +0100, Mark Brown wrote:
> > On Wed, Oct 09, 2013 at 05:04:21PM +0300, Mika Westerberg wrote:

> > > +	if (ACPI_HANDLE(&spi->dev))
> > > +		acpi_dev_pm_attach(&spi->dev, true);

> > Though I do wonder if it wouldn't be sensible to push the if () here
> > inside acpi_dev_pm_attach() and similarly for _detach().  Terribly
> > trivial either way.

> Actually, the check is already there in acpi_dev_pm_attach()/detach(). The
> above code follows what Rafael did for platform bus previously. I think the
> idea is to have visual hint that this is only for ACPI enumerated devices.

> If preferred, I can drop the if() checks, though.

It'd seem neater - the fact that the function is acpi_ ought to be
enough of a hint.

--KYWjQn08oZ6edC5T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVnWbAAoJELSic+t+oim9sREP/1JnCBcgJTvVWKSOAUXeA0bl
dt1hEUXoQbx18fGe5/PZgcnkhU8uEwnf76uvS5Pu2BXDHAifdz/jb2aa+I2gdPr8
2aSnEyo/A0hTkprxbECCudvLuKvB02idRG0N8ZS7xPycahL2i2du6zaRj5XACLuY
LvvxBJVecKz0HOEszbNdfGXHgqb9zK+TEDtw3vx+dT2w9BKff4j7mLFMjXDaVqo/
YfRrvvYFWPh9LWkLKZ8W68K45RWOCNXTgWq4KtfVZsFBT6KcRHqzIirvmiDo6Wt9
ij+yTkGTLQJo8C68ByXsMlXS/Rlz1tti0Xrf0DyB7nqDVcWSYKZDVQtSZt1jn2L3
KfC3QrRCy9RFyDwwqMSLyG3Uo5jPZG9tG4pcoCJoGEzZpgNpphrTLWmGE/IIkh9I
gnLhiLTrOG4h35cgBiQw4XPvp56CwwNYA2BsSY1nsw+zIU9R3Dv6m7oiCwpi/7A8
U//d3wbLnduEiF0QORyTYrQuyf1Aly7bIuushZYhlFIClJy6wwbUqNQzwnZdFYjj
4Ovh5c5dtirBpWu3hWwDJZyiy6O4SowfXXCQK+XhwcJGwqHgb+CD1IwD7WyzbVMJ
ZAnVCsFeW5+dqPuPDnyXgwfZF8MeIUZ2z5zkPPYVxldSpC3d3VGauPpzLoRDq7j8
Hn3w8vAzLO/8mUZAQg3p
=6Ea0
-----END PGP SIGNATURE-----

--KYWjQn08oZ6edC5T--
