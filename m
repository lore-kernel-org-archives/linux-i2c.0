From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nvidia-gpu: mark resume function as __maybe_unused
Date: Tue, 11 Dec 2018 21:40:16 +0100
Message-ID: <20181211204016.yrtpw4oodeets64e@ninjato>
References: <20181210205356.2846843-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7plmlgd746tbu72r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210205356.2846843-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ajay Gupta <ajayg@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7plmlgd746tbu72r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:53:45PM +0100, Arnd Bergmann wrote:
> When CONFIG_PM is disabled, this is needed to avoid a harmless
> unused-function warning:
>=20
> drivers/i2c/busses/i2c-nvidia-gpu.c:345:12: error: 'gpu_i2c_resume' defin=
ed but not used [-Werror=3Dunused-function]
>=20
> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-current, thanks!


--7plmlgd746tbu72r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQILAACgkQFA3kzBSg
KbZC3Q/+NqUuLEXbDtQQwaAfqsEIqzJvjH4HXSuKXfgV8jfdvDNLDZ4zQwygKzD/
Z+oBuVIUdC2abTJMGPDFixz2j8MjsWuDo7uEEfPrsgG5fLC0yN6ffMIboxYO0MdC
qL7Kka/uELRe+//MNQuVipn5/Ytg+6lLQgxljBD7n4mCm/5rzEpTCG3yLzRZi6ak
q50WwfKAHOQ3TNy+UNHtTreM3RWhYpc7Y3ahZr8UhQTATcfCspLFGwf4GOxuNIo5
UZwR53DGx+UwwP0r3plUA4b56QmvZY5U7j1BcOkmpotaANGbMufhvNzOkACf+Xs5
Z8nOa/XfTRy2oecC/J7dkGtexnbZwoDiKM/JQigdoUdlwYjW4MMllbzYGoHOiHeJ
iTf5K9FF2+tCtxxpA6/Pf/1pFw/6OSyoSPXQRcq6qyXL2Ea/xBAUni7FPk7WfYKo
1FQyBP0iM3uxGvkBJZxJhg4mnwKcbb3nqzKuHHt2pcQZIZ0liR0J0/rpiFRYjsdo
xkwqnxQha9g26izGokmFAQaHIGsP8Ymms2Z7pzZoi6yspov+gHTgXp3/SriRgXOF
mHTBziwPl5h8+3i6hkO9WcRBHWZf+N+6gLtWFCFOCimu/Ps5f5U2E+tRoKby48zC
RDw1fGPxAhrE58aL/TU99Cxc5weNn16sKFylDtov+sZhg9X/YZE=
=j1hl
-----END PGP SIGNATURE-----

--7plmlgd746tbu72r--
