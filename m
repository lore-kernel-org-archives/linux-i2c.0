From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Fix typo in ioctl name reference
Date: Thu, 10 Sep 2015 20:00:12 +0200
Message-ID: <20150910180012.GA2893@katana>
References: <20150908110549.411e99a8@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150908110549.411e99a8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2015 at 11:05:49AM +0200, Jean Delvare wrote:
> The ioctl is named I2C_RDWR for "I2C read/write". But references to it
> were misspelled "rdrw". Fix them.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Wow! Amazing how long this went unnoticed/unfixed.

> -#define  I2C_RDRW_IOCTL_MAX_MSGS	42
> +#define  I2C_RDWR_IOCTL_MAX_MSGS	42
> +/* Originally defined with a typo, keep if for now for compatibility */

I would drop the 'for now' and keep it forever. A define doesn't hurt
and if it increases backwards compatibility, why not? I will also do
s/if/it/. No need to resend.

> +#define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS

Thanks!


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV8cUsAAoJEBQN5MwUoCm25bUP/iIpO6owEzvlOFro5vhWwfzc
c/YkLi1i1E09nkW4bCMoTnpLesp0F2JH1rYIPXhNaRIRC9VLNOIfET9WmIn3WeBH
ipYC7V5QMHBt4YGExXkYxM1vHyDfctu+vEIlbBEGfMNG1aD4HsUtcuvmTt4d5RR1
Th0TrPv0g7Mc5/QeU7fQYeGuUNRqnkdvp17c+/qYJ2OXgcgGBXBvvqJVx/HIYp9p
Udbive0w35TQ5qn7hnDHgAViqt7/Cs2nU6htPTQvzx4dZ1gkoQsthMrckSYP6iZN
CToIqioLTn495zjEw1KySXxgOQ6OAHnjxTpV/9Wg/yObdUdaB9sg4mpRRKrwKnVH
/kZvzEATPJS+wDv0oS5267tsyl1yazqPpBSoplFCaCxbSPiVpCP5xKvUzzpUnCYp
UTiXVSDeQSPoa3GLAZlFOcFqnDOIlFwjyx79QZ/eXYEAKKYd75ziQ2eqFHBTT2oZ
uKCYYmWNGwfKBq8OidpvEojDZI5joD/LhJxVfy0jHfzi9FZPNaL7+xgVUfqHP42B
/cqWRowygxgzRvWc+x85OD/s5zCsA6kSg5lG8w0P+FBW6oPBXHI11WsWUuosNffp
VN55EKH9HGxt2zkqQLKGEuNrMSD5P733cUawgbqTgxz+jYysWiZ8JKLQtOoYy9Q0
E76sSIHPcxlPKxBJM4av
=d4II
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
