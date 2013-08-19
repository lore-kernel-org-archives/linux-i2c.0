From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: sirfsoc: support reverse direction of address
Date: Mon, 19 Aug 2013 20:06:54 +0200
Message-ID: <20130819180654.GE8626@katana>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-5-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376385091-30597-5-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2013 at 05:11:30PM +0800, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>=20
> if users set I2C_M_REV_DIR_ADDR, revert the direction of address.
>=20
> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Hmm, you are not advertising I2C_FUNC_PROTOCOL_MANGLING so users should
not use it. Does the master allow to implement the rest of mangling,
too?


--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEl6+AAoJEBQN5MwUoCm2m6AP/2vpb+eYxSNH9wfiMjpGBybs
PF5Puin9bu4PdxIvT0da5KOwhaNRGbDluxo1mJWr037wfsmruMqoT//phhS1U5DJ
uvRt5FZ4sGN0DOyUZrm1VI060K7r15lIGy+UP/wnk9Foz+vZ8N+i44HF32isjaGm
SKD9+WcsJTdOA6weIMF9EkgxKSschbZ+nBIpOV4U76rXHvEULpoBMQCjq08LKAFW
mmMuVVu8grMoqb4CQ0nvfsrmM9XM13P1A4o4utMq2d3CEQfIOEjpdTVl9aHkEj93
0GqXv7G7qyB4hFAoLT0AKXd5bDRcDQpujDEFc3rO0lsUrWpMRlVQnVm9p1iPUq9O
/SeVEebAWhIjFKFtWP32uZlulkUeNR25rbXpSC4A4qodJ6n2nMk7OFzcofUtLMXa
oPomx3xAMUjaKqdHW4SWqqbf2SXcIrVX6y4RHzkZJ/QXTI0DN6hfMcOzDEDU/fB1
8u4BxQgC8JGdg4Q1t8qcu2wGRzCaqXAaJMd9ZH0rUQlHqj4wUS2BCd7pmNAQaTOn
Q57+vWe9uPBNOlpCO2SFyRr1pWK1RC/6yQ+OXm7w83qe3gpHTSsfBiYyKAOklRYf
o6hyadSjDUkGKw3IXPDuxJe2tnOPNnk1Ykr4Dr9KI/4hT/eT+bqGNvGy9YXM7OXR
vcwMmd5ZRYT6P/7cn/qj
=3fSG
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
