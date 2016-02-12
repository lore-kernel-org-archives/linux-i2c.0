From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware-platform: Drop duplicate module
 information
Date: Fri, 12 Feb 2016 19:58:46 +0100
Message-ID: <20160212185846.GI1520@katana>
References: <20160202143138.60adac87@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:58928 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbcBLS6u (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 13:58:50 -0500
Content-Disposition: inline
In-Reply-To: <20160202143138.60adac87@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 02:31:38PM +0100, Jean Delvare wrote:
> The i2c-designware-platform module has duplicate module information
> when CONFIG_I2C_DESIGNWARE_BAYTRAIL is set. It gets the information
> from both i2c-designware-platdrv and i2c-designware-baytrail. The
> latter is optional extra code which ends up in the same module so it
> should not export module information.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvitmAAoJEBQN5MwUoCm2D0YQAJUiW8SS/Ni+k2sZ7rR31U2J
k5J0HKpzGsKvwAJ5qgj1f5bMd+s1m97+RAwR4z5KppN3vRBxDxKECdb/DTx6oZ+z
siq9Wo/7IyFAxSjTW+//R45CG4ihIYsGZeIzVXj6lBYaZEdRmr/QcT5XHz+9guRx
cFkgZBKwfGaUJww5cX+lo8inIZJ/jJ+3Nqc7ZsanhonvF1Ux7kNkyLYNv+ZhGQ+H
GcTWdu69SSIfUyzJXlf4e0GcgB0ATO+xS26Dyp8W4A7+Mx9bZm+hWeqjTYagfUN5
1QxAjN/KDSCaXNjZ/mlZR1RwO0u37DtnUFQeb4Jw7GdcXe+CyaPfn7XYD0je37Kw
O40txpvFq4DDXlhEOx/YyU00bwfCV2kQtFK2d4d0sXu/ABBqQN1J5nXcQqI2LKJH
VRkDwR+Km5sls343U+M+HfXPNy1b9b8dJVKQ73ZmYR/K8EuByfwWWo4dX0eXFF0s
yPtVuPmmlTn48ZLdtiAGyGmAo/1nLgeFrarUsrdkeyC1GRxWPoybYH89p+ecvQAq
ukakJudYcYmhoI9M4fl2q2oPXU9ov5I8apfCCqAiYlHoNWLFCQJ4dwOdROQqbOqS
yhFruCYkAOkju/PJeFpGG4tRKP6RgV9gh6bHjR+H6FqmlqL4Cl6Fm/is7Me7Ux33
nylmPKT+cy71/Za+rJh8
=82WR
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
