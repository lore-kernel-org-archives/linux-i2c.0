From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] i2c: remove duplicated include from i2c-digicolor.c
Date: Thu, 16 Apr 2015 15:21:14 +0200
Message-ID: <20150416132114.GA913@katana>
References: <1429189812-24079-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429189812-24079-1-git-send-email-weiyj_lk-9Onoh4P/yGk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 09:10:12PM +0800, weiyj_lk-9Onoh4P/yGk@public.gmane.org wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Remove duplicated include.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Yes, but please sort the includes to prevent this from happening again
in the future.


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL7dKAAoJEBQN5MwUoCm2icYP/3suit/xXXYXotcHpAevicKa
+nZESnyt6i3j2AY3M9GobUJqe6KHXJlyulbuHbhiSE8wcfu5SdA2pyYBz+yJSTCD
T9YJ/z67aVmtRl2tTt1SF3IOjR1WODkJozBaOAU5H8J20z3ylIRcjeyouM2lqwUf
oFHyn8kfHPqBcwhKm5Q58UUNNzCjwyZX05n9fVLXGXn8kTZtJrSvNUdKrbj94j3P
b/J30nwfgEhsTPVxrWngWsmpbhz2ntnMbVCuIn/8MC44jHxvZbxVp05FFAkCl9kT
iPl2ab1izLyICJdbMtPaoJgI8dx/IxwoV8z7wKX31apmzsCIJGq6BLP3VYl7bbPu
5b7apiALeNCIM+V9jKtYIQQWLYWBK1JMC/QAH/lXFa9gELj97nBt23xWiLlc4wvz
J8HCstZz/DjrGHhv2/1ii2dSepIweqO+tCejMxKLGpu1MW0ac/SFpwRwYfejF7Y5
4fiSmf0TtHL6vkF9w901jLSbN8nx/LG0DJvYqjCge5L9Umj5cw4bgKDVaYYxxCww
av4yFHyGtkS/h3mjI8o7qAV3pX6jdpp2Ix0tn+vCQsSOPSY6kyeLJgSH4Z2+E+83
7eraPiQVnImTixOESPuGEVydPBPJi7bhXVS61q1eirke7zFO8tlQKkTqf4f3gpQo
E7SUG4Tn2P5EHVC4tFDH
=nTFT
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
