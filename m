From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3] i2c: Make of_device_id array const
Date: Mon, 2 Jun 2014 19:30:31 +0200
Message-ID: <20140602173031.GN2654@katana>
References: <000e01cf7009$5bfabf90$13f03eb0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000e01cf7009$5bfabf90$13f03eb0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, 'Maxime COQUELIN' <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2014 at 03:46:11PM +0900, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
> Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

Applied to for-next, thanks!


--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjLS3AAoJEBQN5MwUoCm2zrAP/0RiKTjj1IHEYDVScyc4jpUh
YbCwoB9vsA1O93eY7D2iAwbcxPwU7T47jTT5yM7U83elkyspzloNcyi4Z024uf7Y
YNQs8zFeVNed27EhH1ThFrT+lDE/OwbCUSoyZE1KVDfWd+CWA4bFeW8dxsUd+jjl
LljiqfRYXWGFSi/7lUe4oZu/x2oItdLycKD/R3oTPdjAMCTvGZwa2zaha2ZJOYW0
sffVxqa1nQW13BIRAZGtMI1M8HVoHoBNgLG5bPuUc4NI7SYHkfu/+NVgw5lfbYiI
cyFOhNSk/mizl1bRCQiHGITKWBuNhIRhtXCeHu9Om1tRfpEQnrlguxki+1NQkDLZ
TWGH5YF74cfXksdoztsGCam1ksNS2a9LSqs2+YZt2YH2T8Ba7owaphl1Q93zSwlw
aqZANA+cZz9Imv5SePwMSXmIrjXFhkvw+dD9iRXs5Jqa85LCCLhuN72b2S6MVR4N
M/1xrWYzb4h0ZcL1gWsAM19nDL68yXEF43IKlnDc1+XLSEi3i+y0fS87uvTSpRMa
YOZ2xBo3SMEDoJqaHAdmjx4KK7cViYpbi7a+UP67CTehfoQuF7zYrSXyJFMDLUqM
fYM0pLILDUa74mjhHnzOUBmqneWgyCouJ/pScFTBTb8AxwcjXMInqA3ct4HF/cV0
RGuQtCecm5GP25UWKtN1
=Fpft
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
