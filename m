From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Fri, 4 Apr 2014 14:26:32 +0200
Message-ID: <20140404122632.GA3686@katana>
References: <20140403145528.GA6199@lukather>
 <533D7E81.4050900@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <533D7E81.4050900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So what we really have is a single slave i2c host sort of. At least
> we could model it like that. The host could be told which address to
> listen to (and which single i2c write to do to init the pmic) through
> devicetree and then all the differences would be hidden in the host
> driver, ie we would check the slave-address and if it is not the single
> one we support, we just return the appropriate error for a device not
> acking, and everything should work as a regular i2c host which
> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.

I'd think we need a new message flag like I2C_M_PUSHPULL which says that
this message has only the direction bit instead of the address and needs
a parity bit afterwards. In addition to that, we need a new
functionality flag I2C_FUNC_PUSHPULL which means the host driver can
handle those messages. So, the PMIC driver could query support for
I2C_FUNC_SMBUS_BYTE | I2C_FUNC_PUSHPULL and if successful send messages
using smbus functions with the new flag set.

Not sure about the I2C-to-PushPull switch: Is it 100% host configuration
or does it also depend on the one slave attached? Are there some
datasheets available?


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTPqT4AAoJEBQN5MwUoCm2c08QAJCu2hoqtXt55D52+D/vTTyu
3AQd0CmYqYsNrKu/kU4YS3++vvRNGy2lpbcx7ev6CVPptiu4zMAu6eeLewrrchNm
JZdgoXtWc23JNxvp+x6qF/OJ88HAZgsA8NsQaESJhMjfHD9v5ZddbLyYTShz5qpU
3jGeWT2uxvk8PXOOYOD/3qjy8mhbz1mmqu5SkkNFv8TnxmtfHr9RinFMaHRxn1Fp
HEQTJe8WFCQZRptRkuh5AKFlGTi/gg9dXoQQvkgRG9NACNlpz8/EvrzCy1lJGThS
o8ZSobMRHVCgZFrLh7SCSI/3Zepn3vStsvq2K570QNfCC6uYCaGcCvGKZUBB21Wr
+bjTwYjVzYpkXYtKbEmiiaN7t/e+VMSdqwfh3JTsWxVSwzAcgoN5l2XMqZxZe5an
8FLA095BvDluVliiRWEYlO9mBPf2jxST5bHScggRQegUYhGhnSGlSW6VHsGcq6Op
S5Jf5tfxfZj80Buz577GCuvLCT9oeWS/eYRKw1GVge07M6QCC6Ka41ihfOa2YZlR
TmirpPxwPYIPD66zGnuwTovVAi4X9toxderthCEgVMe/vHbIIXDXh80E7EYK0jTY
xvzazusDaveZUVf4tocPa2kdzsvJK7j9PQ/6uvbizkUsTk808A6mxUf4HyWYmJKm
mxHO6HSam11fFAux3E3m
=heue
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
