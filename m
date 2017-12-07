From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-cht-wc: constify platform_device_id
Date: Thu, 7 Dec 2017 12:01:04 +0100
Message-ID: <20171207110104.jd6rrp4pr7b6ui57@ninjato>
References: <bbbfa0879a3b9b778b11879fb6eb8150f4cb6838.1511864617.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmqsssafxmy2lkqu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55684 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdLGLBG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 06:01:06 -0500
Content-Disposition: inline
In-Reply-To: <bbbfa0879a3b9b778b11879fb6eb8150f4cb6838.1511864617.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--xmqsssafxmy2lkqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 03:55:07PM +0530, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-current, thanks!


--xmqsssafxmy2lkqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopH3AACgkQFA3kzBSg
KbY8ixAAg9lc38hFuOz9hhTGYD3wBC/6Z38cx5mzzaBHz8tCRoYfLeFIoHIOQ9Bn
MMtMm2NkfgEobWhOFTvkn6JbmmdlFHoPjysyQZLJBHRUiilsyPRJJrfFBjsn+Ash
b70GhRXeudM0I9VrsCBfO8gBTT3OGzMXPxdFBt3q1DwRp61IARXiKTFU+KJLhm+8
2Nn42o+530+WpqnhZisrsoESFggNflBFAPfVAj0EiOzuoASrrXZDg57pqlHT70Yq
AcS6c1eafp2jIzcgQpHa/6ntWGSqNDNUwW95oGFws/m3Tvbp6c73tS9oDwMfseew
nkKipPvxDTJ7TZCIdV2M6FRls8zxGC9bgUy88SE94ji//CB2n02ZHaw2QmrMuTVV
Cypg/+sm4aCU/01vUyM0sMlf8MHjp/QomWaBd7SIO26LNtmlBlWYsLYJ6ed+1xLN
DeB4g5qjPWsBAHbaxMNDKvV9gK9aLGmRrv5tmwB3wILa/F4HjbZ5EGh1rLVHBFjZ
yayAqza3zYq1cRNrPjVclN/hpHQ9lrcnaWtjwypm8DcHO5r9u1hEOvxVu4XZjq2b
W1beBD5RADpb7FaqEC9QyGYzvT8oKCQGe/SLmnEkL+oraKLzl5DNvBlGsTew1E8u
mL71bWmYpveHm5mfZY6J7za8rUzjxxOAhWw/lEP0KVgRISiR0U4=
=pGWU
-----END PGP SIGNATURE-----

--xmqsssafxmy2lkqu--
