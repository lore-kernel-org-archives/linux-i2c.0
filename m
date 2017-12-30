From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND, 4/4] i2c: mpc: always determine I2C clock prescaler at
 runtime
Date: Sat, 30 Dec 2017 19:14:46 +0100
Message-ID: <20171230181446.bxongiaogcqjrbos@ninjato>
References: <20171207102003.23496-5-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejwilx3evi62srst"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60219 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdL3SOs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 13:14:48 -0500
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-5-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>


--ejwilx3evi62srst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  static const struct of_device_id mpc_i2c_of_match[] = {
>  	{.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
>  	{.compatible = "fsl,mpc5200b-i2c", .data = &mpc_i2c_data_52xx, },
>  	{.compatible = "fsl,mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
>  	{.compatible = "fsl,mpc5121-i2c", .data = &mpc_i2c_data_512x, },
> -	{.compatible = "fsl,mpc8313-i2c", .data = &mpc_i2c_data_8313, },
> -	{.compatible = "fsl,mpc8543-i2c", .data = &mpc_i2c_data_8543, },
> -	{.compatible = "fsl,mpc8544-i2c", .data = &mpc_i2c_data_8544, },

We can't remove compatibles. It may break DTBs. We can change the data
pointer, though.


--ejwilx3evi62srst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpH15YACgkQFA3kzBSg
KbYgJxAAr4Ch/Y45NMQZ3GIFKpu1NgRF6jdHv7DSqAQ/MS4xcqFIY/jXP56FQgCX
8Jg82GKbAOTwlcgWxFKXTj9XTju9xZbrOfwH9NNAQODK3YrukSmriWMf/rXMlVR/
D3BkH6e8y7WCGT7BWHzJSvGGEEg1wGcG3DfaNj6RqSEf2w0RYwjpumVzQMJO6WUH
UmK2ZpBgxVAujSzwrgC12CEZ7p0PdA1xXwLBU1c4RRQ9HnWbWBT5TurYlouOtQTC
gQtTIcaudelyEstQARuqsNhsJIdGOC8Cpc9KC451Vpc8eleZJu6RsVWrf5va3KC6
neu0xIPB8tEf3MuHS/tbAVBo5dHY6cQsRA6A1UuSqgjbiuzu2ZPICHNdjHRtokeH
br3RvcIjbVb+k28gEXyM9+MAs2WL32abDS8sv/cMvRX4IAoR8XagRftjmSP2G3sa
xZriadAGXARqcLKXi4UY8fmr8x3Yt+gaAV6qoBeb1QXOlkrZs+MZTqcpbGbmf0tM
K+FVGMme3XUxSdJehpfepZfAFQXlltDnTQKIq38iba7gOuu2VliZl31Fuc+Gx3Hw
+KtQul7paa8tymG+yC/VtQvxkX6ZVPVYugNYwZ7WYe+J7WobdpzMge+Drm6uxwRj
IBhTxoaSnuQhnVsZLiHlc89qYpd/rQyLpGC3wX6NS7gKm48CVKU=
=V0xc
-----END PGP SIGNATURE-----

--ejwilx3evi62srst--
