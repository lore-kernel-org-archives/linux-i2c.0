From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: designware: reverts "i2c: designware: Add
 support for AMD I2C controller"
Date: Fri, 23 Oct 2015 10:58:59 +0200
Message-ID: <20151023085858.GB13380@katana>
References: <1445578127.2977.23.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34250 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbbJWI7H (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 04:59:07 -0400
Content-Disposition: inline
In-Reply-To: <1445578127.2977.23.camel@kxue-X58A-UD3R>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: mika.westerberg@linux.intel.com, baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 01:28:47PM +0800, Ken Xue wrote:
> The patch reverts commit a445900c9060 (i2c: designware: Add support for
> AMD I2C controller)
>=20
> Since kernel starts to support APD(drivers/acpi/acpi_apd.c), there is
> no need to get freq from id->driver_data for AMD0010. clkdev is supposed
> to be already registered in APD.
>=20
> So, revert old design and make AMD0010 looks like other ones.
>=20
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

Updated the commit msg a little and applied to for-next, thanks!


--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKfbSAAoJEBQN5MwUoCm2BwMP/iFmMzIhQm3KrqSc4SlEA7Az
+v6/2Dm3IXfeeU4SBLij44H5fVTktMxCzAY1kcj8seENLBwWI02EXV6RC7Psok1+
AJOYxy2vbOVrwnOfdmr6mOggdK5n1L3bJz+OjFzX0k8D1pcZ/fWHiJCuEot/OdMk
0pXmK76RgcHB52p745XKhzfjT1NDu6VOrGNQDFTL9MmL2hrjTGocsGpuhjn5ZTx3
wSOLAa26xgKno1nQB5xRy/zqsfX6cqvBLz4HFSXaW9TrYYtiPwVQjXd8Diang/xd
BmibKX8gPNLkCu+YeYS6qpS4gcNnctTUypRVTamKRJW3WbtOu0fGzCeqY6ES+pYI
EhUdAAzz7lfSdcwuC+XMHBM7N7htN5Whh0eYMexFapfCAYDr4joMdqpc//p2Fmfy
Q0w2GD7YPhD9ruSJtUdRTLN7CgYwYPYhpiSmAOckRXQXccMzpQDw94U+lx5/tvrn
O5FC6wtsDe24pCKVHbCGmyFuXgMw3y+caUGBnFQvw7JbO14Am2e2QRvtQNUQMImO
AuKFLwroN6AIH3krgh94pgA6kFSlSG6p/nifB4ZC4IQi5W7IbRGXHVRcM6XHJBPO
dqzO/V92odNnipsq5+XN/u7QQm4ndbETQ8uomZGG8T2S49p79bKhk3VyOqWxQmr0
xmBi15XZD49VZpeWt/vB
=ofoL
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
