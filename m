From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
Date: Sat, 12 Aug 2017 16:44:11 +0200
Message-ID: <20170812144411.zqgbncsemzaolldv@ninjato>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
 <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="77qcbpvljp43fpxy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502506672-7620-3-git-send-email-jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--77qcbpvljp43fpxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> +	.max_num_msgs = 255,
> +	.max_write_len = 65535,
> +	.max_read_len = 65535,
> +	.max_comb_1st_msg_len = 65535,
> +	.max_comb_2nd_msg_len = 65535,
> +};

That looks like no quirks? Then just leave the quirks pointer below
empty.


--77qcbpvljp43fpxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPFDcACgkQFA3kzBSg
KbbSXw/+L393MKgpXHyMY/WZ6CvLAXdqNttJ0BSmBMBkbdGF7gyJzB1pExS5kiGi
7AkbCBQKI7hhvC6fVPJL8DQTTjKsgAljJSbk0zu6CpdtxBiHnBVyxR3ZBhq8Mm8P
gb1whgxVOgcKsrDCiCTlUITqXBfRctFrAr7o0CI0DlJoA0ccqixKzodKHBXFtACT
uQPknHTgB8iDjRe4ZnW47w0M+smKBKTkKFTCwmZ7/Ie6qlj+BsQshTsNpH0JXEws
3Q9rh5yv+OyK0g4WB0/aMa3GNXHf/5mcIwidndwtWXxHaGt4zu0TFkysRJN/BSXt
IqG3dcBMEi6RKubiitK0EZpHL947N+jUwZ2JWvLyvnRgoU4h28wjJQXfdmewsedf
CEQL3yaVK533CJE45HG/Mn/VI2qj1oNFNOXrieG6y7QpEIkKObqoDAkHdwZlZMd6
jQmwNi8Omxh0fD8q6+SmxqyWAJ/gQIHwobMHRV79r5l/kKL6hPbsJll5cAPbGYTs
RwVQULPwyv/gLxqrR5PYIObiyhvOaQIHnZ3Zh6gY9/6TEVKhzTXNGm8WQXidyaVo
HFdT03x+sPimDTy+5vmyG5PiBQh6R11DL12HZbVkU8W8j/KhxZ8f8rLiQnE4BCtb
0zTfTlp6xZe3mHQMcq4t56EuKiHLURutNt2UB4wt3Du5m/7OUXw=
=iZLl
-----END PGP SIGNATURE-----

--77qcbpvljp43fpxy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
