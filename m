From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of
 INIT_COMPLETION
Date: Tue, 5 Nov 2013 11:56:06 +0100
Message-ID: <20131105105606.GB2660@katana>
References: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
 <20131105101055.GA2660@katana>
 <CAK9yfHwv3T6OXO59b+VeFHLU6mxn1Gw+BotOBLUukHuArZ0qig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK9yfHwv3T6OXO59b+VeFHLU6mxn1Gw+BotOBLUukHuArZ0qig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2013 at 03:51:58PM +0530, Sachin Kamat wrote:
> On 5 November 2013 15:40, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Tue, Nov 05, 2013 at 02:57:10PM +0530, Sachin Kamat wrote:
> >> INIT_COMPLETION was replaced by reinit_completion vide commit 2c9627cc=
a471
> >> ("tree-wide: use reinit_completion instead of INIT_COMPLETION"). Use i=
t to
> >> avoid the following build error:
> >> drivers/i2c/busses/i2c-exynos5.c:538:9: error:
> >> undefined identifier 'INIT_COMPLETION'
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > You can ignore this topic. akpm (who has the change in his tree) usually
> > takes care of this.
> >
>=20
> This option does not show up with allyesconfig. Unless one uses
> exynos_defconfig and specifically
> enables this option, this error will not show up.

sed will find them all.


--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSeM7GAAoJEBQN5MwUoCm2uqQP/2bYAlrN0fpPZMGI0H2wUF+e
f1TJ5NHFZ8hu6C/Dx9vkcCCmHwI+JsOBLM2y+q21rCFSqV2l7Q3nnLJNo/Ejuw/a
3DFPzmOxOVohclXyjTIbPTnpayxNWkByVUbkegKEMAUXfsign+jx3NOd+jkyJ8/e
piRaa4bZLDnCrxIdJ9mQrb2ujgqjDCCb9/gX+o6c22bGphwaWhizwYHBOxzWUQLD
na1wFpTzuOr5yaH/7oZdZGqM7EiOzmNmJUHUQJ1unUNoaqHrwya8J1Cc3/CGKO0q
ap+rvPvzEvPo8IOG+4OW7ISO2FQcYoYKRHzkKZS7wBn5eS6bhbphamt0x7/Ak3ZU
0QnXoranLA0/TyPOeNg/DFqCnsg+QIaquMFG+4QE1XTu11hZ7/0wkK7f/6VnGn4C
OJKhMcDeICUqp9RcHi82So2UUJ3pDI3a2mYDHmg2UZC5ToUxmks5vKejR6fSxsNe
YSWJ7j89L7EKFFc5qtShcTEq9HRwiPx8rDYebnkiqWo4f+VujOSDOknS+IYALrRC
KReAIoV0PwXsh1fQkbbnmpKMYmfz4vv0lM7dP2x5drHNXgn4m45DKE7lUQTvniU8
3XsMnAxuIQ/6o7Wmtyln2q2EIn9gK07mVSDiyCa2PsersCrxjZSdwHXrRl+p4P1x
NCBmr6YrbiV1PDfIRU6i
=JhG/
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
