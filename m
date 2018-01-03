From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: mediatek: Enable i2c module clock before i2c
 registers access.
Date: Thu, 4 Jan 2018 00:55:58 +0100
Message-ID: <20180103235558.z24e6c6vq6ctlpd4@ninjato>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-4-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3b4mt2ovwge4s2gy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513666263-6443-4-git-send-email-jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3b4mt2ovwge4s2gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 02:51:03PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>=20
> Make sure i2c module clock has been enabled before i2c registers
> access.
>=20
> Signed-off-by: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Applied to for-next, thanks!


--3b4mt2ovwge4s2gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpNbY4ACgkQFA3kzBSg
KbaGfQ//XI/e+5wxRP/lJVv3EpPOmOJh7iusj1S8k7yuoDxbCR5RLza1Ovub/Phu
wUifVfnGFixvzc3OgrnzoKbRORxPjmmHqmKq/mK7L/XkTo9irVxmH+SGOXR0mzhR
PpJrHxfmkl/F4/1x82BAfJdpvlrx82RW4XTeYj0WFMsoVAgrWl4eAdGekqcD8jaY
5RGLK2OtoMznE7LNuWojaryit7LMjRIVLHtjXU+EEGVHmac4aLm9iHzgQbQDL+hR
ZeKOcHy8Z0qiRUFJXW4INLNDrFd9n12RjrWdlCumbFUar5bxpE3lpvCF5z8fM3qT
sVM/HKtggbQsVQ66dyolljeK3wMM20kEz79bXA2EAxvBuzmg0+pYq4IKdQ/E2uo/
VPvbBu/cs0VUivmg6+2UXbZ3iDbmETDi1s4naT6EH/bxIa+AWJNWRBUqIOkZgGbU
Y+7w2qUoNxXqsAcconyd/jNv58Hg1jxgBNVWDPi7stUr2AHDQ0x3XrVPJ6JG2fvW
WqIDliiTfW8ZgQ7VpKVdFbDhSN8/INIKra+U6wuOM/1sMm5bvCrRybBE2GYBehnN
azSvWtiAv7v4rFYR1eiGgF8KdFCDN2FM8H1661mSDxoamUQal4Mjl/f9FMte73KO
cNO5yjBgsyPYUYcjSAts+kB4At9HQJ6pgfi5x9y1NiUYGoHDQ3Y=
=ZFkB
-----END PGP SIGNATURE-----

--3b4mt2ovwge4s2gy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
