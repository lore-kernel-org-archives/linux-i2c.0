From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: pca954x: Use the descriptor-based GPIO API
Date: Tue, 3 Jun 2014 14:21:58 +0200
Message-ID: <20140603122158.GD2713@katana>
References: <1401754973-13274-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1401794126-22244-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401794126-22244-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2014 at 01:15:26PM +0200, Laurent Pinchart wrote:
> The ID-based GPIO API pushes handling of GPIO polarity to drivers.
> Simplify the driver by switching to the descriptor-based GPIO API.
>=20
> This also fixes a mismatch between the pca954x DT bindings that document
> a "reset-gpios" property and the driver that requests a "reset-gpio"
> property.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Applied to for-next, thanks!


--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjb3mAAoJEBQN5MwUoCm2qgsP/i8qXTZJnKm7KcbpV8tUMx5z
2KfXjr8TsrsaP+lD8aYwljpMC8dgI6dzXw+ZDRlHak4cS7Q0QDV4oDggVBx2GRsi
p9bQ97kg7jCc6FO/rrcS9x52NRP+KCG7NLu/+zPcI8fjJykkPbLpu1Nptc5Jg9Uc
3AD4K55dd0ALRySRDEhR5h+S3KVLjPlbt7r3dweKoRRykht8QRcdaq+bWTdQG2Vj
1CAOM/yaHX3YOpZ7FOvGTcg9hiWP+wHqYnwdsE5711lHESRPTaV+pUUxKMkrnKEd
2Jt8xnimNzHoAtfmIKHqRauBNP2rvPuXNZINAHHnHxE9aqLi4/aCMgvpiDIY7gtD
ZX+nUz8egKE+1rlJDQ5t74l/RQxaXEITSog0yCIoAOxY5JtqOkN9BnDyLSo13YPp
ybeuK/ymzGkwvJbtL0x6BLOIoIs/gXsdipr+6HnP7O5XL/EUTy7Ef09BwlVW0c8r
WTlwLsk60NV/ibcI9ztqqxwfmFOKrUE0DoemAJVPsnnYQJFj6lSL+aKNOlw/wk5T
NCL3LBb6XBCRBidp9417CgIJxFFZBsTVqABQAy/0OYHDH4FgLMk1iNdtXTx/SrrM
soKgGxyViieQRjt/4W9ZFaaq8uPzTXTAtl2FdiAMxpGmToXkMcEzi/b7YLsc48Dd
b/5sQBFK2pIVqS6/dlkk
=RTgB
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
