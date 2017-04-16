From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/4] i2c: core: Allow getting ACPI info by index
Date: Sun, 16 Apr 2017 22:08:18 +0200
Message-ID: <20170416200818.5j5uazjw6blkgx25@ninjato>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170404220335.9815-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5tq7fzgm5lrlrbff"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57732 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756634AbdDPUIU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 16 Apr 2017 16:08:20 -0400
Content-Disposition: inline
In-Reply-To: <20170404220335.9815-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org


--5tq7fzgm5lrlrbff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 12:03:32AM +0200, Hans de Goede wrote:
> Modify struct i2c_acpi_lookup and i2c_acpi_fill_info() to allow
> using them to get the info from a certain index in the ACPI-resource
> list rather then taking the first I2cSerialBus resource.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--5tq7fzgm5lrlrbff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzzzIACgkQFA3kzBSg
KbYYpQ/8CPtHZwgBZcNYV3HwoS0pcr3uMs8+celes2NalZ5NEkKmuRPgKM8trs1Y
epQtxu+fNZwgVYYGstpo+x5l0OL1aEZ8SBvKa5dc3mPbNXreuUobe3HZXtiAqLvT
biQreDj8EeKUj73MsiyOYGTIrgUwsaUU+YNkfyuqA49tUBMe+e5d1n3CM9q8NVoC
Aos3l/gk9dQyvP/fV5tCX/qUnPoWeGc0FHY2BZJkoFDJqccWEkdDQaGBMSS1U7Kj
h7U1xOyQIQRsG718IpJ2Aq8pUmrzDZh2tbIZMk+7UyifNmWcSKGqSj5y4Q01hibc
HTBFkKCLQ1jz6LEteZFQ2oXz7niU8zMlj2DwrCH2enqGHnZuv8/mZf9RtlbNRpHL
odZP2cnue1Hnj+226j2uai1y01cMP0NZQx9AtwgXNTiPvbrDl2LbxVmWgZan+tqi
9A95B4kSrBmOC9/9aBtb5qJABIgsC/PHuZUr08OR3m+O0LvZzxJsRgQR2jExNvRc
+H5YosQYOHOBGqQcxwUKfGYUF0EZQvUjSL0J3/a5X+b4zCYJZw0tn9jg1xGgJi6Q
6AR0JSGZ71T7OZvgJAI5CwzTaZXLQWwxzagfTvOCrUVMoCAncKrvXIXX4NzgMJmz
Gv+/givdmuYHIJm667FmXEwNI1rXtXg3HcbWfW4Fq42BWT0DSGg=
=Gbv1
-----END PGP SIGNATURE-----

--5tq7fzgm5lrlrbff--
