From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] eeprom: at24: check if the chip is functional in
 probe()
Date: Mon, 15 Aug 2016 00:19:33 +0200
Message-ID: <20160814221933.GC10501@katana>
References: <1471001577-9269-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40092 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcHNWTg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 14 Aug 2016 18:19:36 -0400
Content-Disposition: inline
In-Reply-To: <1471001577-9269-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 01:32:57PM +0200, Bartosz Golaszewski wrote:
> The at24 driver doesn't check if the chip is functional in its probe
> function. This leads to instantiating devices that are not physically
> present. For example the cape EEPROMs for BeagleBone Black are defined
> in the device tree at four addresses on i2c2, but normally only one of
> them is present.
>=20
> If the userspace doesn't know the location in advance, it will need to
> check if reading the nvmem attributes fails to determine which EEPROM
> is actually there.
>=20
> Try to read a single byte in probe() and bail-out with -ENODEV if the
> read fails.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to for-next, thanks!


--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsO50AAoJEBQN5MwUoCm2lFQQAKybiLlBYJAMBav9xBnKGzdw
Eyy+UONfmV+hI9/Srzc1/ZUpfwjSLTEafpdMC5O7XT97BbKUHDPDnOrgcTYAh11g
n8QPjwLdzNJNyDtIuUyUMmCildnVeeDct6JozUVXJP72GQWHrxWC/CMUQF/u6q6t
P2Wfu0bRz0LWunoE7irf86lT8YT0V06hAzNPVKlKlCTeFvVK+B/EU/g2sgw+baSv
l6Ke4cQ7d/djkvajDk1jCsUoRxYi61ZeoeCpDsLq8minJT21c/eCKyQWiODj8VkH
8kU0kh6fnEpQP6me5rOwtCNiG3LnaNmI2SydQ1++ON7RZx4jLNN1Zbu7Z1IDZZCU
706uj9Wma4dUEKUFZo934uimG2FP3ttbNhY1PwTXPcLNsa33ewiR5YpLW8E+KZkd
2fxmZvc1VbnwxVUZdi0+iblGcUxPwlygrGRuemzgI4ZsQLIHkMlujO/9RpU4evWq
a3n567G7obBz1MwU2y6TP753/3FCFBctAcFel5LYXZUBg+Z9XTX+KObv+yitYS/S
JoboGzoMAWPi2kg5R3ScSllMbLwIsN5yXd6BvyzL7TkLalmvKCsAS4XxZx7ZESwM
7fIK/noFoDwBUvCStDzvibk0GEJtWL0pRVR4sCQhyrvNcybUcVj/7glSzE/yc/JI
i8YPYCKZSTgUvNNwCWYv
=7F2p
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
