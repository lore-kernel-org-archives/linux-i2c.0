From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c: davinci: Fix problems discovered on Keystone CPU
Date: Fri, 3 Apr 2015 22:14:39 +0200
Message-ID: <20150403201439.GF2016@katana>
References: <55003E60.3070306@nokia.com>
 <55008AF1.80405@linaro.org>
 <550145C7.20503@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550145C7.20503-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 08:52:39AM +0100, Alexander Sverdlin wrote:
> Hi!
>=20
> On 11/03/15 19:35, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >> The series address the follwing problems:
> >> > "i2c: davinci: Rework racy ISR" -- stop the parallel activities in t=
he driver
> >> > including concurrect registers access. Also simplifies the design an=
d removes
> >> > some bad aids.
> >> > "i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()" -- the rout=
ine is
> >> > over-designed and instead of "waiting" will trigger the bus recoveri=
ng
> >> > immediately.
> >> > "i2c: davinci: Avoid sending to own address" -- works around one dav=
inci
> >> > controller issue when it unexpectedly switches to some sort of slave=
 mode
> >> > trying to send to its own address. The controller remains in this lo=
cked state
> >> > until reset, so it's better to avoid this situation than to deal wit=
h transfer
> >> > timeouts.
> >> >=20
> >=20
> > Have you used git format-patch --cover-letter?
> > Overall stats and list of patches are missing.
>=20
> Will do in v2...

And please make sure the patches are chained to the cover-letter. That
makes reviewing much easier.

> First patch is an important fix for blocking problem and therefore a cand=
idate for
> -stable backports. So, it should be less dependent of the less-important =
2 and 3.

IMO this patch is too intrusive for stable, so I won't add the tag. You
may request that individually to stable maintainers, though, if you
disagree.


--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHvSvAAoJEBQN5MwUoCm2BtUQAIzF36vPZB+V6FlRSh4MCth/
AGWi1P4e1oG2PGtTmbugRhgN3y5S2MG+P2y1uDiW3/i91U7yxVGB4n1Wy6nL0vmX
sbOXSAKDg4GOUB8rcjxuOLhIJgcwMxjO0dxggY73EFLAHtpxOniwgjs8f0soWGLY
6/Pa7mxWSXd5JZ5TiJGXIkyeXJG/qAf5iOdr6Bnb7xiZBizyihYSnW2MpiIRHXEz
O9VfaPJr38W/gJmRR8YGdfZr3kdapcIBxQ7iLT6E8ryLh2uQeRV5zOVEENhNtIO0
9I2IR+UK4vpj7OhmXKI9lRLWdGaL5NL3tyZa1qi5u1N88nqSGTXmSqazn4GRTgT4
GdnEIkE2HqOMwmK8k0Cwdr3aIdBwEaAqGzqE1B119grDS3oOBhtz7Xbd1t/2VzEu
TTwTsQD2MftqJOdFBwfwIBlDmMl65YD356zlP7iwAVOhG9On8XDqMHZFjgdY+wQj
WuSfE8iqOjXKRlk4hlE8IEDWSEPpednmc7fuNfk4eLhUM9FqflMdhIqtwFnZ4TME
oCEa+uQuArE6DDZXX5rplXZ3lW6l5eqDoY/rWZguds9/tO0mUiJ7dNEloI0kajSa
3cs6/oJm7h18K64vRwU0wlwI5hkgy82O1gpwyXVfVDvKB+tEaTXxTH0T77J+WtRR
jB8itdvyy2hH2XmC1GzG
=J5B1
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
