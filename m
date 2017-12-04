From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] R-Car D3 (r8a77995) I2C integration
Date: Mon, 4 Dec 2017 22:33:11 +0100
Message-ID: <20171204213311.j7fupxsgx2tq7yyl@ninjato>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d55vkvhgvgk7tted"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45879 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbdLDVdO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 16:33:14 -0500
Content-Disposition: inline
In-Reply-To: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, linux-i2c@vger.kernel.org


--d55vkvhgvgk7tted
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This adds I2C controllers to the D3 device tree and enables I2C busses 0
> and 1 on the Draak board. (I2C2 is not connected on that board.)
>=20
> Includes missing pins, DMA support and the Draak's serial EEPROM.

I agree to all of Geert's comments given.


--d55vkvhgvgk7tted
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolvxcACgkQFA3kzBSg
KbZjSw//aGujB7362e/+WVIDpfuISwbfCiOSsv/pEyH2FLZIwCoeRvID9Vsmfraj
TiBdgRPohIzcxd/2/vRl9I0a6azelfn+KzhODr1L+Hxrsm+6iNCjSosl9Qd3a9CM
1SzOmotN9Fs2mqkTVh/ZCCLC+9DlnRxH4NiRDTp+xzBbvOtAa1BZO969COCrcP9w
sdNklWuiEBPcjYdyKvd3ssqi4NDkXYdSMLfpU5oA3ZtaqXc49ymKcJplm6pcX3+o
l9h/n4bG1Gsa1M4K5tBUjPU5ZdnoF5x969fENeo+VgKAnvtOLBdztT4I0msfjHkO
7SRbfQN9CETAEW3Q0LXe6k48A6MfXsOBWIil/bSV52SK5BPVg8uLSlJ8Pv/QnLCZ
T8tLigOKWHtwX+CIwBIE8SKxFAnNd1/1MhoSM6YbZ5fywH8/1SX5hZlS1v54VxtD
dCBgwgduWIbmUask8fuWP87UJoGv2RqKTBbed1cMZJ5q9JMpTyKMcynGAU3EYiys
pwO2VB6kwipSkQkCmXILMQY+pZ4tNayrN4A8w9fn29CE0avrj4/Bxoy7eB162I0h
SQaU/+hMuFfw4zLF4MPD7HPFuZzkdXwVCmsahxlqX6jH4g8vL2OG8knctkSKsWrZ
kNG5E0gnBTu2ZbqQpa5n3nYw8cchvT+vcfAR3+irxAoKTNAk2rA=
=d2qh
-----END PGP SIGNATURE-----

--d55vkvhgvgk7tted--
