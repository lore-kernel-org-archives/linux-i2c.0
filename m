From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Tue, 24 Sep 2013 09:36:10 +0200
Message-ID: <20130924073610.GA3091@katana>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com>
 <20130923071012.GD3051@katana>
 <5240B626.9050904@freescale.com>
 <20130923220921.GA3244@katana>
 <5240BDDA.3050206@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5240BDDA.3050206-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I see. It is using device tree to match. But the device tree doesn't
> have enough information. Many platforms don't specifiy if compatible
> with mpc85xx, so they fall into .compatible = "fsl-i2c". Please advise.

The 'if (match->data)' block has an else branch which will call
'mpc_i2c_setup_8xxx' for fsl-i2c. You should be able to make use of
that?


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQUDqAAoJEBQN5MwUoCm2tEIP/R5EuNT32lZYLH8Ao9oetVol
RCuidkBUrjmm+sX2Qs8paSC/w2whOmche+uVQ75pcXUPfQox0bPZ00/4w9uH/YAj
QLD/huz9oZQLCYXxRa3q59GkGA8L17acv//iRj6fDaoUR+ECvZq6LGGBfkgOC8u4
0kw2t0PMx8p+ptl97RMkgjdudBlHlYGPL/vnM9En09huWqEdDLDO3brs4AOclL1V
I7ycaIdijpLmidP4HpraGQDsfuQqKixgdOsEs38CZINsYi89kxb4oXctDyLQQa2D
c9JtXb4iXlKIQ8xzUxMeEQX0SeuE/kFPdDYNIcEQI9tZM0p9OYMfX57OVsED9y/q
mrnYe64IBlnURUNANSXbw8z3sMK8IH8yVD2DesO5/b4fxcwys66MZfOwAQf2Wgna
A0QdGlQUlVoke/FOgDq7bdI35f+P9m4HcMGxPiEPbnO9GKzr0r3sOZUp/TiGjnPW
+OiRYjQ+5T4pccBbjy+3V+Xlipm8ePFbcP3d6QWDD0HWrxH00gd2miDnzA6Wpe3i
g4AJma6HebH1L2FL82o1LYLwNtydaRPiaDOBLn49GaIxHbx+oEjTwbwuBLbVzMBy
HmnbOTFo2Tkb7Kqw9AZ+JYNGOSm1reelvnr+gc+/OeKCNIUuUPobIE3LPgkjH50H
FfkK2Joukp2YzHjdzCF/
=NzPb
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
