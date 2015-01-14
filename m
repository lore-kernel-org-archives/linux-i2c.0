From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: imx: remove unused return value assignments
Date: Wed, 14 Jan 2015 15:20:09 +0100
Message-ID: <20150114142009.GB1598@katana>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
 <1420555701-24645-2-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420555701-24645-2-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 03:48:20PM +0100, Philipp Zabel wrote:
> The ret variable is set and never used in the error path of i2c_imx_dma_r=
equest.
>=20
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-next, thanks!


--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtnsZAAoJEBQN5MwUoCm2TLkP/jJDuUNhTdLMXk5PTI4uJXn4
NB4zMive+H1wFkVBZaYlMufJEjQslrcubq5bbvpZ+pl0GgyYKIbLgxWZucvkD1WR
Zoe/t1LafJhPOisV15Ct9uQbRBiA0MP20DZFbl5T7xrxnIlrBkcMcAXlmm51HW5m
JK5fUNx/uesif49IaD+FqP4PkgFJ7bGhUOpKBJsfyGqgEs9AgEbY40Pv+f6s5TYO
WI7qMc3U5IBhVz+jxxR/ycPxDb1pSiuvNlC20A5Sz6A3ZYu0/JvlLfjb+EvI1Zaf
fiNWxJnp5FoFMu441x5UGN+cT8+WIEguH/rmd4h6NVdoc5kLy1IsvSbQToiVc9ks
cT91ViZ4tGF9x3DvrUfL38Q90T7uw7LcAExjnSfEu/ECqJgESWAkM+iZkC8N5e5w
N7sI3AWEZ6jCH39Jg7ktIfaC3HSL6+jfaFk8IPPlZ3vtA/G8q631KzbpJ6Gv5EBB
019n2w5SoVjQDY3fhQM1lWBsXKskK13xx7hBhPnXgFbpGjp7v3P1xOcKsMcsX0tp
H3tIDHPjFCwHszyRZq7orRqEVkDNMGcNlkWW/9Z6elgWKB95Hc61KOQw34Io6c7i
6tkL32KMKXgRX+6zJ3k+e/VE5MMsBRKWwb+sBsXWoSA89NXBWks9/+i2Eg+u17xG
scPXlUOz3kv0Z4ndD0uC
=cFFY
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
