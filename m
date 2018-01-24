From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2,2/5] i2c: meson: add configurable divider factors
Date: Wed, 24 Jan 2018 12:46:26 +0100
Message-ID: <20180124114626.mfckwbcacoyjzsin@katana>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
 <20180124062830.vi52rtlgglryq3xz@ninjato>
 <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3aq6b34umpzpsxmi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3aq6b34umpzpsxmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> but, I didn't get this build warnings while test locally, so is there
> any specific compiler option that I need to pass to?

I used "W=1 C=1" when compiling. My gcc version is:

(Debian 6.3.0-18) 6.3.0 20170516


--3aq6b34umpzpsxmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpocg0ACgkQFA3kzBSg
KbYQxg/+IHS7qKJGUy0BVutSN89Ne3OdUMNFo6p3C2Xy0bI/71m3l0iXQOINMP6Q
tuXCt9V/95NDlMKT72b5XxuRexKziq3gfz00wr75Jv4gqURigY1a/dCYS+er0xhS
jquc+PUEflmDoB864U76eRsv/psb/LXVjd+aPHiqJOkzV6LAZ09BFN0hHSL2hF09
+AZ0XjTSZPC92EfDsD9zT0cdwbH2rCRCjrQANfkaBnc9w0arQpEe+O0fQD84tgH6
m2qzeKu+sjno5Ti4aTgrM7YKJdFJE1XT4cAj1GPDn9UEGRKbNolHIVTRIZ6kJ0AJ
dLLu7yO4gnjwAGgyh5UXEuuevvb1yCcnkdahjF1GiyV7I1v4qpQtg5sGK1tbV9ym
Bx3CfRQCsZtWRo/POVDoXAgQ+hrPqrZAPEXUHaVCuR4MLwiozULG8AHEnJgBxSIx
1iBc80SC/1OO+XhrHNBSh/+E3olKXt2onyMGCpfEOSj7SM8bs540WFcyWhXa9kFa
urLotlS95d0UgMdPwd85ORh4fzCc6+fwtX4g0vN9uB4FXA2/MZYsMASzxnt7Bh54
3BkWSp+hLVwIm44/7KMua9a2euUeNw7ppyM1e+mGhZ4gDmUO2ldwtOlWvOLjOzG+
nmk2uv3CLtOVuK7zr69TO54SQgJ2ARDCxRdj7t0iKToGW1tzNkQ=
=ITpd
-----END PGP SIGNATURE-----

--3aq6b34umpzpsxmi--
