From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
Date: Sat, 18 Jun 2016 18:32:28 +0200
Message-ID: <20160618163228.GG3017@tetsubishi>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
 <934365f2bd30f242d8548e2a27483679@codeaurora.org>
 <20160512051347.GE8453@hector.attlocal.net>
 <20160512061843.GA6187@chewinlnx07.qualcomm.com>
 <20160512175830.GA32019@hector>
 <20160512193229.GA10499@chewinlnx07.qualcomm.com>
 <CAPBZ5QdD6knEzQVW-BAgRSMcd=Gqv9_1Xt2LNc+qWgtre_2ZXQ@mail.gmail.com>
 <20160512202755.GA3680@chewinlnx07.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512202755.GA3680@chewinlnx07.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Sricharan <sricharan@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, ntelkar@codeaurora.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We run the command i2cdetect for address 0x3 to 0x77. The QUP generates
> write error for address 0x3 to 0x7 apart from other bus errors since
> these are reserved addresses. I was getting the crash in non DMA mode
> and BAM hang in DMA mode before putting the fix.
>=20
> Also we have connected the I2C TPM and run the following script
> overnight for both DMA and Non DMA mode.  The script checks for
> all transfer length and we are generating multiple NACK and
> Non NACK error before each valid transfer.
>=20
> a=3D1
>=20
> while [ $a -lt 4096 ]
> do
>    echo $a
>    i2cdetect -y -a -r 0 0x03 0x77
>    tpm-manager get_random $a
>    i2cdetect -y -a -r 1 0x03 0x77
>    a=3D`expr $a + 1`
> done

So, what is the outcome of this discussion?


--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXebAAoJEBQN5MwUoCm2gYsP/3GNaYb4KVyiS0knNaDe6i5O
v3duDfK3bnCm6bEtVM6KYl7I5Uj9FpNoeUHa8QbOo/J52BPGCouoNgg6eQy0Nx14
i4qRuSMlTRW6qVB9rb8YuzU3t7phANScbmnhKHLegCuZ8nzBpz7NR9lPsvLzUtlH
2qFJhURAE/hpMCgB9FUH5qzjrSu7wBSqmMx1weUVOJL49BNcIbM/jkFB8h5L81T/
gTDEDqHjdMz45XD4/hQ18agrnzbricgS3n8/AqlPPgOjZe+BAruR6xEvGsZ4yzDr
vMOXuxiEGHMillHtT6ml0XhCpJAhcAOano4WPReMYZOR+wZenMkr0STASqyo2Utl
QN9UaWgvgckJ1TPqy8ylJfsjfPMuNCRGwgUZrorICSJ4UGLXnjEEPZWYJs1Cgsd+
GDponlYT/Gankg5pl/HBBxSZH4wGAkUWOoGBYEZpnnGgeQjdBoZbJshg6rhfV2Q5
mD+l43+ZdWyb6zALnn/SShuXbzOYChiTtKnVW6t3NeSgCSMGgAHr/92jB0lYYizF
Mt94cr/8kbnGuFKVkQ7cFU9EoVS+ZHvkY715Tpx1ZZxUVbX+Hq6e6TrJMagzvU62
+acWMN0Fj0IFMqmJg3J6atDqAgZGhWQHx1ybZW5D7iSiUtVTazMIchV9nGiAH4Q3
ecrtl5nem07YRTRSRMCG
=Hkoc
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
