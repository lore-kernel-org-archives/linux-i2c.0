From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Mon, 29 Mar 2010 17:09:56 +0200
Message-ID: <20100329150956.GB6717@pengutronix.de>
References: <20100327121558.GA5880@pengutronix.de> <20100329162812.548d131b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100329162812.548d131b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> Sorry for being a little quiet, I took a long, well-deserved week-end
> off and didn't have the time to reply before I left. Now I'm back...

No worries, no rush :)

> Yes, my intent was to add a call to i2c_set_clientdata(x, NULL) in
> i2c_device_remove(). We would do this immediately, so that drivers can
> start removing the call on their end quickly (and new ones are not
> added.)
>=20
> Can you please send the patch for i2c-core and Documentation/i2c? It's
> not difficult but I don't want to steal your credits.

Yes, can do this in a few hours (already midnight here), this is for 2.6.34
then.

> It would also be fair to warn all the developers you already contacted
> with your first attempt and let them know that it is being cancelled,
> and let them know the new plan. Hopefully this will avoid useless
> commits.

Can do this, too. About the removal of the i2c_set_clientdata-calls:

- shall I prepare a series for that, too?
- also for 2.6.34?
- also patches per subsystem?
- shall this better go via the i2c-tree?

> > I could check if there is any probe-function calling get_clientdata and=
 making
> > use of that? That is probably the most obvious thing which would need t=
o rely
> > on the current behaviour or did I miss something?
>=20
> You are right, but I really hope you won't catch anybody doing this.
> This would go against the device driver model.

I'd also be surprised if that would find something.

Regards,

   Wolfram

PS: I will also have a look at the pca-issue after that.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuwwsMACgkQD27XaX1/VRtiwgCaA1ZRMSWS94h68wBO5Y7i2TKl
ZicAoLjfaTZxFMNif986gKwYmhqWvQ6g
=a1kp
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
