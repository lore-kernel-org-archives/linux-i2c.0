From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix port number check on release
Date: Tue, 12 Dec 2017 23:28:14 +0100
Message-ID: <20171212222814.o2oqmsbiih2i6oqd@ninjato>
References: <20171207122545.1b8e17c6@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="add6fezzlvdhltwo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46027 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbdLLW2Q (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 17:28:16 -0500
Content-Disposition: inline
In-Reply-To: <20171207122545.1b8e17c6@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>


--add6fezzlvdhltwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 12:25:45PM +0100, Jean Delvare wrote:
> The port number shift is still hard-coded to 1 while it now depends
> on the hardware.
>=20
> Thankfully 0 is always 0 no matter how you shift it, so this was a
> bug without consequences.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 0fe16195f891 ("i2c: piix4: Fix SMBus port selection for AMD Family=
 17h chips")
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wolfram Sang <wsa@the-dreams.de>

I still think it is weird, but applied to for-current nonetheless,
thanks!


--add6fezzlvdhltwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlowV/4ACgkQFA3kzBSg
Kbaphg//fJmrasL++FhWPq+FRQ/4j0F7BtPqpU3CWu6NRIMDGrgwxBi4TZw1eovO
n0Y8XQ4sWQB+vfXi6sy56XtqkFAkB6UI7VzDO6mVPBvkCSacHJsvjCiA7SSofw0K
X5+1m8dYfpAEpsJ1PYtzd0UWVwDtGXSyDC/26vWzxS0taXeLHcKWe5xDra1HrdCr
xWxmPUWAW2UeJZhH1WznGESH93/HK90vhuURLf1KBv+SaLbhW7zHd0CVus5GnzTv
nTgBFwY0PXtUqstyI8AxQn3Ua+NxU0imo3w3VArZt9yzPEIqS5oamuDfOReYe6jh
d98NYpkhbS24XBkqHmMQXT3TMKKgTCIcQqxvGX+zF8TP5GGEW3IaBuWKQud/bHnA
noCmO4Jx2gwQ6UCo4XRHlWQ3T59inNLe0C4yAyL2DkNQYh+0h9ceGvY2ZFvEE5bO
WRFFpnVcelZYLKiZw+qmikzgeGto8WVB1bpyr7/AOH95hynaWoBdyy0/qUIna7pj
QedhsVi+7GePKXNClZB8N08quOd+/pzVLAntKV6DjgtqWo3NbHAVKQDOnon67CyU
5/ISDhFNNANwSP0z6GMuCYXSvYoJJTnopjmU9535dHCSXYh34mvumdHuh9NHYfSi
4y9JqQgX/MmiR8Wpn3wQLirpj8KFRXf0cLf6RnwyKP34TtOn3YE=
=YJqA
-----END PGP SIGNATURE-----

--add6fezzlvdhltwo--
