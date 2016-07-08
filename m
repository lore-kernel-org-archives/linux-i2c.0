From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Fri, 8 Jul 2016 10:42:43 +0900
Message-ID: <20160708014242.GC10192@tetsubishi>
References: <20160618140420.GA1430@tetsubishi>
 <1466414778-22879-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33588 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbcGHBmw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 7 Jul 2016 21:42:52 -0400
Content-Disposition: inline
In-Reply-To: <1466414778-22879-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com, mika.westerberg@linux.intel.com


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 02:56:18PM +0530, Tanmay Jagdale wrote:
> Added ACPI support for the I2C controller present on Broadcom's
> Vulcan ARM64 processor. ACPI ID used by the controller is BRCM9007.
>=20
> Changed the xlp9xx_i2c_get_frequency() function to use
> device_property_read_u32() API so that the "clock-frequency" value
> can be read from _DSD in ACPI mode.
>=20
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Applied to for-next, thanks!


--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfwURAAoJEBQN5MwUoCm2A7QQAJ8TvxZv1pyas8ScY48Z8Zgw
lLbpFxpUilRXRubz9fD4xriu8mBG3SSO3IHM62r5f9GYNpfAGmsFRvUp53nXTjP8
1XEy+OmdA1kQ1Q9j3UEBKVhqRBLs5YcwpZOntZ//+vRr/pB1PkxcfTUC1GxKOPiv
ylFHUH6zm8XMhfgjHLV1y/MjrCY27znhGrf5YOk+j0HEKntw0v6Yirsqs2BqZagw
dzUN7xsbF2HeOY+evUnuu01AB+PxFzXptTc1Vu/jKGUqs5mvCwonL6u4Qoncme9Y
SuT40wWolda+WBAlYa8LgBqO2Vxvs9kqr1QDb05a9Wu+2mglXeGQ15kL/mXetbqb
Z1rDt5ai1AdJ7NwznpmoVbkLYvsvt9TuwQxcds/o3EeVoHzBDibZKQGrelB18p/S
tCk7mYRMKBJLyKcuF2RaGzmE8OLBGJinOvoEYAIeWLXW9arVqwcPoJ+zTBKmm4SX
tzupj08UG5IwSlER++Emfru8BKlzctU4Pv/Ey9I4zssaPUkEva1Bg4+I7xNEEhB3
oJMwLHndMNyHJvTflxgyVDAdIJ3PfgDK9KqkxXWA9B4nl2XeRAvnqQV5R8Le5WrH
3egTUk6JfJh/9+2Ok6MPruy6ECpXBkQDuPTuZBh3NWwYkGQ6LsI19yeEoVC6H/hA
5G29CXEBlt0x1DDzoS/I
=CPBy
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
