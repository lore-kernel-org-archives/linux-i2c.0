From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Thu, 13 Nov 2014 18:49:30 +0100
Message-ID: <20141113174930.GF1275@katana>
References: <1415885111-4138-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1415885111-4138-2-git-send-email-ezequiel.garcia@imgtec.com>
 <20141113173825.GD1275@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141113173825.GD1275@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Very close to go...

checkpatch --strict says:

CHECK: Please don't use multiple blank lines
#234: FILE: drivers/i2c/busses/i2c-img-scb.c:181:
+
+

CHECK: Blank lines aren't necessary before a close brace '}'
#621: FILE: drivers/i2c/busses/i2c-img-scb.c:568:
+
+	}

CHECK: braces {} should be used on all arms of this statement
#810: FILE: drivers/i2c/busses/i2c-img-scb.c:757:
+			if (i2c->msg.len == 0)
[...]
+			else if (i2c->msg.flags & I2C_M_RD)
[...]
+			else {
[...]

And coccicheck:

drivers/i2c/busses/i2c-img-scb.c:510:1-12: WARNING: Assignment of bool to 0/1


--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZO8qAAoJEBQN5MwUoCm2fTcP/jzNDJ7WtpuAKw+RUdMDorxG
qK3cW+EGTauwiWZsPvIo8W4mRgfzHGqdxY73N1kzgEym1Mopj33857KKex8bnFMY
iZ2WU4dSceyVXey15mbwTWZwCUZiUikk/dnBZgyB68B5YhdkSa/F7lAHJEqdZgFS
R9/VMMHOM/S+STfCi06nOFeuPx7RVmVfgEz4n709lTnky1ywAtPvo52LIA0u8cxc
/Ko+CtFhBc0ag2uQxZr56IBreDfQDqqTIlvbZwGNV8I9QeB4p0DuW6sO5VBHhqLs
6dqilClU6eoE51eQjQdBLOxO94hvcVhFQCI3d3MtCBwXy1viRD+8IEW4cEEf1wxN
9j4rrvYSlbtW0RMw9qTATE+QPA3XsyazmLAUgSmVPJqpSLZuhelStiaLHxax5LEg
baKtUZF6hxLobGmrBkeLHjAMnMCXmuhfPrfrAMVSCmthKRjo5Gw9vXeF6rfv6xPv
f3K/unb9UHdK9mYIEW+EgRTh8+VSbq/NBgg5wHrF4sLv3VizjWLtLEbi8ELXixUA
vMZd9FhbHHQKw4w9m41NNRjensa4sNSpkZp6EGjP8MuZOBGHugeqDtWqsbaPdAgQ
imHDqY6nWvr5mSdUqjZDXU/vuwuIdicQJDa33apZ+VY3uXC+LieCvQnl+xZHIyjI
2S4DV5+Rsj5osXdtB8gQ
=CH8V
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
