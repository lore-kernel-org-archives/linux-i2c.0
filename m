From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c-parport: start using pr_fmt
Date: Thu, 9 Jul 2015 22:04:05 +0200
Message-ID: <20150709200405.GK4744@katana>
References: <1434632627-18955-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434632627-18955-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434632627-18955-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 06:33:47PM +0530, Sudip Mukherjee wrote:
> Start using pr_fmt and convert all remaining printk to use
> pr_* family of macros.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied to for-next, thanks!

One modification:

>  	adapter =3D kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
>  	if (adapter =3D=3D NULL) {
> -		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
> +		pr_err("Failed to kzalloc\n");

I removed this printout, since we get a dump in this case anyhow.


--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntO0AAoJEBQN5MwUoCm20uUP/0dazZQuREjFK3q6ehyYeJq/
wwK7z9ePPNyy7n7j8W7q+P5gi48OX3dMvGet8j8bsDJZkGmVYUVDYD+3LRwz2inl
E5wofj+HfCbQ6anN7QK3DA6UmOKqpBVicvW94zA3R9Q8w7rrCIOwcrPAeB0jp3La
fMq4nBaPEa3pW8VPA3/Ex3ZdO3mNMuz3UzM/seIYPXmtLHXis+3OaqtCQNIOejAj
DmYKmfzz3Y/7ZjY8EHojkMMqCzVqxFNbGmGdyw+FAZ9xzT1jM4M7zdgmpZCvimAT
b8tRQwrfn0hqVyrI9+5scbu8fLRxgshtcFNXpw4lgQZHI4VFpvydAtENlw5pTeQj
CmACpaKdWOPxin9UEYI3EoUwu6LjhLFXRbcjpXBtk8TXqpvEGw3U0fNk8U5Uw/4a
yzxtiqL+Ptgrbky0z8Xm7zHxsIMM3WNBlw0fptjTnJhjFd9rPe0a6oAzPycaPF6E
+A/0N9Gx+8BOZ+8L7af0nkzL9wGP58xtLuBDircHz7XJ77kuUwbTgAhVUsacBz6n
u6hvRDFHo3DSeizb+N9smQ5dVHL24Iwa/ox6tqeUO7PVQn1DbxIPYViQZIqMSKBL
0S76nsmB2DK0qu5VJygHm7P2UJ7nAbL/Tx2hruJRhCPe2dfhlRlc4d9jWK0wbmx5
ZAc7uYdxwhAv506tyM1W
=4GYc
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--
