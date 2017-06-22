From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
Date: Thu, 22 Jun 2017 10:07:30 +0200
Message-ID: <20170622080730.o352kxrs5pz7wxnf@ninjato>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250>
 <20170620074126.GA1541@katana>
 <20170622074831.GA23753@dragon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubrqga2l3jiehp6n"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36326 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdFVIHd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 04:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20170622074831.GA23753@dragon>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xin Zhou <zhou.xin8@sanechips.com.cn>


--ubrqga2l3jiehp6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The audio codec is on address 0x22.
>=20
> Why do you think it should be broken now?

Because I thought that we skipped the error handling for every transfer
when we removed the call to reset_hardware from the xfer function.

So, either it still works because the transfer times out. But then
i2cdetect should be really slow. The timeout is set to 1s, so it should
take 1s to scan every address.

Or I am completely missing something. Then, I am sorry for the noise.

Thanks for testing anyhow!


--ubrqga2l3jiehp6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLer4ACgkQFA3kzBSg
KbYjXg/+JN/yp41RCG35wgv4ktWieRwzeemsA6PnyWIlIDzJ5iCoLx+iGNTYsPKY
wr4LEATsi3cvPf0R+1dKgbFLlGPRffilnKk11coEYzj8IbXXdUs+CSKztyfRtDTv
bkteEtPHqEQwIkgaXse+LgJXZj4FB64uNneqE2dL6/udbdMTLTE27kENlqBMSU19
h6QqqswIS97h3FfgCARFue+alNwJOegbpu/PvBhFH1zjysj/ptJw4tNCm7yvHltM
Saz5wHMZJVhvvEsjE8Maq7TCK8xi+yEJvzqpXD+CYTgZTd5Og8IM9qg5TRpq5vae
uKbsL0nzTcdlPzQDrAa+vTiITJ0bGEtvkdrijIh2VYlqX9MPq9s0yL/y+EVgocei
Ore2lbm8amtopoiZqfQyluPk/njtyphrfH8XerSdpJF9VbQ0K1dFu5dibHfVo/ud
r1rDkaGNamAUDqujzMHiBNDz+pU2b4U/2OXeqDgCyglYZ6wpbIoGnssmlPHsg163
cs90szR1ypoP4NXkSXjkRZ7rjYvld5AdP6EnJsGSQDOeTCGBtptrOLJzFZc0g4w0
dUpbzjPe9Lg1mB2Ri6+IHGT9Zb2x7FN7trV9BfH54MxQusKTe12L0murM+YuseXR
nmayVRncYqCX5EB8VbpDEXW8nBQWQbf8cbLBEduE6gPv1qaalfo=
=2MQI
-----END PGP SIGNATURE-----

--ubrqga2l3jiehp6n--
