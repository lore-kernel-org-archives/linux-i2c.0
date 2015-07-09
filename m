From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 6/9] i2c: xiic: Add a debug msg in case of timeout
Date: Thu, 9 Jul 2015 19:29:42 +0200
Message-ID: <20150709172942.GC4744@katana>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
 <1434554299-23443-7-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434554299-23443-7-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 08:48:16PM +0530, Shubhrajyoti Datta wrote:
> Currently we return silently upon a timeout.
> Adding an error message to aid debugability. Not
>  a functional change.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

I am not in favour of this. In case of a stalled bus, this can easily
flood the logs. If it is for debugging, it should also be dev_dbg. And
then, it probably can also be added when needed. I mean the errno is
quite descriptive, no?

> ---
>  drivers/i2c/busses/i2c-xiic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index a83f300..66c571e 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -692,6 +692,7 @@ static int xiic_xfer(struct i2c_adapter *adap, struct=
 i2c_msg *msgs, int num)
>  		i2c->tx_msg =3D NULL;
>  		i2c->rx_msg =3D NULL;
>  		i2c->nmsgs =3D 0;
> +		dev_err(adap->dev.parent, "Controller timed out\n");
>  		return -ETIMEDOUT;
>  	}
>  }
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnq+GAAoJEBQN5MwUoCm2XUYP/j+fiOXDqPSqKJAX4GD+FFFx
tY3cQIQ4kc0j1tsoIPx15iIdGEuNrbItS6vmt2dq1Q4GylAFN3AvKty2CR6my497
1F9dw2y0TVtLc95m9BVUm6dM8LNPPdMA7BbG+ZfKX2e1f0XWQ4MB38cJf3LDsbx2
9URbS35Xlku7fhzPMT0bsBxBJBOegOSd6HftvUjGN/dEqT6Q+OiScjcKp/ymVsis
DqBAjwcZ6sOUn1TuIDbG1PzLnmUyzaPdP4fCNhxqET0xrgU/lWT+Cq7FdilG1czu
Lt4L7bPyWDy2/PR/BIhFc2fo/z1cYrjyqPTfX/fn8F1w/g3B2C4uB893z8lzioCz
9rfdtV803ELkLDpcuEmIbtad6zD/nbg0D2/viN74LlMMFjRoYx+yPCM6iNxJ4Bw/
JTZYVjCY8rnjGCm38zo31zJ01lzecOty9y2VRK7aaRf4thQjnBEb99mjDmUGlheb
STZA8SgdEHb7jX+j6hOPQJkiltDFKNNwLB1ipZiul3aPVXTT51FyTx/I8gWTYWYW
v+25jSKUzSSdgRFoKVvYBhq1NUpaBpF8DrTEwCFBEWZXYbAC0oSPX1b197ofKtm8
ySRVeXH4USX+1B9lqfuMAm8zg6jeJAL5GA4SyW88jW2OcMQoiYURIeeomTGMzxuu
24RQBwiDnd5izdaSRZSv
=bnGt
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
