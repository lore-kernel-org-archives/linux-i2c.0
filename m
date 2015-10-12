From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: return probe deferred status on dev_pm_domain_attach
Date: Mon, 12 Oct 2015 20:40:43 +0100
Message-ID: <20151012194042.GA1710@katana>
References: <1444563571-12247-1-git-send-email-kieranbingham@gmail.com>
 <20151012072312.GB1477@katana>
 <20151012072422.GC1477@katana>
 <CAB3z_RoFmMGQZKXnt3DTXaZSkZBVvGj59mB6pR+hAs2PxT8fLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB3z_RoFmMGQZKXnt3DTXaZSkZBVvGj59mB6pR+hAs2PxT8fLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Should I add Cc: stable? or are they notified from the Fixes: tag?

My preference is: I'll add stable when I commit to my tree. I am happy
if people tell me when they think this should be done.

In this case, it should :)


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHAy6AAoJEBQN5MwUoCm2sg8QAIWwy330OvAWOq1dH9VQEx+e
nlPdBhLEh7t4X8iPraTaz1H45137KlCOPgy5HGJLoNwb1s2Nv3TU9LPIoQfpCzSA
1xGZSvnIijzGw94Tgz/9AlOLk7pZ5DZb3eh4ubTmOSjX3R8g1/0UDwHMs3SUv6Rl
h2yE4rwgb3MisJVchx5Fn8PzU0Zq4g0hepuzCd9GD6H2tj0LMnqGHHmaqt43oNi1
1HBte+vjQy5cIAux+IW2rewk9sfyVrFFrqIo3A01v7q9aMoYC/EQQw9Itzg86C+Q
hkp9Agif8DyMihl47v2HQU9lbXGV0xucts1OOIVtwNSyM1vmINF5zuTuIhBqH5xq
ROTBwrPAbS70ENBAOXRaVvMgXPpcWi3sab5O9M8HTShE1JSH8i/TZYgNFHOE1TIv
UYzxeCbmPacrsj4IoAUVAqB2k3TZ8l9+cdxJhYMB4HYXH2wuNpOiEJXGQ7dr2nNl
urvAG/qrh7yc3neTR775GxNu4uBeUNzeZLqSrX8pqfiLuEFV/0qDkZN75nX9VrVw
0fhNer1hiC+s6RwY3dZYARGpV00LtqQkkp87V1LpKhx/YxJU4gkOL+Lyj8oUTY/C
NDN9a4DTejvFAqOFLbSepcaTDGInlAicxAeuuGPYI8IUjkV4YkMyadGVVkJUQvwI
zLCsTInQXw3nauQcHWHU
=9d5j
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
