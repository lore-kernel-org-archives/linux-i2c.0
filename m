From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Tue, 30 Mar 2010 04:48:31 +0200
Message-ID: <20100330024831.GB23862@pengutronix.de>
References: <20100327121558.GA5880@pengutronix.de> <20100329162812.548d131b@hyperion.delvare> <20100329150956.GB6717@pengutronix.de> <20100329172734.7cd7341d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100329172734.7cd7341d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2010 at 05:27:34PM +0200, Jean Delvare wrote:
> On Mon, 29 Mar 2010 17:09:56 +0200, Wolfram Sang wrote:
> > Hi Jean,
> >=20
> > > Sorry for being a little quiet, I took a long, well-deserved week-end
> > > off and didn't have the time to reply before I left. Now I'm back...
> >=20
> > No worries, no rush :)
> >=20
> > > Yes, my intent was to add a call to i2c_set_clientdata(x, NULL) in
> > > i2c_device_remove(). We would do this immediately, so that drivers can
> > > start removing the call on their end quickly (and new ones are not
> > > added.)
> > >=20
> > > Can you please send the patch for i2c-core and Documentation/i2c? It's
> > > not difficult but I don't want to steal your credits.
> >=20
> > Yes, can do this in a few hours (already midnight here), this is for 2.=
6.34
> > then.
> >=20
> > > It would also be fair to warn all the developers you already contacted
> > > with your first attempt and let them know that it is being cancelled,
> > > and let them know the new plan. Hopefully this will avoid useless
> > > commits.
> >=20
> > Can do this, too. About the removal of the i2c_set_clientdata-calls:
> >=20
> > - shall I prepare a series for that, too?
>=20
> Not sure what you mean there... What's the alternative?

I was confused by your "so that drivers can start removing the call on their
end quickly". It sounded a bit like they should care themselves.

> > - also for 2.6.34?
>=20
> No, 2.6.35. This touches too many drivers for 2.6.34 at this point in
> time.

I agree. So I base the removal-patch on rc3, so it can go to linux-next. If
there are other users of i2c_set_clientdata popping up until the merge-wind=
ow,
it will be handled by an incremental patch.

> > - also patches per subsystem?
>=20
> Not sure if it's worth the effort.

Not much effort, I made scripts for that :) Still, I think it should go in =
just
using one commit. Let's hope it won't get too intrusive (=3D creating confl=
icts).

> > - shall this better go via the i2c-tree?
>=20
> This seems simpler, yes. I don't think subsystem or driver maintainers
> need to be bothered with what is really only a cleanup.

Yes.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuxZn8ACgkQD27XaX1/VRveSwCfYjXiNkmUrg47mgJ6PWQbbfNS
f5gAn0iCiFDCsO9A9XRm4ohbSwnoNxBc
=rd8t
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
