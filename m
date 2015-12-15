From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: xlr: add interrupt support for Sigma Designs
 chips
Date: Tue, 15 Dec 2015 13:23:27 +0100
Message-ID: <20151215122327.GC1521@katana>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
 <1446429818-24155-3-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38026 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbbLOMXa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Dec 2015 07:23:30 -0500
Content-Disposition: inline
In-Reply-To: <1446429818-24155-3-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 02:03:38AM +0000, Mans Rullgard wrote:
> The Sigma Designs variant of this controller has the ability to generate
> interrupts.  This is controlled using two additional registers, oddly
> enough overlapping with the defined but unused HDSTATIM.
>=20
> This patch adds support for using this feature instead of busy-looping
> if an IRQ is specified.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Looks good but needs to be resend with the updated patch 2/3.

Thanks,

   Wolfram


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcAY/AAoJEBQN5MwUoCm24OgP/RHvSzrlYWqD9HQbEjnjuc86
ppZiYKBSePFx+ayOT0LoIsL2IO+HfkGg2X7Oh2UoygQbJeDTUsjKex/WUw2L/Goc
zxCRfhitrwR9jjQ0tqpNUq2woqvCM3bZFNq02InOxmOHxO1b8Fnziyr4p/l8xwUy
UR8F5DHrFtOMG4ZYkgKPDXwVviIB4HNfZPW5N482pnbImTueIu+LHqJuBA+tDv0z
Wyngvf9hQVXkpP8FjzMqmWBA43bf4HrWB/L50YZA2MZhCT5LjM2YIR7WuC5nBWej
uqmL27S3Ws0fn1yOy4UtohDkHYDMqccyRvU0+nj/MSEZZybOI8aE8FDeppv7HR7b
cDHr7QCyMsDxWZNRZXSd9HwA+kJ6taloNHIPS6KQyFnTBLzeTBvuZYwux8IqFczX
+lhF9OsnzrsAY+8Jh3uVcmFA6KYx+B71Qh/sW5dvtFvjeMzd1P9gPkREmnfmbzyS
TK75/RJP9jAsc0FtB/EYNJ5NumaTIh0diqWF0aBVyjO1P1/uAqRQI6WeMf7dx7gm
SJ/lZYe8fj9CboRZE41xjuVSMV+KDXG1yV5auLI8deivkvPZBriIi6FbdmqHmCvn
KGwdwY7DQgy+6xqvYk6zE+RLsmFtv2qIj0QIkbFlIA6M3ln9a1KZpEN5uXISmpCO
KPkRYIqDwr0MbEM3ib2L
=h8qa
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
