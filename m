From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c-cht-wc: Add locking to interrupt / smbus_xfer
 functions
Date: Thu, 17 Aug 2017 18:16:10 +0200
Message-ID: <20170817161610.pnh4spbgab62ei2y@ninjato>
References: <20170814201726.21045-1-hdegoede@redhat.com>
 <20170814201726.21045-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7j6tnzsxive3jzz4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60351 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbdHQQQM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 12:16:12 -0400
Content-Disposition: inline
In-Reply-To: <20170814201726.21045-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--7j6tnzsxive3jzz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:17:24PM +0200, Hans de Goede wrote:
> Although unlikely without locking the smbux_xfer function may miss
> the nack flag and further fixes in this patch-set add some more
> complex constructions which need protection.

Could be reworded, but after reading it 3 times, I got it.

>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks! Please don't forget the "i2c: " prefix in the
subject.


--7j6tnzsxive3jzz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVwUYACgkQFA3kzBSg
KbaLgxAAiYlv8C789MncZUdBgK/7wHEDL1AGsq9fgYHp6fmq5ynR88uyk3wb8pHj
pViqJAHJVgq5WJF6beLEBB96ea2IChoYUjnGnK/dN1EJRuH49RHQIv/XI157orfz
KSF2pkLhDU62mY2UG+75YdlQwybF3z7gpZkLKCVK4KZXrNX/Km7PLC0CM8iXue9E
Q48R56LTyUO1dS08QMwsXx7b06uHRWtRvdke7LVNWO57BOPaDT7L3Ri2/TeD6WqQ
NThOnPlPAZZFWGHQzK8hvwWj+3atcL3N2LNCBwxFF/xKyG04PRvaHCpqbaarvEXF
HD0eF8UpVKt1maLvLn2fX0vQt+L2l4SPEh6nMDmO5NF8GKXxO2Pox7jAKg9yo/Oh
H5N/sNw3olZxuQmLIwTNJZfyj0ywb7jO3Ht9WY6lmMMc1Zvf+ZainZBSPMm9cum/
qZw4pTgQRcMISjhB6x3dbsDHzAIbBVW3zYQ4OmWK9nLDYOV2iue6j7Y4MxnUhwpI
ZR+6V64fRoBin2pXRWKptZpbydLxWND4sjLcvLlfNhnNQPkXZtvI49l4I6lSVNl1
JFW7C8qJI3SGUACb4ISWzazGt0sxBp6c3iUM5v+tEOij4mE2121aDX9uPdgxsZ4S
J8YkttVGNpZEbIWDrJdEgqmyKRly97jiX/00WASkLY65YbT7poA=
=ReHq
-----END PGP SIGNATURE-----

--7j6tnzsxive3jzz4--
