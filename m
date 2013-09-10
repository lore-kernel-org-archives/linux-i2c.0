From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
Date: Tue, 10 Sep 2013 22:35:22 +0100
Message-ID: <20130910213522.GG29403@sirena.org.uk>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130910142631.GL7393@intel.com>
 <20130910161321.GM29403@sirena.org.uk>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q9n8numIABrgkMWU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3397524.g9aUWuArnm-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Q9n8numIABrgkMWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2013 at 10:04:21PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 10, 2013 05:13:21 PM Mark Brown wrote:

> > OK, that is very much not the model which embedded systems follow, in
> > embedded systems the driver for the device is fully in control of its
> > own power.  It gets resources like GPIOs and regulators which allow it
> > to make fine grained decisions.

> There are platforms where those resources are simply not available for
> direct manipulation and we need to use ACPI methods for power management.

> Now, since those methods are used in pretty much the same way for all I2C
> devices, we add a PM domain for that to avoid duplicating the same code in
> all of the drivers in question (patch [2/2]).  Does that make sense to yo=
u?

It doesn't seem like a particular problem, but the existing usage does
need to be preserved for the systems that use it so things like having
auto as the default and updating the drivers seem like they're needed.

> > If we're starting to get a reasonable number of buses following the same
> > pattern it seems like we're in a position to start=20

> We need that for exactly 3 buses: platform (already done), I2C and SPI.

> No other bus types are going to use ACPI this way for PM, at least for the
> time being, simply because PCI, USB and SATA/IDE have their own ways of d=
oing
> this (which are bus-specific) and the spec doesn't cover other bus types
> directly (it defines support for UART, but we don't have a UART bus type).

> Moreover, because PCI and USB use ACPI for PM in their own ways, moving t=
hat
> thing up to the driver core would be rather inconvenient.

That only applies to the power domains though, what Mika was saying was
that the process for enabling runtime PM (just drop a reference) also
becomes easier with this method regardless of anything else - that makes
sense to me as something we might want to end up with so do we want to
just move towards making that a default?

--Q9n8numIABrgkMWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSL5CXAAoJELSic+t+oim90qsP/35q7PedCsE1rF1ZJ7nisDyj
mafrqD2KpZ9+9/d7XNg+uiO8RNYtn2ULiqJdQy8/fzECwzCG9yRIKDKL0UT9MpFk
RN60zJ+7Qm2A+5T+Gz1iAfI82sw8A7ugijxUTxlANXRXMu9bGFb0kvvaTnbvBZoj
oBxsCdv+xivyVXHMjFlDtEWnl9NFACpBojDPxQaZ5/N6WU4YnIZqQXhl68Z9WJVl
8gw6E7i26l+CIeux11o7t2pMu7r50omTsMMZcysN73US2WylmR1R+41639SC9cvg
oF+VMbZHNQboQGdraKJK7vYfS0bj20ZHEjwYCeMcGK7jb2Me0KBBoJ3c2uTjtxHM
PMhp1+X5uFyqxxpwEOqxP1nShyysvaWBjjgNZCvKHJQNxCEq4aIieg3Y7HEzw+RW
nMqPu9hyRoi1ARUFcAsoUe6wfDSGN7yFRw1TnBDgN/fplvpPHWza7zVXV8gMSxO3
sgPJccHvpXEiquHXQBxeBaOM2BWoMMsEcOzzKej1uSfoxw+9Y0wEFbp1Qibz0hoB
VMr+AG3XH711PL92joOMf9G79T2HczzhwDqkMkMN8AxAvfkbAAQDNhDwHoPprmSp
Pfz/9hhl7qgP2H5DTjP+ZhDaTgUZXMIoQwbc3et6HqIMEUiB6MdDWVTe6r9uCFT2
WbZk7UOEBR8skoBNF6nq
=x1Vr
-----END PGP SIGNATURE-----

--Q9n8numIABrgkMWU--
