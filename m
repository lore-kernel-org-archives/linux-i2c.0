From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 8 May 2012 15:57:59 +0100
Message-ID: <20120508145758.GV15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
 <20120508133411.GP15893@opensource.wolfsonmicro.com>
 <4FA93391.8040905@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bk6L21jbBNK7V1Rv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA93391.8040905-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Bk6L21jbBNK7V1Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:54:09PM +0100, Lee Jones wrote:
> On 08/05/12 14:34, Mark Brown wrote:

> >Looking at the usage here it looks like most of this stuff shouldn't be
> >there even with non-DT stuff, we probably don't want to add DT bindings
> >for those bits.All the voltage setting is not at all device specific
> >and can be done using the generic regulator bindings, the forcing on or
> >off is similarly generic.

> All the generic properties _are_ set using the generic bindings. The
> only vendor specific values are the initialisation register values
> referenced above. I'll see what happens when I remove those from DT.
> I have a feeling that the regulators will just fail though.

The comments in the arch/arm file indicate otherwise - they were talking
about enabling and disabling regulators, and about setting voltages.  It
may be that the comments in the arch/arm code are inaccurate but with it
being magic numbers you'd really hope they're accurate...

> >While looking for the original patch I also noticed that you're not CCing
> >the mailing list either...  please always CC the subsystem mailing list
> >on patches.

> You don't appear to have one. I ran get_maintainer.pl on the patch
> and the only ML it came up with was LKML. If you do have one, you
> may need to update the MAINTAINERS file.

LKML is the relevant list here.

--Bk6L21jbBNK7V1Rv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqTRnAAoJEBus8iNuMP3dbFIP/j3tLkNFRyCUOALLAymddVCa
OWaRlSmD4RiXKSLvVGsfkSDqzSJsget6BUEQJtycNJd6U3nn21tH/QFmRnWd75cZ
7K3CFA/LjorNerM0wGiYX/2ZTFK71O6XW2X8xGXAkmds2UW4vkkItoQTrXXjKXHx
4buLIjpaIUJQThCBnpi/BFLZ9BYjrf5LU1YNwi7MEDNbGouiRs8K1i15o2tjmH2V
0Q5c8rj+KrmtvGIJ0ILBtcY7FjFjiMCIxCIzlHzCIQ+9XaC10JZEYX2+rX79Cfc9
Nv+bSWPaQiERL4mSbJsyC4Ercue3x9mMdDFSkTkF1Q/aadIePToTsi9aLqZV7NS3
FaYSZkI93h88iGhr53QFQpifH/Nfwoybbw89s2mC2Xbvupymg1qQ7ocHA5nRAWsc
bJAZQgL0uT8nULNg1ABipomeX6Buxw5Yk9NR8ARQ+HqfJ+GEaB8KULg/d2MBw6MH
k4EQq3LK6qqRdWktjGNp46iHRw354BNpPr58IJFkYX2rxzotoGH+dsDYYmPQ51fo
B6wPvDUGIelXLF0aTuRqqH2drEPmPYPmpiVTieN57+MHgVvfZM+piMhJ0y2zYXst
0UQBW/RO+g4GXvxMeVtPNYFgrycISgnC8WtamOUduyrD9efKur/A3iEmNsRwmu+N
S/QmMFO5i2pvYPsnSKcH
=fyHO
-----END PGP SIGNATURE-----

--Bk6L21jbBNK7V1Rv--
