From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: pinctrl: fix indentation for better readability
Date: Sun, 24 Apr 2016 23:12:52 +0200
Message-ID: <20160424211252.GE4317@katana>
References: <1461332647-11227-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40979 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbcDXVM4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 24 Apr 2016 17:12:56 -0400
Content-Disposition: inline
In-Reply-To: <1461332647-11227-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 03:44:07PM +0200, Wolfram Sang wrote:
> smatch rightfully says:
>=20
> drivers/i2c/muxes/i2c-mux-pinctrl.c:175 i2c_mux_pinctrl_probe() warn: inc=
onsistent indenting
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHTbTAAoJEBQN5MwUoCm2DZUP/0PzaAa/n+IHnLzkQNG1PZup
EMgZY08od9uAy9rFaOFsBhq8GQ5RJcKuuGkDmdRjWdUXaUfUn+BX3VRLslXqKMbh
MuWgColzOaY3J8a8aMFCzx+hgekH/Z8XMBxdne1ZdIPtXvD8HsxQrE+mStdlzIgm
9jkxPrlCtMXg1tzBcNahrAmip6G9U6kfXshHKZA8QIsT0uHej8eOmbrpi6wZWuWk
rvG4Y9s/EViI8fhjtLcbb5LTpbXnH8v383G+LhLZIqLYveMQBSKYRCnvJ2JKAzgM
9wh08o52Z+IRr1Ll56Fz97bKaPdjWDo+pUpGSAlKJmhHsmw/3zzNzuwlv6YK0RCO
vKmkbaj5o+kIpNC6+K77o773qxRgs13QmIZaLOSMmtzpYhkONgi6TXbUq+86BAf/
CKUFXxmo49Ruj/1X0j3XPL1xATSI1iff5ILx9AwKX2jqaKOLTClGyWyPA0CVs5k7
nbSDhDrelhY5C+y4xS5vx14xjwrOnHCoMnjnf3zD/JwoomiVfZW/dYaDzlHnt9JC
xTm9uyUz9k0A/F96GP+2FtKtpj8P1PpBYzmPun05Yl7qmBtN3T3YJTyiikDSbuVf
wNmcxOTSAOZ8F3cD/NKLZHkCzdU9GPJ08rmTD7z4HEKdPZOPAdG+u4F/JjXjYg8x
e4KHbQriEV+HBj11BFM2
=6x1N
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
