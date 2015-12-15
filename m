From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: xlr: add support for Sigma Designs controller
 variant
Date: Tue, 15 Dec 2015 13:14:18 +0100
Message-ID: <20151215121417.GA1521@katana>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37711 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965217AbbLOMOX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Dec 2015 07:14:23 -0500
Content-Disposition: inline
In-Reply-To: <1446429818-24155-1-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 02:03:36AM +0000, Mans Rullgard wrote:
> Sigma Designs chips use a variant of this controller with the following
> differences:
>=20
> - The BUSY bit in the STATUS register is inverted
> - Bit 8 of the CONFIG register must be set
> - The controller can generate interrupts
>=20
> This patch adds support for the first two of these.  It also calculates
> and sets the correct clock divisor if a clk is provided.  The bus
> frequency is optionally speficied in the device tree node.

Fixed the "speficied" typo and...

>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

=2E.. applied to for-next, thanks!


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcAQZAAoJEBQN5MwUoCm2rhEP+gNIs0Hm6xcEsZUVKTxjTuZZ
3Ui14i7kqnpVQvrw6FNOWRaH11GpeEH2wni7Dl9NDtcAGc4cIY0FcpYGRFiW7ztO
LSiFJhcRGNuIvY05DgSIsIYUfO1Wf2Q7welyDxZ9fDnNB2OxohwMmCCH+cI2bV55
ohEUeOKZXTBNbhnw5h+uc9kLea/bV1n37TJtEtr/xaZpy+w+tCqGx2/n59rSPeiW
9HkNR0gqcblhgdhXDC/o4fOyNlvSVGrIWnS6JZZy8M0zpJsXRzLkjpFKtZAt1KW2
+mSeQJNQb9i3+cQbfg0hh5Z7OImjWQ1YKwjXc2EZbwJdEmEXaaogZlzYAF1d1GOY
TbI5UaFweXkiFVdNePsngO225ZM/EPGwPCZXgThLPJyYR+zKZSqKbogwNvxiYbYL
j+ZAqQX2e2Eg1iNPNAAvJxrtvUYPI7DGWk6K5J2pcjVhfzywLK2AOebKu8R09jJ0
4WAAdcMb0JDm9WbYR+pzZ8vSRqiTbUfrYcf3bnBQ4YaQZY2sfaOAGRen3oEUIgdr
DHylqpuOJyX+Y8TGe+WEb5hipXP44uyefVJTkbRKxp8TyuZWtAzCKIN1h5HYC0DB
RBlaaRK4H6WaYAm+HmNoZC8GNLVMy4qDrvj5Nr0ev6ZNuLF0+eEGYjfWV3Sj+Onx
BtL7JGYBt896UzE2CcEW
=Wqv6
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
