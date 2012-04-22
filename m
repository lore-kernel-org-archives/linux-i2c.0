From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: designware: Add clk_{un}prepare() support
Date: Sun, 22 Apr 2012 20:38:06 +0200
Message-ID: <20120422183806.GB24810@pengutronix.de>
References: <caa4a0645f80f199b31ec16de37a5c4c9c67a6fa.1334652570.git.viresh.kumar@st.com>
 <b562073871c8c3c13a1f59698f69cfdf65db3b5a.1334662366.git.viresh.kumar@st.com>
 <20120422172611.GA15041@pengutronix.de>
 <CAOh2x=mHS9h6kHxw2of-XWTtv35-SHRRno9Jdkb_3HuDoAovAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOh2x=mHS9h6kHxw2of-XWTtv35-SHRRno9Jdkb_3HuDoAovAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2012 at 11:08:55PM +0530, viresh kumar wrote:
> On 4/22/12, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Tue, Apr 17, 2012 at 05:04:31PM +0530, Viresh Kumar wrote:
> >> clk_{un}prepare is mandatory for platforms using common clock framewor=
k.
> >> Since
> >> this driver is used by SPEAr platform, which supports common clock
> >> framework,
> >> add clk_{un}prepare() support for designware i2c.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> >
> > ? Can't apply, which version is this against? Looks good otherwise.
>=20
> Because following is waiting in you todo list and must be applied
> before this one: :)

Okay, thanks, both applied to next. If you mention dependencies somewhere
when submitting, that might speed things, a tiny bit at least.

> What are your plans for following patchset:
> i2c/adapter: Add bus recovery infrastructure

My plans are to get them into 3.5.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+UUA4ACgkQD27XaX1/VRsLowCghK/jHJZeDdfheOZa14rdTEJH
YJYAn2T9A1cMVFTDtYeOOeQEDHujKbkz
=Uxxu
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
