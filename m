From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
Date: Tue, 29 Oct 2013 06:02:24 +0100
Message-ID: <20131029050224.GA2643@katana>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383000569-8916-7-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2013 at 11:49:23PM +0100, Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
>=20
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSb0FgAAoJEBQN5MwUoCm2AMIP/1oLhhO+LyjodG9rA0wXbZh0
YYNf8eplyyiBRKnv5bN8R4xL0MvwQZyauXD9iJmgcE8r2aRelhd96yGsMSJgTsYt
C1qRSlerzZmUI1I/masyHlJpPZtaK5imaSVGyX/RFL84huTLPvBjvDinTpYRe/e/
MJBJV6zAtrIoEdCvxfVhSZFUc2sN809cBdbVIgTQFxgRVqqafKWY6TabEAelP/5i
73aB9MmSg/NYRELBTCebqu9MUj6Rg/8Wa0TorGTTEH77bSPfDcJC0v8A7TANuCrK
W6MHj91p/8NANIJCJzGjaHF39pj0rYJr2lEz6AE1SSx8DakbgSABDy/6es9pifra
z9+dqapAGtnGs2BCLbBnbmQ5ZvhEgmBNWpeqImfwnys+FmeaqqvjcqAmmJbXwPHx
rOqjWAqC30W2cQPMbKukWuFevyiCaZvkvPHnDMAAS3JhsDae36JW++tevXxDG9CB
PSv+sPDyNU5JMkxPH+XIfEoZCoA8RiHGI0s9wAIz1rZ5PP6p8refNdTxazJPF44+
nEMFu065pk78dVjxDmfXHZ62cxad/kUyNk7LUon+rtq6NMfFipPRckrkbaw8fobj
zA20G9SJ60EJ3sNJM7pYR/CL8ybZXPjnVMiFN4tnAS21Em+t6aNk1R5scZqhe6Hb
EasBqyr3lQWW2YLKshN9
=6rOF
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
