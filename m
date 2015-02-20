From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: rework clk code to handle NULL cookie
Date: Fri, 20 Feb 2015 18:00:56 +0100
Message-ID: <20150220170056.GC12246@katana>
References: <1424363824-6093-1-git-send-email-wsa@the-dreams.de>
 <CAMo8Bf+=Ny-uc+wmr9OsKh9kUhYqVXLw-nM4h+y_OMKx_FpCHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+=Ny-uc+wmr9OsKh9kUhYqVXLw-nM4h+y_OMKx_FpCHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 07:51:44PM +0300, Max Filippov wrote:
> Hi Wolfram,
>=20
> On Thu, Feb 19, 2015 at 7:37 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> > For, !HAVE_CLK the clk API returns a NULL cookie. Rework the
> > initialization code to handle that. If clk_get_rate() delivers 0, we use
> > the fallback mechanisms. The patch is pretty easy when ignoring white
> > space issues (git diff -b).
> >
> > Suggested-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> > ---
> >
> > Max, can you please test/review. I can only compile-test. This is the o=
utcome
> > of this thread: https://lkml.org/lkml/2015/2/5/544
>=20
> I've tested it with and without HAVE_CLK, both work well for me.

Great, thanks!


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU52hHAAoJEBQN5MwUoCm2dkoP/2yfIEFaM7TTjukPqDwgYcYl
OIdg/5N6QqMdQNiYZxqUPMq5geITpl2w3f0tLVzIMgjInNJCvcJTismpuqJ10IFh
ZPhj11tZ4ikYHZ20zsUkymqJ/iimXaI6w1Y/9ZE2Wyf8sdY+VBXuXqkDl+EUOIZo
LQoZIkJTXCqcYbUGPhLq7bYGMLjc9xI0fG9rLIHCKkF2zrwcpmd7/ck0LfZYieJo
wKCbbh0vOcGzgDIxddHp2cxwRnYmzjCH//t57VuGOGmDkep6ptdQkqRiPFiqIRDe
e96nIYB/rE5AseQSur7+zJJXOusg6tMfXAEwBemDgsZyXkMlJZAuRKh6mroJ5L8x
8sEjCLK/jk0bN3omsAGK2cfIdShIPO0EsUGU42AO6RtNCjfYCP8nWQCBLwPrpSk/
R1EDCQpc3xT9H5PgB0KYh/I4xn50BQntfgie+GBBq/ckTkjrkICsarlR+XBVXwRK
zlGZlXn/whZyA+CqSlZBWfdMOD08weyfc500UM1npSxLpPTxFJw1B7RWY5BMUX9K
H49V5H3rJeAGPsikC5QptdHdcFBEYY413yU9Ui75ZMI5KfVxYuQcyJuDnAxH/MEr
IHqnMfdD0bgEpzdFagEUnFrM8It6cwhnGUjVkzjb/A7ihkC+gOgElERfSNKWqRsV
VtCxNsnJ9aq8fnEgV+SC
=S/5r
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
