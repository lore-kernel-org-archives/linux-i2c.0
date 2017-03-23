From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xlp9xx: update for ARCH_THUNDER2
Date: Thu, 23 Mar 2017 21:44:50 +0100
Message-ID: <20170323204450.yx5moouklzzvw7z7@ninjato>
References: <1489316095-5244-1-git-send-email-jnair@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emyryb5rlbib3lg5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41027 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbdCWUpY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:45:24 -0400
Content-Disposition: inline
In-Reply-To: <1489316095-5244-1-git-send-email-jnair@caviumnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: linux-i2c@vger.kernel.org


--emyryb5rlbib3lg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

oN sUN, mar 12, 2017 at 10:54:55AM +0000, Jayachandran C wrote:
> ARCH_VULCAN arm64 platform (for Broadcom Vulcan ARM64 processors) has
> been discontinued. Cavium's ThunderX2 CN99XX (ARCH_THUNDER2) will be
> the next revision of the platform.
>=20
> Update compile dependencies and ACPI ID to reflect this change. There
> is not need to retain ARCH_VULCAN since the Vulcan processor was never
> in production and the config option will be removed soon.
>=20
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>

Applied to for-next, thanks!


--emyryb5rlbib3lg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUM8IACgkQFA3kzBSg
Kbbbmw/8ClIFZHa+uJCa9w1JdDXDWTbQMCK8gaQTgM+7zZ+h9AEVEkRAqTE2xQf6
z13+O9ei5vCSe6j1FuAGvrTKyYJLtGZvCQjRKPMUHAWsWYQo4Jsm2MymR6jtQTLn
0cyKkYpnBgR8tzigbJXqbnqF7/Yks4djwyTxMHW7Dhav6ODk41yquK8MgyFaU6YY
CrBuxaMMkcybNZIeXQ+UNAxwVIw6kPcMJTewLGHUlkIvNJfRpJh8Wqg47uCxcdfj
xFOVIFFwHxZwHOZ3X8v2usPWb9Eksr1IAgT1H3laNE9ZjcJsmFCHlGxH6MRGaK6b
j6SA0Lx8gM1pY3oZrl8hripsPAjumXJDb3mpcvqfyTJJrEvhMzeMDWnmWqsu1snL
i1QrsgYOBMoLJZdrBT3vANydabEdTmaFXi8Is0/Izc5nZgJ8X/Nz5YbM3oNXKRfH
cnJyNjG6cl49yipcx/QKO3Rztpqph9B6sD5K/7pEM367eT/ZYdXdxWCK/fnqMKc6
HYk3vOMOtag4b8Nlu2ORDY5ffIebPmVlMTIwBh01Y7rAr1OjSzi0M0DIz/zptwYm
uC0VYqYouq6HijN1Sy2RAtI9VL3YVgdTGXkg5z9wBL1TGZBGbySI4LXkn9cjRCBN
78PXq2R9taLIiVCBW3w5OiB0dz9GgKrhFIOXOJ4MjeOe0CQ+cX4=
=kgk1
-----END PGP SIGNATURE-----

--emyryb5rlbib3lg5--
