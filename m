From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0 based on sunxi
 SoCs
Date: Mon, 30 Nov 2015 14:51:41 +0100
Message-ID: <20151130135140.GD1513@katana>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60990 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbbK3Nvq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 08:51:46 -0500
Content-Disposition: inline
In-Reply-To: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2015 at 04:57:08PM +0200, Hans de Goede wrote:
> According to the datasheets to n factor for dividing the tclk is
> 2 to the power n on Allwinner=C2=A0SoCs, not 2 to the power n + 1 as it is
> on other mv64xxx implementations.
>=20
> I've contacted Allwinner about this and they have confirmed that the
> datasheet is correct.
>=20
> This commit fixes the clk-divider calculations for Allwinner SoCs
> accordingly.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXFRsAAoJEBQN5MwUoCm2Ld0QAIQrc3IvMAMhhmFibZDthGiJ
ymQI11DLX+D3W07L5K5KOafHa2w6i0Cfh3YFKQqydtQbjqn8j/QL/Xvq0jKohT+3
mUTq5Dt6aG/r0JcdUMLK/FILMkTY48Hx2KzCs+YjVDTrwdSEnRZ8Lrki7hJwnaHH
y/rxmG80KBgKzonc4jXDQ3qmLwhAukNNLfAZQiywpLJJrfYuU3qwkRyOLQbE3HCk
Ce8mjY++bqTbJETuCEQ94vk73DvUqdO2L5itSfDaASaoaKcQzLE/5t3ZufmnzEfE
Cz5kYNXbqgcAGVWt5UiLfxKTBU3yrxCHD3768wB5WVuCAcJ428djcxvIGrkSNEzB
mGP2J5f+GKE0SMJTGN9TrBrWTENN4RdXWtO646sDYU5KaxSnX7D7fdxu0yYF5zg9
ufWUAg+1ScNK6eefUOvMsoMMLVXh3c/lGFKfFKWtNdgUMDlJtU2MvY3Ed/1OosxP
MjNbY1cWvbzu4tQ9VcJ1GQlZN3TzhL8qRQzls1a6c39YA45k6r8lad5OXXMN42Px
SEzCn1M2EKuo/b8sXnUdHCdTN7Gziz01bKI5OkJaLNMa+r09onD2oBPH7Mg9b21A
ik99LwxleyIdXrFmmcgPF0WskqCagToSFTIiY3KT2vDgAkc3rjoIY6yTtofD7585
PwqFzHDMylwrDTizKJbh
=manE
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
