From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Wed, 25 Jan 2012 14:34:23 +0000
Message-ID: <20120125143422.GM3687@opensource.wolfsonmicro.com>
References: <1326984171-21209-1-git-send-email-jayachandranc@netlogicmicro.com>
 <20120125134055.GC4755@pengutronix.de>
 <20120125134514.GA2054@sirena.org.uk>
 <20120125135236.GD4755@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120125135236.GD4755-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2012 at 02:52:36PM +0100, Wolfram Sang wrote:
> On Wed, Jan 25, 2012 at 01:45:15PM +0000, Mark Brown wrote:

> > ...but note that opinions vary on bothering the versioning (it's not
> > likely to actually annoy anyone though).

> Huh, never heard of those. When digging old/lost/forgotten patches via
> search engines, the versioning does help a lot, for example. Even when
> going through huge mailboxes, I'd think this may help to prevent that

Personally I've never found the version number added anything for any of
that - the fact that it's vX doesn't say anything about vX+1 existing.

> old patches are picked? What is the reasoning against versioning?

I've not seen anyone actively objecting to it but it's certainly not
universal that people want it.  Mostly just due it not being worth the
effort maintaining it, and the occasional confusion it can generate with
new patches having old versions (eg, adding a new patch to an existing
series).  There's also sometimes the depression that comes from seeing
large versions on what ought to be trivial patches.

What does seem to be more of an issue is that tracking the versions of
patches pushes people towards other behaviours which aren't great.  The
one I've really noticed is that quite a few new contributors seem to get
the idea that both the version numbering and the series numbering get
attached to a patch the first time it's posted so even when a series
should be split (eg, because the core bit of the series which everything
depends on got merged) so you see an individual patch posted as patch
3/4 or whatever.

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIBLoAAoJEBus8iNuMP3d1vcP/RfQmbNkB4tYrjnE+BePwI/u
AGSLAciFr2ur5ftnMG5RRXwo12feNpqlE2Ze9qKK2AqTY74OCUpFJoPAxAMGF5Cd
JLUEo/0K5qProK/RpUbiOmVKL5TBfMNFFvyCHvOMMmXE6BdRaAt8EPyr9vNfHg8/
ItdB8Hy657tmE/X5XL9j7VU0JmUKdAnen2zwqgbHGWtfcD5+J0KfTy4z/C7gKL0c
7ft5GLs+G/ZdYdfoPcsGd7Fdk/0aZt8NihauWEidMtrj9ciuEGBAUsBbB4Y1DDZi
EayboymoEbGvew4iWIVAa3tgPaW7PSCH2/D+XWG0rSXHXUKA13Y+hOncWoOnfzxQ
WZL0vicl+VhP+REthNQl/Xq/97GhohezrlVCLKxk5qjFEob9kMoQzD1W9A8kAbsh
hwz7xlZjw+FKwanNpfXKUtgz7ojqquFYm5WOEgWYgFTpzUHUTjj4t3BgCWc0vsfx
HEavirPA4xnt5u4Gi7rB+5d1gyfCg8Gpyqi3xOng8Bc53c/Y076aaZXGV4td4UWC
X+0Lrh2uduPLBvQF0BhdlQC3rNI4U5fhWGcZ8DmK2ASLdeVUgXH4wsOpnkfw9K9i
SHZ+qBGinbVY5TkCV/D+Wh6qeUA2WdY8sMPZZVW+mAlY4dRlnejDE2PAvs+AvOOB
0cIM5cm4gTYBeIjUFp2I
=k3Xa
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--
