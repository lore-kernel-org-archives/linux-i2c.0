From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] watchdog: iTCO_wdt: Export vendorsupport
Date: Tue, 10 Mar 2020 10:30:32 +0100
Message-ID: <20200310093032.GC1987@ninjato>
References: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
 <20200226132122.62805-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200226132122.62805-2-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 04:21:20PM +0300, Mika Westerberg wrote:
> In preparation for making ->smi_res optional the iTCO_wdt driver needs
> to know whether vendorsupport is being set to non-zero. For this reason
> export the variable.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Sorry, I missed rc5 but it will be in rc6.

Applied to for-current, thanks!


--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5nXjgACgkQFA3kzBSg
KbYiEw/+PGGui8RQv9eIOA32r5X8+rxZpSUc1xxh2VBgtbARvZGtl/1KIPOBAZw3
kGwWQ6Uv9hEPcIQxidiFU4qHVwpYFd5ti5Wk9LWqWsxGvdlQ53G7l2clAmi8HFqG
zilX0o3rqPAsSNA7LsmczUP+cx3CH24zWXuv3ikqfvluYI9EU4sGIyRu7BhOGfxs
8Pw89RA3m65PNW/NljEFmjA9P5tsft+UYmfvqkw/nmdMkU2WmfXfCBdNcbXtzdTg
uH9zdMS5DgzOHt31g1J3KKjYrQ1HetHDUF2pxVMhg1TumWBMuGx3zeg2sMC8FwT2
VWcw3CejWOi6P+DiE3JiB6LGdgehGotsiU5Uwghw27A5p+kBOHVQ10W1f/JCL1WH
P9ur1tN4NPxh//KWu/KuDSoXLev7GMWp4b64VGocyoCjPQArk1IYNc9OawHrsjAJ
hBF/bYRzeErK91RahA6yeTXpb+P01X/cvcyUUjdENQZZsIRJ+4BaUxo781nw9hO5
B+e/hSyRE1e4lw1xhShuKvtbv6UGizWOrQ9y11YleW74+naIhiSjYAnyVWTSa6+z
dM4sqyxNDDROC83Wz6v29pDqwJjzu30jVXy91G9MSFDIcWfar76TwNpkt7VKxds8
uWFEMuOQYKEId3srlJ71ZTbuB25JTpCsu/F6dI7R1yKU7aVBBMs=
=OD0s
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
