From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
Date: Fri, 7 Mar 2014 12:18:58 +0100
Message-ID: <20140307111858.GB12274@katana>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
 <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-sunxi+bncBDP47C6LHEIKLVXGTACRUBHOKB656-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Since RESET_CONTROLLER is not required for those platforms, it really
> > should be optional - and I think the real fix is for the reset controll=
er
> > support to provide stub functions.
>=20
> Philipp Zabel suggested that adding a _optional variant that provides stu=
bs
> and doesn't depend on RESET_CONTROLLER is probably better. This keeps the
> compile time checks for drivers requiring it.
>=20
> See: https://lkml.org/lkml/2014/1/10/220
>=20
> I ended up dropping my patch though.

Thanks for the pointer. Well, looks like I need to revert the offending
i2c patches then until this issue is fixed? We can't have
RESET_CONTROLLER (circular dependency) and we can't skip it (build
failures).


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGasiAAoJEBQN5MwUoCm2iWAP/3SWpY0qK8YWK3nROv2UKSaA
1Kd404aSuloiCqXQB6/5ql5Hd3ocj0DgzT3Iahm73kSG78lShft2NZP+a0xgm9PP
hqi7wCFX8M2pFooG8qclki4KQR7BM5NVqtOHZYwM2FEQVbn+oyad8pBNWsKF8qCR
ffYg+NLb7a/aiwzWPGPFqpDxQHFTqfNnvZV076VqoOFmAGGFPdx7bt3UHnX4+2WW
QUq3wyz1okexJTZrgCsT7T0+Ziyayr+d+3cTe00j6/QMJE1bD1oiaGBhP3QXPFIB
G4D1SuCU0uo8w8D2mHS7uR3OYY19NYIE9swKtrsjYS1efP1lNbpsmvo0zkG5k3iH
84cmybq9yisSe29HxYr4fYtuUx4OWoky/M+dCXiTr32wdhBtw8jFrZP9wKIe1yHg
I4o4QjC9C5uup6jhg2zJNylMZN5XPN9NkdTSAQkTzqGT5TjrGhJA7f7VZWtzbO2m
f7IMrV+33xe8tfa6Na6ilFjWqQK62c7Ieg3yDMPo9RsAkznk7zKSHc+jitt6dDs9
3MyBqEd2VpMEiIFAtPrktYIBfwP+Oe1U0to2o/bdLq3mnLuyMT2AAUX2rePFSmf5
Msj4wwkE2owgSDeLD3tUEOJl9RJd+65GdqYz9jEjt1sWnX/OlKZDla0bCrBy1q+/
MKaUOAMp1cLIGHOOxK4J
=YO/K
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
