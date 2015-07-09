From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: jz4780: Fix return value if probe fails
Date: Thu, 9 Jul 2015 22:17:49 +0200
Message-ID: <20150709201748.GP4744@katana>
References: <1435635718.14315.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3loezlmesXOUD0D5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435635718.14315.3.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3loezlmesXOUD0D5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2015 at 11:41:58AM +0800, Axel Lin wrote:
> Current code returns 0 if fails to read clock-frequency DT property,
> fix it. Also add checking return value of clk_prepare_enable and
> propagate return value of devm_request_irq.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Applied to for-current, thanks!


--3loezlmesXOUD0D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntbsAAoJEBQN5MwUoCm2IA8P/iMZlwjUzs2nzbBJHY+DgV52
1ro9GZD8wWyUhgqCIVBlkxYSpaFasDIqZcoUqNQJNOvDg4cA60pbRz550PvEbC/9
HbHDNCs5xandT1xBlj+44QlH5o3bplaQXR/tFF9dE2t/I4tLAokX7UDupronKNs4
Om9TqhKCz4/3q4TiLMEdsC361tLgtZ5so8qpGkuSIvBT+/C/XugfOKvHnxObO19o
vMYudntXXlYkwbKbmooYCE/I6G4zXxQJ4oSQdBhXENyOw9P9awzhlJeTZCfatUM1
iuG66kXPBIEMZBIbj6YG7E8oebtY0k4MyzPoqu0xglt7BHRoSDfzk6pw3CDJ7UxL
pkg/ppVGUH5opBP8wm9vPVNdg014cZllcGb/HxN06AN1LFCiBNNgzNhs3rqv2uDC
ITWVfcKcWyVJOZSfjxhalr+cixKaJKpUhbQ+H0geSrlVUZ7m6y4DNT/3lHi4KGBR
TShjyMBq9CcH1ipiGRkCtNpBsByieeOX2ltmn/IDjeLV8qFnye8jAx6mo/+JAYYU
wxwiKB0sSlkLujob8izLyQmD3OPDQhPMEhqiz7bgeCnFdtDHrQmyzm4XtzuxzuZL
2HyF8bCrjiyTxcZ5BXnlddAmh0wFvYT/cXL6/xxshY8aq/DqEUY3l8bHqU2sGoqM
CulCge3oeakZPZ4BoOOQ
=/wgY
-----END PGP SIGNATURE-----

--3loezlmesXOUD0D5--
