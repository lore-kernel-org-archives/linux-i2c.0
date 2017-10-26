From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: use correct format identifier for size_t
Date: Thu, 26 Oct 2017 22:23:32 +0200
Message-ID: <20171026202332.gmdqgvqro5vxoxgq@ninjato>
References: <20171017221709.24992-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xfhhezh2f7ejwun"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59647 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbdJZUXf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 16:23:35 -0400
Content-Disposition: inline
In-Reply-To: <20171017221709.24992-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>, Sekhar Nori <nsekhar@ti.com>


--7xfhhezh2f7ejwun
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 12:17:09AM +0200, Wolfram Sang wrote:
> Fixes this warning (found by build testing with 64bit):
>=20
> format =E2=80=98%i=E2=80=99 expects argument of type =E2=80=98int=E2=80=
=99, but argument 3 has type
> =E2=80=98size_t {aka long unsigned int}=E2=80=99 [-Wformat=3D]
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--7xfhhezh2f7ejwun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyRD8ACgkQFA3kzBSg
KbZS1xAAjx1Pd96m5tCGwbGzoA3urWOFOfYtorN1F6jrJZFWK614PZZQIWHVXNqU
6Q9edPEBeexL99MRSjS0j+BEFLwn7PP+/eTQLAWbhi7BpqFszMOglumX8GUoNFaY
jBaXHEAzbk6Nt3TKTX/uKaD34cSuJdNE4LnPBFU0xmPsmojYfXOk3iaYmEveW+tC
QEOSkRwDUuzdh62fWKCRUTHP7M6yIN+7HbrseLzgC6dQ0Bbl64YhhX2EXiWl19gf
7w8v/e+VFYjMgnCgkaybqwSMET3xzAeEX3VQ+r7vM19UDQYjsmRXoHzZ+GbGt17t
eojJo3kmgBR88VYfkhTMbVeCJ5fvijUFrWn1DE58AXl0J88/785dNzG260lFlV9N
DEhw/cG3jtM05PQ1vAeF+4V5AqGUGF0kR5aF8OXjcGSFv2osNpZyAbqtjTjJHKTq
AFmBMHOQUE/0ARaR3f4TcZHTEIUl9qFkDpoMhBIfvXA3Vt3m9/NeHkquxZVysbTb
Ml/imShY2t/rkLvSSnyAWj1EE372lYGdgZaH1N/eWNk1pbtpvi5Y6F/Vudw0h8H3
ytlb1Df9kKGkW00uZluleuwjGKk/ODFh+QBxyo988YHuIHdLqnQODtTUD4pTowii
n6a8qgYp0bHVaKKZoSKsrIqys9pH5SrGrnmQkeFMnJZbkzRDU6A=
=fo1J
-----END PGP SIGNATURE-----

--7xfhhezh2f7ejwun--
