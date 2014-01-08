From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
Date: Wed, 8 Jan 2014 16:22:24 +0100
Message-ID: <20140108152224.GC15182@katana>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389193589-18485-3-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +		new_compat->name =  kstrdup("compatible", GFP_KERNEL);
> +		new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
> +		new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
> +						GFP_KERNEL);
> +

Very minor again: Strange whitespacing after "="


--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzW0wAAoJEBQN5MwUoCm2rxUP/iCm/g0Y4SnEDWGH3v24BCDL
+ScEBgt6G2fLcBdmgg16H+qWqx+7vOV6LnllHQdPXTZsMChcuhNeup1OnunoGqTT
jJcqZ5U+Vf3z76aRrcGynpRPer6UsKeK7CIPqqQRrgekeWJHPqDsAiCe+sccWWNd
vmAvtdPzYCZgusJfKSh5LDsqFusjyqCIPp72FSvHo97nmoPQDV1xQ765vgJA8qfT
r4mAUlq28k3dektQ+KKweqUqfgzxMQ59NJMPclMKBEDtkUwyN8tg7hvm+WuJxqwy
zzvTE9iX4M8hfZsKK0pf5LTpW5n2beC3DVR395K9mj7/ERexoHiAKI8Y87D3rw+v
CswM4srWNSUhSrkuxJipDuwv82Uq3Smiq8pC7ICwfsi2S9Ii9CjdO3K5Kf2Ai4cm
w6u/N1RjfjRes+AmJpN/4kwkauX2QpiphJU8HKcQjirFi6z2kaHSgccJ9StfnRg2
BUttqJcMQowl8bI66eOe86swzuvq6DQW+/JgmL1Pu2o4Bt52iH0hhSMeN6/o2Ovk
645QEFBoeRIDhZTZ3PZHFPVH0gJn22nycNsYsvaEjogkQPxItr+b+QJIXQ8+HqQH
9BHoSxnKLDpYKCO2W1ugQ5Y2brfxGdqDWlnXMF9JyJdRd5zcAx2ZyCLaQ8GnjyBh
icAZcQ5xOiQc5/FWk5LF
=nf7T
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
