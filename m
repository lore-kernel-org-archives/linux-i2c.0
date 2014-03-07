From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
Date: Fri, 7 Mar 2014 14:44:12 +0100
Message-ID: <20140307134412.GR607@lukather>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
 <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w@mail.gmail.com>
 <20140307111858.GB12274@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DHnhIMemoiGGMQp1"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYE246MAKGQE2GJCM2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140307111858.GB12274@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DHnhIMemoiGGMQp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 07, 2014 at 12:18:58PM +0100, Wolfram Sang wrote:
>=20
> > > Since RESET_CONTROLLER is not required for those platforms, it really
> > > should be optional - and I think the real fix is for the reset contro=
ller
> > > support to provide stub functions.
> >=20
> > Philipp Zabel suggested that adding a _optional variant that provides s=
tubs
> > and doesn't depend on RESET_CONTROLLER is probably better. This keeps t=
he
> > compile time checks for drivers requiring it.
> >=20
> > See: https://lkml.org/lkml/2014/1/10/220
> >=20
> > I ended up dropping my patch though.
>=20
> Thanks for the pointer. Well, looks like I need to revert the offending
> i2c patches then until this issue is fixed? We can't have
> RESET_CONTROLLER (circular dependency) and we can't skip it (build
> failures).
>=20

I just sent a fix in reply to your mail that should fix the issue
without having to revert the patches.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--DHnhIMemoiGGMQp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGc0sAAoJEBx+YmzsjxAgFgQP/37xNPl+RtB5VslRlcnXI+KX
cOL20b8NpUSGGVQZYfENw8R1pNDR1/P7zcXxLNsiZq6pPiS5LkcF5T4qfaIrP/uG
qZ+ibA9RCA/HRu8/wmxtOL8xjWY9adEblQb9vS+YIY3c8z5PsxixUO1YuSGWeTSE
Gs6Y7XYkPbU9QsTKYpt19EfIOr6LXg6yTfQC0sVXvZE8qxaVP5rDaQFKm83lpFPq
ENrXI3ne/82ZD6DGj0GcoHy5nRDHm/8zbuB8DIfxYeYLHi1OFsP5jB58rsEX2cDp
EnaxDZ6WAjAGVwktw9oT28NZ6juNgWEglZvLhOKGYgTH9dpB8JVrtxU/zSIykKM1
OaAUg9xiy+vBwsFxvmK1uO8c0/2e1EAs6I/XA3EIYa1w0lYA4519YBexLlVJiH5I
mvbWLCswFv2jp2pICb9WyD3PxLrSbMui+0xp6m8g51syUm7M5hmavhk+z423L1yO
DwibCMtfQwR9/H5uFHuoVKw1DMsny71HapFKYdveSg+M8GrfELUDcZEBaa71gbI3
ry7kkQdsGbSYGX3oJgqHLGAiig61kSIoYX1J7ZphlhceZ9QTH0fJ6YFWXrMBn1c7
UAMj3QLmg86Axv8S459u+xCjC4tmpEHToW0HnGLTH7OQanCw2GIcDKUCjLKpdGbA
zWCWiK8HFW1omySLiXv3
=Icfr
-----END PGP SIGNATURE-----

--DHnhIMemoiGGMQp1--
