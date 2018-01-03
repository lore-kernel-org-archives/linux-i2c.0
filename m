From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: Add MediaTek MT2712 i2c binding
Date: Thu, 4 Jan 2018 00:55:50 +0100
Message-ID: <20180103235550.vh6adlqtkb4zmpsu@ninjato>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4cdoa5faojlax7k"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48347 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeACXzw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 3 Jan 2018 18:55:52 -0500
Content-Disposition: inline
In-Reply-To: <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org


--x4cdoa5faojlax7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 02:51:01PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> Add MT2712 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT2712 has timing adjust registers which can adjust
> the internal divider of i2c source clock, SCL duty cycle, SCL
> compare point, start(repeated start) and stop time, SDA change
> time.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!


--x4cdoa5faojlax7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpNbYIACgkQFA3kzBSg
KbbWPhAAtjuUknLUJKKCHQ/nN+RxtslbEnrUWILgsC8/o4+X7uU6e/deREsWA1A6
jzs4h/Yu5eWNlnMnBaeQcWjEExKx9byxB75x6KrIFzuAmyz1+m/HblVCgHPoUR0z
ggcFK1P07EImhy+FxcTS2+9hVCbnRlk2TynAC8V1PLHFDoql7EbadUmg1HnmN2QP
Xfzco5urRFqZqoJKcyvsY792WXAKr7AjQaqm0DeqXjVJoVTGHDDkuCpwfW06Az0D
D4CJaBOsjqqk2g44/3H/r72tt/qQJW+h8hrAGwP5ph51YlcFS1Qa/r1w94Bv6kBk
bD9EKtGiNJm+7QUmxk+JGH2sTFg/WfmvW95MAsa7kp3+bptYURQi5MxkT5RPuyb4
7eTH4hDaMExyca+l4fgGFDsu0+F1FhqqVbNMA6nNQib6y8+89O9DX6t5YlGEFMKn
SI2CXXHMdjSdwzC2TtOUUuPqV1B39aacEbFFzK0+S4NP930ozr4r9qlRKXHXrmnS
Nr/Np5apemwD1P2hizLR7NvJk6NDU8yaLYjirlSRdvYY+w7s9PX7q0aJzCQA8zgi
fAXPca/ZeJH+0RZaw1y9r15FImieKhSjMfZP1xQ8EmzyeGwwODAcPZu3bdsbs3dg
37avtiahRjUO9mrg08wkPf54lMnaYhQgt0BBYOMelwL9LGGPiEw=
=L+ij
-----END PGP SIGNATURE-----

--x4cdoa5faojlax7k--
