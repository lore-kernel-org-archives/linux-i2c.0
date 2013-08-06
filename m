From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Tue, 6 Aug 2013 23:13:49 +0200
Message-ID: <20130806211348.GA3429@katana>
References: <1375219237-9594-1-git-send-email-marex@denx.de>
 <201308051621.51146.marex@denx.de>
 <20130806082029.GA2979@katana>
 <201308061535.50470.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201308061535.50470.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I agree, but I still don't like squashing the two patches together. I for=
got to=20
> mention it last time, but please, look at the patches one more time. Jurg=
ens'=20
> does the DT change and mine fixes the PIO on MX23, I'd like to keep these=
=20
> changes separate.

Ok, as said, I am not pushing hard on this.

> > Then, add the comment to the check so ppl will notice there?
>=20
> If I could add a big red flashing sign into the code stating "If you go o=
ver 4=20
> bytes here, a kitten will die", then by all means, I would add it.=20
> Unfortunatelly, there is no such thing possible.

I'd say if somebody changes the code with that comment on top of it, it
is really deserved...


> Maybe WARN_ONCE and return with error might just work?

=2E.. but if you insist, I can accept this.

Thanks,

   Wolfram


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAWcMAAoJEBQN5MwUoCm2dAQQAJ/hU6k8HDgq8Fhn2/whwwvr
4TxY7ZDhXi0GU64oLja0JW6nlvnW9ZmsvVQihCifMAjh7NX60W1YcLmIPuQIzl72
QXvUezAxCv1xnLS9tfgLzcnmkhUDxUCattvwyIvpAGToCe+hw+rfyAyw8d96xqC4
/+rc69mlyngRG0AMo5qF8xaOmLq5w7ODIfxth+cZccrGniEALPYQdyKhCc9/twaV
IFunR1SeSeo9U4JbvObFGILxPR7EbwmFLFrY4/xNvICz9JdqCR3vGVXAxpfwG/Ev
1kMOPNhHDAmN2fQHXWbs3O1dEPLldeyS+l8PsrO8rpNu/BDj07cNfBUp6SUY63xi
n/Qyp3qpZLL1r9dutTVdmr7WYPTpJ8XjluN2DSMzq5i5tSc1/nbLymJUFq2R0bi+
WTSfrILRVaSSLxEUCwMdVgr+IKcUK6us4h1Pb5VLJJK8W1GXVznSedSfwMXkL3mM
RQMnTb0O7VEC9dWyAMTBAXMF1OlfGqfxcsp3p7SdmKWcBcCXiD64J35aj3WcPgrq
PQGJB9LtytSUcQp/Jl5lYIHW7GlovYVkMX46UudxVv/QpqsmYrXWYR+Ngk53Sn7x
K9Zivuk8k70NQsd6wAzV17Rxp8ytJUa4fZ6/H+mUfq5iuid8nwvzpK4Ki7oYuk4P
yFo4dftwy/YEOIBO2xsv
=6n5V
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
