From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: designware-baytrail: Fix the Kconfig dependency
 fix
Date: Thu, 25 Aug 2016 22:24:25 +0200
Message-ID: <20160825202425.GH1614@katana>
References: <20160722102403.5c2d3c7e@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47095 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbcHYUY3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 16:24:29 -0400
Content-Disposition: inline
In-Reply-To: <20160722102403.5c2d3c7e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2016 at 10:24:03AM +0200, Jean Delvare wrote:
> Commit b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for
> proper Kconfig dependencies") claims that the "Baytrail driver" isn't
> tristate. But in fact there is no such thing as a "Baytrail driver",
> i2c-designware-baytrail is not a stand-alone driver but an optional
> addition to the i2c-designware-platform driver, and that driver *is*
> tristate. So there is no reason why I2C_DESIGNWARE_BAYTRAIL couldn't
> be enabled when IOSF_MBI=3Dm, as long as I2C_DESIGNWARE_PLATFORM=3Dm too.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for proper =
Kconfig dependencies")
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

I applied a patch from Jarkko on 19.6.2016 which also changed the
dependencies. Not sure if it is equal to your change, but this patch
doesn't apply anymore.


--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXv1P5AAoJEBQN5MwUoCm2UgwQAK86e9INFr7NxSeoyqajPx+/
uwhI1nGE60bdFSHbVcUId3F+kyoXry652yko+hOY7W2k7cNnA+HYiTOHrzmkrq9R
MyTCnL20y0I08JYX8pq2imrvqsqjcOmrwR3WB9RGbw0sFLytOXyDE1FOX7CtG//c
NIavz6lZHEZ1gOgQr1dhLWGAS978wGvBMfiShWfX2JFtFtD5pTXvPuj/v54xKVpw
AsE2oip4v04Pfya8iax70QlVxSUhYNDKCzVCUux7UHiYd9Wgkq1pPMHCwte236KG
4vMhOHUXbHm+FZVvaAC7FcUO/pU8O4MxO4PVPDRdkhxb4n9lr+mOx8GErmeUzNFV
2idzkG9G5fInWW7TL0RxNEDR/fMbtbY4y7lzpnvpwFUqBzocqD2nQVIbNxR78AU4
NJDgznIr2iCktgHhJp4iE6VHcoRq1w6xgiyZFr3SmDZ1bC4p3WaWsarq8sZwkPXw
iILSOIHWQ8ZA6i5ihks+oFBEs83+Igxb9mZVU692+5lW5ojz0WWaEcow86Ax89gQ
1LjSb4rgRIU7dI1ImDFZ8w/m0KmJuN6AqBmgbTI7f11U3rhtWRm07zLSCdJJ9/dw
SJCrRDuO62YUPjmQeqXiHWXsiSboPSkUFVxGvx1omW5XZmsoMP/k3gT0vOfs6QNA
yAVFWFz0a/GRY8Nbjf5f
=s58A
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
