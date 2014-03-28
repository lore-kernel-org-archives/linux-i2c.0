From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix reset controller handling
Date: Fri, 28 Mar 2014 09:24:06 +0100
Message-ID: <20140328082406.GO6120@lukather>
References: <1394449930-29696-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140328074900.GC2708@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140328074900.GC2708@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 08:49:00AM +0100, Wolfram Sang wrote:
> On Mon, Mar 10, 2014 at 12:12:10PM +0100, Maxime Ripard wrote:
> > The reset framework recently gained optional stubs when CONFIG_RESET_CO=
NTROLLER
> > is not selected. It also introduced a function reset_get_optional, that=
 is also
> > dummy-defined whenever the framework isn't enabled, for drivers that ne=
eds an
> > optional reset controller.
> >=20
> > Switch to this function, since the mv64xxx driver is in this case. This=
 also
> > fixes a compilation breakage whenever the reset framework wasn't select=
ed:
> >=20
> > drivers/i2c/busses/i2c-mv64xxx.c:771:2: error: implicit declaration of =
function 'devm_reset_control_get'
> >=20
> > While we're at it, remove the redundant test on dev.of_node surrounding=
 the
> > calls to reset framework functions, since it will either be a valid poi=
nter, an
> > error pointer in the case where we called reset_get_optional without an=
 of_node
> > pointer or if it failed, or NULL if we're not loaded through DT.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>=20
> Applied to for-next, thanks!

Thanks for your patience, and sorry for the mess.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTNTGmAAoJEBx+YmzsjxAgtvAP/A9YA6oAIPHQNwNHyfseeUPd
b+71q7br4dBX+SUEHzJTZMGvUWO0ApNE2lMfqOBpNkrZXGtP3CagVdTmSMwo/YzY
W1LJfG3CGFZ1Gq+9r9sOcOoK03EzxsCykwdCvlOlC+itah7qfU8zAeIaNQDOQ4gp
FsXHw1vO0vpY5rfip6kklbpP0zi5+gBUJrFdizwgaLsigy+n5cjkEPWUUuS+CA6z
KEsfFBUtU2yCLuL+dfUWQXwcpPh5mEmPNLzUVPz7wqxfjv7HnA4ev6jt+l2cdNPV
xguKuYdfT/qzbh/U3veNmIUSLmKtDkF+s5gYzDxXauoGg/CnGhbdRFQtEdLGZTwk
xJo5LA7J+imgpQinr9xDCQlLVJHpc46l2MST7zjBBKU6S+27crYhJ0WuHOtUr89t
4KQbcc/Pd0vQMn5HdLYtE4YSnUCq5ROGsMP6Y/ESJVKgMLHoZHZKjQSzs0KYKGcA
E4ZOJD8ArkO0s+A/xpU0wBilo6n0RvLOsEnWqYTE/SwkMToUHUT/mj1Itg9SwWcK
8adtwUpbQNEzLtRRLIeqwyuevzwBaX7cAtVpmxbdztzNHtInSX3/OSjcYiYVPJPk
9LQbnieHwHBphpOdpBBnRgd71QVXhYSmAzYKnEw+kUGCfzJ9mRdq1C5Y9mxiGcXg
wT0NXFSBl2wQZMYPJmCg
=sO4j
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--
