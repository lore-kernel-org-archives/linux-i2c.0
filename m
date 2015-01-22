From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-ocores: add common clock support
Date: Fri, 23 Jan 2015 00:21:48 +0100
Message-ID: <20150122232148.GA17463@katana>
References: <1421230899-7843-1-git-send-email-jcmvbkbc@gmail.com>
 <20150122144522.GF3413@katana>
 <CAMo8Bf+XJY_bY+OB2i_SZQmAavwERG39BR8FVj202V-E3UidPg@mail.gmail.com>
 <20150122150717.GJ3413@katana>
 <87wq4e7jqy.fsf@dell.be.48ers.dk>
 <20150122185711.GA14880@katana>
 <CAMo8BfJdmB-=i4bJypHzGvegxgBPafpiT_hyQXLhvzBUmE+u_g@mail.gmail.com>
 <20150122192649.GC14880@katana>
 <CAMo8BfJqS1O=ZiVs89wsuNuQ_Qt=2BJtcens=09POucM_OjXrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfJqS1O=ZiVs89wsuNuQ_Qt=2BJtcens=09POucM_OjXrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 11:53:51PM +0300, Max Filippov wrote:
> On Thu, Jan 22, 2015 at 10:26 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Thu, Jan 22, 2015 at 10:15:40PM +0300, Max Filippov wrote:
> >> On Thu, Jan 22, 2015 at 9:57 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrot=
e:
> >> > My suggestion is:
> >> >
> >> > 1) if there is a clk node:
> >> >         - we get the clock rate via clock framework
> >> >         - "clock-frequency" is describing the bus speed as usual (No=
te
> >> >           that parsing here can be as simple as checking for 100kHz =
only.
> >> >           Although a seperate patch could probably easily add suppor=
t for
> >> >           other bus speeds to)
> >> >
> >> > 2?) a new binding is present to specify the IP clock speed:
> >> >         - is this needed? is somebody using the driver without CCF?
> >> >         - if so, the new binding is parsed and evaluated
> >> >         - I couldn't find an existing binding to specify a clock spe=
ed.
> >> >           Please have a look, too. Otherwise we need to introduce sth
> >> >           like "opencores,ip-clock-khz" probably.
> >> >         - "clock-frequency" is describing the bus speed as usual
> >> >
> >> > 3) only "clock-frequency" is present:
> >> >         - we keep the current behaviour to be backwards compatible.
> >> >         - driver should emit a warning to convert to new style
> >> >         - must be marked deprecated everywhere
> >> >
> >> > The documentation should be updated accordingly.
> >> >
> >> > Thoughts?
> >>
> >> I can update my patch to do (1) and (3), leaving (2) to whoever may
> >> need that.
> >
> > Please implement (2) as well. Otherwise we would have documented
> > ambiguity of "clock-frequency" which is bad. It shouldn't be much code.
>=20
> There will be ambiguity if we want to maintain backwards compatibility,
> so we're documenting it anyway. And since we're going to maintain it,
> those who don't use CCF will still have option (3). Is there a point in
> introducing (2) which currently does not exist and thus has no users?

Yes, because 3) is marked as deprecated "DON'T USE". If you don't
implement 2), then we force people to actually use the ambiguity!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwYYMAAoJEBQN5MwUoCm2BJQP+wc+ZoNTBA8PiHAmrHxPvaqG
f+8nE0Zt68w0h52wocWHabFi/88XXpo1Jc/gVlj5x280zR9usO9iK4k4IWlI17uE
sEeKOqaZ5IJ8ArrmsAhMvznzFTy9QCnePsk9MCF8OWvvXhmH+RlRUuodvbwQFVQ5
fPqCs1Oo7rUL2eWOiEqxQip4JdQ7W3slxlxyXD5N+Re47nYWC50Ma8K/377ggIRB
n33LXaYVWdu7R93pV3OMD1xMdLldenHaPKZ76DgBLiwEI3RMnfJg3eEvTuqMPSHn
bqAwfrLNyVwsYLk0sqvS605whDMyx98j4YkjQoOOU2IddNVo6/ZhE9WIASlipaqQ
TOycqWVBupR9q0Ij/BtjE7UoP41+Oihi0L6OJNEW7v1OqH487ifOCumqDBVznYNA
Ine9ncbWCrAYvJ5JLg0ew6t9utRFCUDh5l98Z5+lEg/6yqqpPtNfNz8tTiVnucEl
hF4YTW9hieqEvYsbWGc8hxjVZkGfZxwJz5CBXdCJI398h7pTuEbUxSNYHHlIOAZg
GNxq8W0jvOeeYupxFOGduV0r2csNaDNI0qf1LcHGltUMgphtt/icvhSL3BOBBtiL
xf2/j2mo61uiv56Wlmwl4HZFTOOuVYlV5nBAxKXCnKQAyX34p+F2E8J+yuTi8LT4
gig7x2awr+H0NuogSiUj
=Y7pM
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
