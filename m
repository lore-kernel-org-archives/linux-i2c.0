From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Tue, 6 Apr 2010 09:52:08 +0200
Message-ID: <20100406075208.GA5102@pengutronix.de>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com> <20100403162939.GA2190@pengutronix.de> <20100403202329.3bdb407c@hyperion.delvare> <20100404032929.GA12800@pengutronix.de> <t2zf69abfc31004040400wc3330285pe5d4602d31e0a52b@mail.gmail.com> <j2pf69abfc31004060048z1b9500e1g9e12fb5bd794dc4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <j2pf69abfc31004060048z1b9500e1g9e12fb5bd794dc4a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2010 at 09:48:49AM +0200, Yegor Yefremov wrote:
> >>> > > I'm using PCA9564 attached to a ks8695 SoC. During my efforts to =
get
> >>> > > 2.6.33/34 running on my system I noticed sporadic problems with R=
TC:
> >>> >
> >>> > [...]
> >>> >
> >>> > > static struct i2c_pca9564_pf_platform_data =A0__initdata pca_data=
 =3D{
> >>> > > =A0 =A0 =A0 .gpio =3D -1,
> >>> > > =A0 =A0 =A0 .i2c_clock_speed =3D 59000,
> >>> > > =A0 =A0 =A0 .timeout =3D 1,
> >>> > > };
> >>> >
> >>> > Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the timeout=
 settings to
> >>> > jiffies. So, one jiffy as timeout will not work. Try 'HZ' here.
> >>>
> >>> So this means the bug isn't in the mainline kernel tree and I can
> >>> ignore it?
> >>
> >> A confirmation from Yegor would be nice, but his logs let me believe t=
hat
> >> this is really the cause.
> >>
> >>> As a side note, arch/blackfin/mach-bf561/boards/acvilon.c sets timeout
> >>> to 10000, so the actual timeout depends on the value of HZ, which is
> >>> probably not desirable. Not to mention that a timeout of over one
> >>> minute (worst case) doesn't seem too smart ;)
> >>
> >> There is also an i2c-gpio-user using non-HZ value. Will prepare patche=
s.
> >
> > Thank for your solution. I'll try it on Tuesday and confirm ASAP.
>=20
> Wolfram, do you mean so:
>=20
> static struct i2c_pca9564_pf_platform_data  __initdata pca_data =3D{
>            .gpio =3D -1,
>            .i2c_clock_speed =3D 59000,
>            .timeout =3D HZ,
> };
>=20
> I've tried this, but with the same result. The bus is still not idle.

That's bad news :(( Did you notice a difference in behaviour? There should =
be a
1 second delay now before the message arises...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku66CgACgkQD27XaX1/VRvdQACffdmbB08StvrgD/Ww65UEB1Wn
/wwAn1I9or+Lpjlha/4rFoFr3qKRkDbt
=OFiD
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
