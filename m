From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:31:16 +0100
Message-ID: <20141124093116.GB3733@katana>
References: <1499103.qTrcqP28lh@typ>
 <20141124080509.GK4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124080509.GK4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 09:05:09AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Max,
>=20
> On Mon, Nov 24, 2014 at 01:32:27AM +0100, Max Schwarz wrote:
> > Now that we are using the clk notifier framework we get compile errors
> > without COMMON_CLK. But the driver fails to probe without COMMON_CLK
> > anyways, so just add that as a Kconfig dependency.
> Hmm, I wonder how a kernel that fails to compile can even start probing
> ... :-)
>=20
> Anyhow, it would be nice to quote the compiler error you fix here and
> point out the patch that failed to add the needed dependency.

Yes, that would be perfect. But for fixing the breakage in linux-next we
created, this is good enough for me.

Applied to for-next, thanks!


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcvrkAAoJEBQN5MwUoCm2WMcQAJdfCBTLusXgnBGTXy0Jkthn
Uot3d7BcgNUXXaD4q3fQb9B3Ef0Y1Kqvb7VizYbbRl1BPTdXvkxIM682lO16IQmT
LFwN9km5tb1fNSiOoGYsost+LsXEQi8eacF5RSpkIN/VyWz8ELj6q4P/9VNfOjmh
5yV9aTo8n1+kwG921zjgliV/lGf23L50WCSVcRKBVdglXy/4eWeUZqDjTgeM3Y9Y
zb/jGS4/0n8NbPAgqxVLk/XOYVr50uEmyqoyaBUiWB3XCqyx8GW5Xzz4DbMS/2Cu
0LQ9ymt+ly1eH3FsrMGA0yhvp06GG6AevROOmurnMTmJusZVfdYdet+S+SeoucIV
3cySQ20dR5Aw8HFZZLATrCuDs9xQusRuuC609jaOCuUOpya6/vnlKB29jUJxCjhL
PW57zHCGlH4XZhzdzfqW7Yudgb79+8BQcTFYu/pTuDyt/DPDBlcmCj6qMPXoSJiA
zpixnIl28Mso7d+ctGMd43V6Nzu2D8Gp7NQxAuVekozjOvy509f0O3fGyrcO4DuV
FZZ+9vUl8LNNyf36xLMRY2dmM1wrHeIwo2raa4/Ic+VQid20OGb1NZCs2ct3pay7
M8u1J1K7Hs6Q2RhERIfzk0yk3QiHVihJBvYK/QE8o2hkLM+KzyXUG3MSkNUfr3sB
mz/rwGs8HRePqxytgcFq
=5A+x
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
