From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Thu, 20 Aug 2015 22:33:18 +0200
Message-ID: <20150820203317.GB1635@katana>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
 <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150816131130.GC10094@lunn.ch>
 <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <55D1DB24.8090602@linaro.org>
 <20150817130945.GE7537@lunn.ch>
 <55D1F6CB.2010606@linaro.org>
 <20150817152504.GI7537@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150817152504.GI7537-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram Sang has been maintaining the AT24 driver since 2008. We need
> his ACK to this change, and since this is an i2c driver, he is also
> probably the path into mainline for this change.

Yes, currently I pick up at24 patches. I am open to move it to some
NVMEM framework in the future...

> But we should also look at the bigger picture. The AT25, MAX6875 and
> sunxi_sid drivers also have a binary file in /sys. It would be good to
> have some sort of plan what to do with these drivers, even if at the
> moment only AT24 is under discussion.

... but this surely has to be solved first.

Regards,

   Wolfram


--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1jmNAAoJEBQN5MwUoCm2VrAP/3K8TDFKX2e/J/VRheHP/G6E
Lff+Gx5s4cYPgvhWGtxPto6qOTPBFD+S7DecK4Zyc4ZSAF+tHDVGW39XsZoZRysl
vy+D5Np5gXl/C2yOiKtD3HmOsuRIwXjfHkIxNAnwlM7o3djQf2f66p4z9msV0CAX
BYrleupxwWWL1BM5H4gsFrTq/Di2Xtize/1TWRJP0ENR4r/RZP9Vu9/PzlGXefzw
BbZg+g8yMmq4tCxYfhH93inOoIF6aAsj8sspnXOCFuQBADyCjdANNyKdrKEefYEp
o3GakYf0BBARXRwrjjYA4Cg4oVimLjSptNgo1vbL8LtWlP+8cvGC826DL5/X61/1
M0L/zKcigUw2gZMcO8UB6YCc6n7hC5TPOThprEAk1NYMlP7Iv0fSrJ8HOguO2sm4
B846hqJQy/fCKeHtcQwMEluEiWD2ZgFnwnpRLujPqnRVpbzeIeWa0/8EXKwe77mj
2GiZjLpiGUu1GEMjFK91HX3uLM3A8A9eUNK0pN4Pn3s9aZCWAQC9D5sCioSTefOV
fmOlzKUJcgEu/Ul9dcMlMYEFTO4bmxTUOXjW/HKAZtJch3atiF7wNe5VfhwRysKQ
LwidRpDUCQ71fLO/5+IBpbC/6RNajw9PBlG1GN1Y2H81z72y9cXVukFV1SD1UAhM
vsx7AGpGV+88F0l3STHb
=KK1W
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
