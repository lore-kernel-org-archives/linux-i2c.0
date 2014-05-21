From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Wed, 21 May 2014 09:54:15 +0200
Message-ID: <20140521075415.GB2708@katana>
References: <1396270498-30703-1-git-send-email-maxime.ripard@free-electrons.com>
 <1396270498-30703-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396270498-30703-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 02:54:58PM +0200, Maxime Ripard wrote:
> Switch the device tree to the new compatibles introduced in the i2c drive=
rs
> to have a common pattern accross all Allwinner SoCs.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I usually don't take dts updates, but I guess it makes sense this time,
because we dropped the old binding?


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfFunAAoJEBQN5MwUoCm2yBYP+wa7Pq9cTCHf5rjmz82/tfyh
EGt6VycNCyL3/8idQ1Oa0HOaPDUwEpjEnZDq5fRiMcO4E8Yn4X/FKNhg29QMlixR
08hV0D4Fu6UPS92NMm/EsleVyIeQxZ4TFXspRSDMI45X33qZekGUpVHJrxX77SGe
rhQmvzkUxLQnxIxXrbRCpSyXkZSBBtjoxgg/lSAD+x4OcMjFGgvPDtOPli5JpgFn
0mUMZVj7c5Hz1tb4pf8QfB0jN2+xmVlmpBbi77SP/h2ltqRUX59laerZvq7gbIIv
W0YNb0kmYe6HgjTuj0RY3CDebBkPtmsNZngoOypSoUrfEiuFr8ffVco70U/AfQZd
dlm8mEiVtVzUXb+aZrI3FAk9+7S5r/BUG26F9VzoMc38YYnGrIL777iWD62fVuK1
48pAtLTXs/nmGo2hUmSWRtTuqZS8LK2Ejcr+Pn8/a/iiEC8M9rm8v/9gdKOZVfea
sSLZysdMW0++w8kEUV47Bl1wa5P4K+auJkvbfVddjKzK/cgPTn9cnIV5Hk+K9GaX
cr4rAo2l2VbKxOFZofh5eB4jh1bvRAQpttbVsKWICayeOtQ56f4vH2wsesFp/rEv
jWJAT1IHahPlPicV4atBSaUT2R9erOfMSISfwH5z+C4AfUpaZ8SQbtlsJr/QT92+
IOkbEuYrafil+8U7irxO
=+bsG
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
