From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND,3/4] i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
Date: Sat, 30 Dec 2017 19:11:54 +0100
Message-ID: <20171230181154.63yqw4fqodsxb7k2@ninjato>
References: <20171207102003.23496-4-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cy43xojbyi52rhh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60200 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdL3SL5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 13:11:57 -0500
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-4-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>


--7cy43xojbyi52rhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  			/*
>  			 * Map and check POR Device Status Register 2
> -			 * (PORDEVSR2) at 0xE0014
> +			 * (PORDEVSR2) at 0xE0014. Note than while MPC8533
> +			 * and MPC8544 indicate SEC frequency ratio
> +			 * configuration as bit 26 in PORDEVSR2, other MPC8xxx
> +			 * parts may store it differently or may not have it
> +			 * at all.

So given this comment which you added...

>  			 */
>  			reg = ioremap(get_immrbase() + *prop + 0x14, 0x4);
>  			if (!reg)
>  				printk(KERN_ERR
>  				       "Error: couldn't map PORDEVSR2\n");
>  			else
> -				val = in_be32(reg) & 0x00000080; /* sec-cfg */
> +				val = in_be32(reg) & 0x00000020; /* sec-cfg */

... are you really sure there is no ancient device which needs the
0x00000080?


--7cy43xojbyi52rhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpH1uUACgkQFA3kzBSg
KbaOvg//cTV2MXhzDz8OD6yACqlFaGcdcTHzhnCDpp2PAzB5QUz7ZFwz08WgEnun
+QRdwlqMk0EaztNXK2q832BpfhhhPqsenthbrHzOD6bxFWmc6PRDJ1oBT4lJAHE1
Lt2P9kFUACHbgoYOI3LLxBmgLw3BP1mbXHtZv60SVCgorsd1jx8kfoQlbjuiIAsK
Egmk1vJo/xJUyK8F0RvujzO/RL7B6rn1Zho259YZ9E6WCqQcHZQwhrXgL9686sHh
Jw/VtUIMM4L79awPhXIU4QtbuN4rL8jy++IXjtqYHouTp9F2WJr3+/R8eKZXsq+i
ZXPTlQiq7bVuZaRE7StmTTz6oi929utUdU6Ng9iopU6CXK9ssuRCwq4IdIPR8dk0
zWZoGYjCO5iee7xeiMRDFhAlK6DBpVdUL0uXZGLM4VGaaO+GS+2qC29Xbm/2cXYk
5qBCymtyNNG53gvErtrWwP5emTgncgtIuWuiUsFQAhV1HrY1hmQCQxXaSQnwQ/l/
mshdb/O4cS1MPtEUTTD2JJ7vGsDb+3pjST/238FtQW9kZZ3h52J/voerJ0hl3Z9m
XOxUtz8bfqcRysX7jZS2pXVg7UYhCWJ/0LH0Atvuyf++0RP8dLoUqMy3dH8k73M2
1HxY6o2iSxCUa51n853RiOcjPeJjtbLpaXnf/r5RoP33R/s0C58=
=nC+g
-----END PGP SIGNATURE-----

--7cy43xojbyi52rhh--
