From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses: i2c-pxa.c: Fix for possible null pointer
 dereferenc
Date: Thu, 3 Jul 2014 10:41:09 +0200
Message-ID: <20140703084108.GA3012@katana>
References: <1404084516-901-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1404084516-901-2-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <009301cf93f6$f938a270$eba9e750$%han@samsung.com>
 <CAFo99gY2qEEqwJgu-NQryAe2=o5AsDjL+SFaau6BA7CBMH8Xkg@mail.gmail.com>
 <003601cf9660$83368990$89a39cb0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003601cf9660$83368990$89a39cb0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Rickard Strandqvist' <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>, 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Leilei Shang' <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rickard, hi Jingoo,

> I also trust Wolfram. He is one of the most important and active
> person for Linux kernel.

Oh, thanks. I'm flattered :)

> Wolfram may mean devm_ioremap_resource(), not devm_ioremap().

Yes, you are right. Sorry for missing this detail when suggesting an
example to convert to devm_*. devm_ioremap_resource should be favoured
over devm_ioremap.

> 1. devm_ioremap_resource(): IS_ERR() can be used.
>=20
> 	dev->virtbase =3D devm_ioremap_resource(&adev->dev, res));
> 	if (IS_ERR(dev->virtbase)) {

This is correct and preferred.

BTW I don't care much about splitting up the patch as long as the commit
message says that the original bug is a motivation to swicth to devm_*.

Thanks Rickard for picking up the task, and thanks Jingoo for reviewing.

Kind regards,

   Wolfram


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtRckAAoJEBQN5MwUoCm2XjkQAK8POEB0KElgjpP8k9x0j09h
69ESNBt+P6f5NFWXfC2Ibw+iOc0/jvlkjGexAqVmCZy4W4O2r98/IVmZFzmJw/kp
KPJz/N086s3VBx3vXJWk48pqwKfpGVdn7VT3+J9y0n/NZKZeqPlO2LK9K/4+WkKv
uMoLggosM0fXOPqZDzYMO1JYBnjx/sdsVfAMQ00AWsUgeptEaNeUUjUWXbvNXtTB
YziIrvJ9EYDNxF9yIC7rpko2zFge3V9vFqpH/6PAH6HLmpq7jftfLRANxpGeKCEo
10J5C/eaKcWP6eICZUNDBCVLrnCsCY3s1vzbyVZGjnLWkE/zqBRFiC5GlOLnAy/2
kjthNo0B0REOpUHqwsV5uTY2+roxyQnViXapV7o6724ceSbxRV88Wp3QAmLjG69b
dqEeFSyTQcRLn1OQ0rxngYH34DPclcU5/q68vKsFPpzel0xjPOqvIUI62CHNdvXA
SOkJ+deIX69TNkxuXAeM/FJjkaQloQfKdNC7e1+LMC6z3JdvQuanp+r5mz9wWdiM
53Pma9Q+8v+nROBIe5FlkILTyKnebTza+FZoXMm/st/2Vb//e2rHP2vIcF1ZWBVa
4A2tEjxbYsrng2vxPpH07DmCLM3/pIGnpq4ITQs5PHzp6uEN4P8cuK/NRC5weR0A
81fTBxpFBRvPfOWJb7hB
=GM6g
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
