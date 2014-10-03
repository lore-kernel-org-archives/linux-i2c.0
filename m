From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: axxia: Add I2C driver for AXM55xx
Date: Fri, 3 Oct 2014 13:50:48 +0200
Message-ID: <20141003115048.GD1349@katana>
References: <1412334482-20720-1-git-send-email-anders.berg@avagotech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412334482-20720-1-git-send-email-anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2014 at 01:08:02PM +0200, Anders Berg wrote:
> Add I2C bus driver for the controller found in the LSI Axxia family SoCs.=
 The
> driver implements 10-bit addressing and SMBus transfer modes via emulation
> (including SMBus block data read).
>=20
> Signed-off-by: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>

Applied to for-next, thanks!


--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULo2YAAoJEBQN5MwUoCm2Y1kP/RfjWt5XHUteCijbnSjB1p3O
j6KUATQY06csp+zjHyu82TzE2hieP4Wsgc6ELJcJgZa8DPd8mDScbJAS5tyelCa2
oAhmRcQZURiMzGXx+nvDGfjmqE9Pd42vUReMQkoBSHTB1YQyZHzLm+pOZZ5a+aUX
aYq3Eag71YXMx2+T1jVGkDBBdvSkWt0EQJiJw6R0p+SQwcu5BKmU1Vlmm6nkHW8j
TdUpZd1zSb2FGvS3N/s1s58SFCnxCafcvU793tU0osyGZUUzCpRxAIEBMWC9c6qN
HyIrw0bYeL0YmCoA830wlmAiZnPRgi9/ebMdCEVq1AAW7wOL7L0P/KeOju+fRxch
ZVx4qq81KCaZJ62O1MDehMbKPQ5J2Z02RxyU5GbNpC4f1H9dZaUQMwGVZOByr1Oa
dsbfsqATXG5TrJxwzSmhBZYLKHmhNg6BX8i6Uoubb3WiaFHf5eor1Suvd3imTmiW
SVrasCiZfaVXz/pxK4BmotdLRY2rz5ifPgQ7QdaSsUsni92AGAr/0oiL8DA7M1Fc
ctez0VQT6ysPxC1mAMlvcJFzyjR2fXOtkINh/TTQLGWb9R5VnGGVLDltknZFLDHa
GLW1SyxtYSJgH7YzmqAec7hO9QcMagBcWIDkJTLKyTOPIs/IPeZwKhobFUcMwVfr
zKRFAYb+7Omgxe2ZTWCM
=MJII
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
