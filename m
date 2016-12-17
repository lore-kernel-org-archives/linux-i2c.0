From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V1] i2c: xgene: Fix missing code of DTB support
Date: Sat, 17 Dec 2016 19:36:21 +0100
Message-ID: <20161217183621.GD27020@katana>
References: <1481699846-10620-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53086 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbcLQSgY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Dec 2016 13:36:24 -0500
Content-Disposition: inline
In-Reply-To: <1481699846-10620-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Duc Dang <dhdang@apm.com>, Dien Tien Hoang Nguyen <dinguyen@apm.com>, patches@apm.com


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 02:17:26PM +0700, Tin Huynh wrote:
> In DTB case, i2c-core doesn't create slave device which is installed
> on i2c-xgene bus because of missing code in this driver.
> This patch fixes this issue.
>=20
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>

Applied to for-current, thanks!


--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVYWlAAoJEBQN5MwUoCm2JHEP/1NWmQa9JE2n5ERAc7fAHmx8
c20EmFfCM/HylmkwP5coNFwBPqgbaU13Rc5YPhG8UKAS2kz8B28vAu1ygooIwmlZ
PDJbqx8A6FTQKxbOhhPrb7Qy5K40LEmmAG+qmDT4Q2AhWJs6Yy3REzK/oc6/JJTd
1ZsBVTtt9OLbBWbniH+SiK0h4FJSEBnmTjjLgK4Wl/kCK2zoOX8Ftm5gue19Rtjq
PhgXobd6jPshEmTng0AHgi2C+SMv5Dw3AAWmwYzBIB4CoXBAZLOjp9bFRGgXytyu
KyUWpEaZSBgKXsL/es8kCAt8mvAQL/Rkoeqb8ZvFkpuJVvCT/b38oCjw2EtenDOP
6QCCXri7i0M0jOgAwXhaoxp6GyyzcGEAiaSnp5eggBZS29116nLLYE/2q/Lh7diN
vviUMVnJ7otE5GfcnFeCtIIEdLFHRqwK8o6tYpW9HsErkq1PVjzl/ztCmSZV5YFQ
nz3UhjvdSwmnaUHdlwDLT8IBhKFqlEq1vUs35jZ8TaYZky5YayzWe++DooBdSPCC
qnPK7TtuPp0WUjQe7WYEPrwEeTEP/JjK2UCVEJVC6TY8BPNwONbb8YzCVUv8HUF2
iXxA7k7iUPFuhaXraaVF4da09bllmEPe89Y90E/YI5AI7N3lxFCe+W96qr6Wvjck
Vatt5+BWTvInYFAzotuT
=A+zg
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
