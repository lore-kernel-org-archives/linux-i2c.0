From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c/mpc: Fix ISR return value
Date: Fri, 27 Mar 2015 14:47:40 +0100
Message-ID: <20150327134740.GD19151@katana>
References: <1427460540-7754-1-git-send-email-amit.tomar@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427460540-7754-1-git-send-email-amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 06:19:00PM +0530, Amit Singh Tomar wrote:
> ISR should not return IRQ_HANDLED for not handling anything.
> This patch fixes the return value of ISR for the same case.
>=20
> Signed-off-by: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFV98AAoJEBQN5MwUoCm2L58P/2qDoDAhieg87ZrEdMecr9gQ
cxWE4ZHOKaf0kmw0EbOAjlz/jw9WT5cDSayPqqVlRGxyQ5w3pD1tJfi0i5Kr9HL3
Yl4gkzPuRo6oF9jiXnvfA1jzuBLsiWL8GLx3kaquUUYKl5hTz4d2/PAeuYyRnfap
WGsJR7levR9gxyh89aQC6etz17SP7jCSprHp9guTz0eV1W50YNh8KQAVPAFnpHuq
MGkAdzwA0gjC6cXov+x5x4am160wHVJ4olPPRbOk4nfYT8l8MCsQEIEKDPuUIIm5
4L+/67MzbudGqK2DJ+PpQD0ml/AtmGYWbiREbmJrY/UqlquqHURXzsb6dDYmMmmZ
M+UI/+8N424Bwd519h0pbxXBr/PefIch/VGd3xnk2xlsBFwJYNWE1tKBvr9+KW2X
28CSz1oCvBr86FdkiBn1YxGTNucQ58LvfaUx+dpTaED2FMdhlzXTUoW9srH0Z6Q6
jl19vdnC4XGXNNSabWik7dRDWX7LLoUtawf2Yg0HpZ8H6MduoiqWct2p7QFZdwiK
l7oovlpTRVFDlrZ8QG3Cf0TLJAYEnz+lMe+4dn8jR6z0JnImq3YwNCEvrSwYfxyX
wLqnniKH8zIrhd/U3pnIF7p4SbOLWJ4KgHYSSrQ/q1byjc9ML//AhWo7Sq9zupNW
Gu2Xir6Kr1IANtt3ZRGo
=yfNs
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
