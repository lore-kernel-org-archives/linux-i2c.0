From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: mxs: Use devm_ioremap_resource()
Date: Sun, 9 Mar 2014 21:47:14 +0100
Message-ID: <20140309204714.GE2835@katana>
References: <001101cf2729$890d5b10$9b281130$%han@samsung.com>
 <001a01cf2729$dc23cd70$946b6850$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001a01cf2729$dc23cd70$946b6850$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Marek Vasut' <marex-ynQEQJNshbs@public.gmane.org>, 'Shawn Guo' <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sascha Hauer' <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	if (!res || irq < 0)
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
>  		return -ENOENT;

Please return irq here.


--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHNNSAAoJEBQN5MwUoCm2a/MP/2sOME5RqcD/KDNNVkjOc5Lb
r4z08/2ESfg8HjZGfo9wfLHcLtuqjL6bVZ5kVM3pw1gqZgG9fkYRi03/jCIzBI2M
+peyLov9zFP0qjvUJ26oOjShGmso50jeK95I8zcr4quvKgw0pRuKHcYtsL0Z/STd
gCDx7xgV8XW8MVALfOGN3x/lbrQuSEo7l8r9fip+kG0LgBDHRjURoT8n95CUtj2K
T45IpUvuSTv+UZivNWkKi2CfBn8JRdpMknHEf53NU7vt1Fc6/rHPjLChSTalkWhA
NRt2u/VSN3prUiMNUdWnv85456TOZ1wY9K0HN0k+ZkOjaLdwMO1lmRpHDCcHrbtV
TAZhyrEIvTTQG2Mke7EUvJG2B9MNkktcy5auBpDtt4qmomKwPvCSEq13k6TTglAm
T9r9GbJyPZiHhgXDUoadjRevwSt065bm2QNs4u97yuKAlYzbwWPYahEXYmqzeC67
ySsmYaL5hUungHF/PuUH/oMB5iL5/hcYNymqdU0XRp/VFBFljNOamyjyioUa3SVQ
fVcD4QS4BmiA30/cWS2jYdYhKNHaHsgCn3WsBDPdOQjqF4Fo1Jwc9HiGxwZoxlwu
O/xRGZEHGuYu5jyJ0R8xmt7nGdsKScJOKjWrhEpxkrAVftpakRbZSKLLWGctANBM
DsLMvTht5kbKfzgNBdev
=a3+E
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
