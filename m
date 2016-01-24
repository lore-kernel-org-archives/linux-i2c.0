From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
Date: Sun, 24 Jan 2016 12:33:18 +0100
Message-ID: <20160124113318.GB1775@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Sricharan R (6):
> >   i2c: qup: Change qup_wait_writeready function to use for all timeouts
> >   i2c: qup: Add V2 tags support
> >   i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
> >   i2c: qup: Add bam dma capabilities
> >   dts: msm8974: Add blsp2_bam dma node
> >   dts: msm8974: Add dma channels for blsp2_i2c1 node
> >=20
>  Wolfram,  Does the first 4 patches looks good to be picked up  ?

Except for patch 3 (I replied seperately), the rest looks okay to me. I
wondered a little if it would make sense to make a new driver for v2 +
DMA, because the additions were quite massive. But I'll leave it up to
you if there is enough shared code between the two versions, so that a
single driver will be better.


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpLZ9AAoJEBQN5MwUoCm20/IQAKSFLox/xoAz33+OYp5woz/a
bjQlyYoIhC03MTtVy6v7wDZkgxkhfYLxLMgh5hz6Dl8w50jbsPrv7842v67ZarVD
9mruQCq4hBH89ZyJjx2i5bOkEYexQMQp3LubKiVA3/YiW/Fih0sWzTWjkvPjMUCG
wtMtWznWmg+6mImj4LRrPPQjlRQouDrX90IybBWG93egc82OmSxnFsWaxXQNCYvX
FBIC5YienjipVGIbkGQVJcl8ac32q9on0xUmDIvnH/ElR64ks4z3FsdNy1KWjj81
HrDrR2F1TkDN4Zm71DNn7+xPxN3dHv8d14Pu+Kv1BPUdg7I7KyrQcNaFaGo9sXVE
JB7X+NSyq362k2A05CkBiH5yJAwUHb5rDXz7jSRnM4DNQol0nAVLWaBZAKpzCGEU
933nS8u+XtMEBQnzq9uNQSKWSRM5TxP+nPWm5vCeoSX8hqZa7mbHZtfXxMmOHsdD
y1bcCMN4/n2VrlLfZ4J+yRxbArlVbBYwDjhOX6SRpWfiFmOJkdouHyrEVEQSIxiz
HppeD1dKDyAhlheKtYisVVtK6UIDbtqejfmbFgPdmBZBjbAa/a6zGW65QzzpHVys
k0EKzUnjAZdPGtXjaopK2b8KPxck5OjhQO9y5O/vcOo9FDZMpHqVKoGXjsBC1GSm
2yLZNQj6w8sjTlV4+3ZC
=/aeP
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
