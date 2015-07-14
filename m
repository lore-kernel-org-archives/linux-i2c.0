From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v4 06/11] i2c:pxa: Use devm_ variants in probe function
Date: Tue, 14 Jul 2015 13:35:57 +0200
Message-ID: <20150714113556.GE1517@katana>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436859410-28878-7-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436859410-28878-7-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
> +	if (IS_ERR(i2c->reg_base)) {
> +		dev_err(&dev->dev, "failed to map resource: %ld\n",
> +			PTR_ERR(i2c->reg_base));
> +		return PTR_ERR(i2c->reg_base);
> +	}

One change I did when applying: removed this error message.
devm_ioremap_resource prints out the errors it finds.


--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPQcAAoJEBQN5MwUoCm2ApcP+gLWgg1sJgxHPdlBfZ6p2PZA
FnOlSmQCuD1twRnNhTKAtqz636MXwDrDrbWiydSBZ/FIqjP103LJQyXn/0tYeSpk
yDwr4osT+dxy7ErLiuWbCYiyszpWCTEutT1hJgI16n1VGP0N4JHZGqo4LUMSGpne
1D0ORO2Bsy4oKZ4SS8LsmKmU4+VNlghEeWOYaj2G+NSHdoe+/HDNudkk7HZJEoke
/pYTXOjIFLLlxkS8n20TQQUzDigAPw+Lqd1YV3PNB33/8LRNeg6GazLUGzPsb3ED
mxZPwoPgBCo5NkznyRFU/evqileYe6P+1X6vocWg5kLiRynZTiW3ShP2YaUHjIdp
oGZ2ntjLW/5JCiKoqhSiq+0VCDc91m1LqHwWGZPK6w+NK1X0FIbddBVlD75cOIAg
eB3l20Uum6HxGH1aSwqs2x++2E9cPZwGi6sRo3GbNEcc0O9nYOppn31VCG+G6umm
kkKF7mcJRrK3MaMcZorBQL9nBOy9RTuRM2gFJvFuehWrbG5JeNStkBGnag4S4sbE
07ZK7xx/oV6+dRsin/gn3Pn74SoE2lDQASH0oDFQwyx9CJH0H0Psbecf1/SvpuKy
XcJiHB5XAbsv2V4I3zSAZu4DFxAXG2BuGnjpPdqbSsdNFv3zqCgS4m+u1faq1N9Y
2rac9YqGShJZkSHtQ4ux
=vQAx
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
