From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Tue, 25 Mar 2014 10:11:48 +0100
Message-ID: <20140325091148.GA2570@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
 <20140325090700.GL23076@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140325090700.GL23076-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 10:07:00AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > And checkpatch said:
> >=20
> > WARNING: braces {} are not necessary for any arm of this statement
> > #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> > +		if (cur_msg->flags & I2C_M_RD) {
> > ...
> hmm the whole block reads:
>=20
>         case REG_STATE_STATE_DATA:
>                 if (cur_msg->flags & I2C_M_RD) {
>                         efm32_i2c_recv_next_byte(ddata);
>                 } else {
>                         /* wait for Ack or Nack of slave */
>                 }
>                 break;
>=20
> so just removing the braces does the wrong thing. Is this a false
> positive checkpatch warning? Andy? Joe?
>=20
> I can make it:
>=20
> 		if (cur_msg->flags & I2C_M_RD)
> 			efm32_i2c_recv_next_byte(ddata);
> 		/* in the write case wait for Ack or Nack of slave */
>=20
> but I consider the version above more readable.

Well, OK, I let you decide.


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMUhTAAoJEBQN5MwUoCm2rWAP/jHQNiZPJlKjUw1dGXWjED/t
ixTOR3adpnWeVctj/Q6iAcCfNMN6v4iUoONov4vqwmdASrcIBdWsNSh2t1dLTlhF
PqHfM1Eip/LeiUV7k/8GPgyYXavvJuXbRwVBp6RTRi++V3OVfBixiiBrn+xwBUzS
QLrBdRcDaIBOBeOgUOWWk54KnLG52ki1W1uuxHhfW9H0BwDEpZfrcRVosN6gSnXU
AqjdA5vAW69hw75a8e3psU1+qNo51v/8Hc9uJSw9bIvU+ELEuHoCkGfNomSkQHlU
G3hetPUN7/7MUWsuIFSmTZI4EH4YagHHDD0XIAtBdYOLlDRwcslmvvjquWK69Muj
//a+S82oXRfJJMyRnR9TDJ2yLV20GIKQ3z1zDzp20do+c8hi3kczv0yiK80D1L0O
fVsKj0fuOmOVU886e9vwR4xgaEdXeRlKfOdrQn0eKyeodXOPZVjJMVmiLagDgdnb
MFy5+WaS5gk0Ue6KrIIjN7kDr2q9fQMJRIILySEhXyC0L0TmTfxzIgJETQwpMmeq
fKYK8SWM5fmI0DJ3HPUFfYPXHTqZ/9uLVgRjaHnDKjcOSFeTDitEhz7DUo0MbLuS
TJ3JlwrnAH5MgcoloJSi3Z3kaXMw6WYH2OpZ/FoLFFY8OrnbtjLXskWdQmXFEDFb
uOeSZ8tqzimFKxrRBz1W
=LTk4
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
