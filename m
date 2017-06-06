From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 13:23:48 +0200
Message-ID: <20170606112348.GA3275@katana>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
 <20170606102447.cftuyhtx7zo2fe2g@ninjato>
 <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
 <20170606105431.bm7jiclz2k7h7lj2@ninjato>
 <CAMuHMdVQmFqC3pZh8BcNROnrdqQ+gx+4Mg40Y1AY=WXE9i83wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:32812 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdFFLXu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 6 Jun 2017 07:23:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVQmFqC3pZh8BcNROnrdqQ+gx+4Mg40Y1AY=WXE9i83wQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I have it enabled all the time. So my devices may stop working...

If you have enabled it all the time, then there won't be a difference
=66rom now. Or?

That also shows how rarely I2C DMA transfers are triggered from within
the kernel :)


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlk2kMAACgkQFA3kzBSg
KbZXXxAApF2z8deEhZL7UiVAwf+4hgTWw3d6ckZaH9aqLfHTqRuQKcbbSsArQnRx
Ku4CABR2jLeyIA41irssmxgksiuyF4UkguBcUtycx32Ecsj6s9yTbT7lo0acXAyp
/8mZVRKRQzEWXg/+PBOOPCpWeR6EdXosEaOAemYvQbf53L/9AWb9wXhonpEueaea
1nRkmRREdOnqOvRojoq695dmGwqmOpk8B+Thu7NNpDpWZjBz1q1PIS/lQAuL+rir
MdVH9i1cVu6PIKa7lETfFbwyIyhKyXBjeim1sBwelaiMxgLNQSKRJroQsJvmWKaZ
ro9yGjDVAR2YpUAEUhfDvvM9R/FxIgDwi+okbtr/5uBHicICUXIIayrlihO3KQzr
mBXIN8srDFKoRtXUP33ZTIw03xiHi6y2lh4nmPi3toVGn7BkfRKTuf+66qKOkH0s
jsrn1VJ9aRnPlO81Gq8nijVlKSyvHPUMgAl+KZz+qtm1N3K0nr5Xp4uk8XDcBgf1
YfBDLeFAousNYa4XCVbi8ofe1kUm1QDzPSyIBMQLiTTW1R6yp0RLkzQunwFRqpvU
19jNIeCUlhuGt41xh2P2Iq8JeSHIm2riZx0YGCZE8E+F3Y8PAMSzHpHhQWh8n39J
uKMEGGKXl7hY6hG4H/unm7++hrRrUWcDzDQAFowlSXTROKXGw6w=
=TS1t
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
