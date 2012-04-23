From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: add device tree support
Date: Mon, 23 Apr 2012 19:00:26 +0200
Message-ID: <20120423170026.GG27321@pengutronix.de>
References: <1334688545-8465-1-git-send-email-swarren@wwwdotorg.org>
 <20120423111507.GF19192@pengutronix.de>
 <4F957F9F.7000309@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F957F9F.7000309-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2012 at 10:13:19AM -0600, Stephen Warren wrote:
> On 04/23/2012 05:15 AM, Wolfram Sang wrote:
> > On Tue, Apr 17, 2012 at 12:49:04PM -0600, Stephen Warren wrote:
> >> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>
> >> * Define core portions of the DT binding for I2C bus muxes.
> >> * Enhance i2c_add_mux_adapter():
> >> ** Add parameters required for DT support. Update all callers.
> >> ** Set the appropriate adap->dev.of_node for the child bus.
> >> ** Call of_i2c_register_devices() for the child bus.
> >>
> >> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > David Daney (CCed) posted another variant [1]. Just looking at the
> > patches (and not really using them), I tend to like the approach using
> > <reg> better. But I am open for discussion, so I'd appreciate your
> > feedback.
> >=20
> > Regards,
> >=20
> >    Wolfram
> >=20
> > [1] http://lkml.org/lkml/2012/4/12/423
>=20
> Ah, that does look like a reasonable binding.

May I interpret this as an ack? :)

> to be listed last in pinctrl-names (if it's listed at all). I'll update
> my patches based on that David's patch.

Thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ViqoACgkQD27XaX1/VRsbzACeJWZ2Q3iq8pZZV+J/Bm4vX+6V
y7gAnRBJOanvSIpsh8HIXFtfSFdqkW+a
=TUJf
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
