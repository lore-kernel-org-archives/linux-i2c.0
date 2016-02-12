From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: remove redundant lock
Date: Fri, 12 Feb 2016 19:52:24 +0100
Message-ID: <20160212185224.GG1520@katana>
References: <f7d81178a0e65a19872a9e5207ccd8553e15c07d.1452604595.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:58870 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbcBLSwd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 13:52:33 -0500
Content-Disposition: inline
In-Reply-To: <f7d81178a0e65a19872a9e5207ccd8553e15c07d.1452604595.git.baruch@tkos.co.il>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rongrong Zou <zourongrong@gmail.com>


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2016 at 03:16:35PM +0200, Baruch Siach wrote:
> The per adapter bus_lock already projects from concurrent calls to the
> master_xfer callback. No need to add a driver internal lock.
>=20
> Also, rephrase a comment to drop mention of this lock.
>=20
> Reported-by: Rongrong Zou <zourongrong@gmail.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied to for-next, thanks!


--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvinoAAoJEBQN5MwUoCm2ppAQAJFLrbeHIjNkJ3Q1bpxh1nuh
Xfu1ux8pourqgeYfJ4AelToUOCXn/MNCzipdF+Knxg1xJpALmqJxap/726w/KVu4
fzLHXf9obDOx1TsHBASxlw36EeZrt2t1v64EkQGu+9jkhUnFA7mWNY7utXt2FzUA
1qql8xob087p4lDghFkaFHQ1WNVH2335uY5goCXNROhBMF7hYRHTVFw3XjGEB1Qy
IpsH3B0GE7QwoyLzOq+haO258owdHbuOudR1HzB19d9o+JUY8N78w8P8ROVqKbnX
8oAvQtW7mK5OfU+O9+fE6u99sl4FRrIuOFpO3YX2NqBYkLxKi6ubOgFqG8WeD3jS
Kek2S3gjr32rP0kypZsS5f0cWXlfsQ1AUPacXzjKIpOtSQm0A1Bt70HGStDSiz0P
gryTMo+yekWan+ReC+zFUjGhWZb/VLxi3CgFABGG54l7Ao6F/jOs+9EONRwSQVxk
wFI0jgS6TXVtENtUsXKV0w8Q/G0kIpFh3VWBvFTFippIwezRqHtwExTzA8T60mu3
chgXchCctnpx+U/SNPSQ7CV2jIiFdyIeC6IYqcJmXJH/BzTw3AiLIJEDopNOwByE
XuYRYqXPQwEVH29EQgNOTe18oJFK6qqVB8avrqbho5M0gqXmCAFpOX1w6VVEogiV
0BqcUnPP67QMTL8V9fh+
=NcBB
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
