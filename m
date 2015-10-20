From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: tegra: drop duplicated code for assigning algo
Date: Tue, 20 Oct 2015 17:40:46 +0200
Message-ID: <20151020154046.GJ5379@katana>
References: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43530 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbbJTPkv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:40:51 -0400
Content-Disposition: inline
In-Reply-To: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-i2c@vger.kernel.org, ldewangan@nvidia.com, Donglin Peng <pengdonglin137@163.com>


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -825,7 +825,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->adapter.class = I2C_CLASS_DEPRECATED;
>  	strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
>  		sizeof(i2c_dev->adapter.name));
> -	i2c_dev->adapter.algo = &tegra_i2c_algo;
>  	i2c_dev->adapter.dev.parent = &pdev->dev;
>  	i2c_dev->adapter.nr = pdev->id;
>  	i2c_dev->adapter.dev.of_node = pdev->dev.of_node;

I think it would be more consistent to keep this one and move the quirk
assignment also down here; then all adapter assignments are in one
place.


--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmB+AAoJEBQN5MwUoCm2rkYP/39SYZMGL/ULRgtkH+pWZ24w
z4uudiAmDzXo82atACQ9cZ9zBgex3XM4PmsVDhOxU2DDFd3CIuh/IOmAXmBfSAJW
6iW9rDIbSPIlcc46qln9twlDO1OQk+bFtque3pEivhKfnelxsFlukdo6h/2t4AVN
eemHBd77tqU6xBrrnvWOtYnJSc8CWG24c7oLIoE7mYhsxgAG03vecfFlkOO79U+D
Nt4E3Jm224ns8tuXIX07zjgP1wmtjMrnhz9eZk0Hq2tVd7GK5kGX65XLYvKwG2c1
zP0zVBnRN2gRz2DojM3WgSiwvIsVBqOvjyktzQLU9xXQEpgwelN/RBl6K2pIfBME
S0fgOklHkQxKSY+fOGzUVm5wo3dJh9S/8zLRlaSjYiIqE8GhVSl+clIygJBk01rm
6FYDPEPw90KD1d6D8nFPmw7WpB3mRXiKBgjlHG0aNOgTf0tUo6VPpHwg5zUq3qNx
NVSeeLmWHK5MkdRQu58g0G6PY8008eBXypu1xEEs+jyRdXpAR79dTLLNaaXSBpHC
YYPha6WshiAvvRYjp1t2j11a5RCMm5+e73PgXdbvRsT/NZM8cIXEQpM7Y9o2Dp4N
+hU942EAJnO4hDE4UxAL13LihIL7bTDd6440GnTvceOKf1Ql5dowQwsdpULjxOtN
SLjtNxksFitx1pTpMrgK
=cGVe
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
