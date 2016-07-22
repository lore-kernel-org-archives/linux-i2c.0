From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] 2c: mv64xxx: Use clk_enable_prepare and
 clk_disable_unprepare
Date: Fri, 22 Jul 2016 09:14:23 +0200
Message-ID: <20160722071423.GD1605@katana>
References: <20160720051417.GA21765@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50817 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbcGVHO1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:14:27 -0400
Content-Disposition: inline
In-Reply-To: <20160720051417.GA21765@amitoj-Inspiron-3542>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 10:44:18AM +0530, Amitoj Kaur Chawla wrote:
> Replace clk_enable and clk_prepare with clk_enable_prepare and
> clk_disable and clk_unprepare with clk_disable_unprepare.
>=20
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
>=20
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>=20
> @@
> expression e;
> @@
>=20
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
>=20
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
> Changes in v2:
>         -Rebased patch

I still can't apply and nothing changed to the previous patch you sent?
To what did you rebase?


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcfPAAoJEBQN5MwUoCm2RPQP/2wU1CN5dRMN7rjhK6P9tX6x
7fLvqywaaY5jOp6HQLWq/nKv2RwLvm7XvwItxS8Bc3cF6EoTDvU1bPvtEfmCdoaj
P7deltutiCN6cVwj77XTQPtWbZto9bCWGwmaxr5Lt/kYrUu5tTJTyrxKprF4N5Zz
MavwcCFFRCGCOFdwSdGCGBQx3OCNLD1+Azrcvb5ojq7z+D2MauOVna/dJfmOgmiF
MtGi7tpdXpnlKT3creIR4fNt9mkwKuKNxwmugx26+LPW9KF+TtF3Z62IyUIJAUSS
pbM8j6VsA7DL2kvGPgaafI9Dhx9KunU4UtK1VZ0pC2csw9ONmRZvBeqHr3QSFFmj
oQok1yEAq2m2Fc/R+cU7qvfIL60Y7fe/XtzlZfKGJ+qqkKmNB+M3JcSuK9hG1I7q
oBDJ3ZwZAmMsnWHlCBjL0XNqzoZBjXbgyfjKcW+XJWjeVJAT3C1bjVke4vfWoKrL
EocqYnEns7qyilsu4fle46QYPmVGfRke2iFh1aIujWbCBoe3SY6meT+/4dTku8Y7
s0wZIWixdraJ+W9EUldjWQysUMu2g/Id71J3WiTDymWIZ7UQ8QkdSR7pYcBHP37+
6sFdExacCcJNZcy4v7jaYVHaREjAw95fJ25E2OyaUq7mQH4iSw8PHNDs+O+DH8Kd
VyrC8tnSWTGpzDdhsB2D
=9GgK
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
