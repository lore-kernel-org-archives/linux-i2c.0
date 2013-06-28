From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Add I2C with PCA9665
Date: Fri, 28 Jun 2013 12:45:17 +0200
Message-ID: <20130628104516.GC2948@katana>
References: <51CD64D5.60907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51CD64D5.60907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Elyas Razzaghi <elyas.r-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> static struct resource i2c_resources[] = {
>     [0] = {
>         .start    = AT91_CHIPSELECT_2,    /* 0x30000000 */
>         .end    = AT91_CHIPSELECT_2 + SZ_16K - 1,
>         .flags    = IORESOURCE_MEM,

Unless reading 0x30000000 does not return something like 0xf8, you have
a problem with mapping in the register range. Make sure the, 8 bit bus
width works.

Regards,

   Wolfram


--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJRzWk8AAoJEBQN5MwUoCm2lXgP+NQnXDMgKswittyzG9pPzL5C
AG1W6huXPBR2uB9Hr6pIL/4/pkb5YKSJubSn502eVaNJBX1OrHl4d0K/rh4S/LXq
akAkCc4wTK5+5qwtDTkktIhYPnrb+vq0E3jSfjnyW46Pvdyd9ws2wm03EyuusfVw
zeJQt4CVdMbly3AhfWc7Sr5xD8JRJxv5xnQuYbIEl4QFonDrWh80bbxYZemZpC+7
RqfsjxUv/hxuX0lT7cu1bj0nm3LzV053mTVbDGNiZL138BdXc6tkcrZ+AuxYvX3y
+4pQS/rE6WH0ihAszGnoqtIo7TOPs28EhldNLiHtC0zD7yy/i9LNxd30BRRPL8Qr
tzv9Pd40zfL4dl5Rq9eLcywVrLfOBOb/Mzjp8GUZnPb3SucAgc9hluVbi1erXpoW
Es4lMp6VbKBvTqjl4eVbU6HO2XBaiS2HKN//yoWE9cdDNbcpc/hMSP2wduBFk6qp
Fb8KqXnIwoUIXXemJvcg4CIqKTxQ+zoIOfenRWPAbayuN57gNo1eZvJdnLtNYkV6
EGmlW4t5BnQyT3SasqTyyI0vVRraGCk7ZNOG8806J34tCGnrxxTvXeRxkb3zXeMZ
HfBEOJQxiAhmGDcLJJCsUwUPKEE29+lFDZ772pMiS9VV09g7T1aGWoQVFm/NsdTi
9VWT/9aPBS1jXdOcYBU=
=2WA9
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
