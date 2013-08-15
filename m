From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-tiny-usb: do not use stack as URB transfer_buffer
Date: Thu, 15 Aug 2013 19:55:50 +0200
Message-ID: <20130815175550.GA5934@katana>
References: <20130806111742.25265.94046.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130806111742.25265.94046.stgit-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 02:17:42PM +0300, Jussi Kivilinna wrote:
> Patch fixes i2c-tiny-usb not to use stack as URB transfer_buffer. URB buf=
fers
> need to be DMA-able, which stack is not.
>=20
> Patch is only compile tested.
>=20
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>

Looks OK to me. Till, are you there?


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDRYmAAoJEBQN5MwUoCm2/pAP/1j8As96YQ39VGHZlf6vjv3I
MMpaWfpixtND/JVIJkCzEIjiuSM4WJ1tXUGfkvZCgPPzWjrKlfs4EM5eo2XfTvd4
AAEALH5s5XwVlwhHeQIL04lCzijf0/E868bb2FvREi/++q1XxrByRmQn9Qtfk5X/
Fj/sxO2vyd4fVq+Sig0qUO/8Ayr1uibu2R0Qlrrmo8G1QvQa49E56tPvvZtukA2P
h6kJ67R6THoME8BaT9z/YOMqO4VfB0wUvYksxwZBlG2jEwK2C2xyzqIg4vcMjPwK
bObgcG26Zvh/HaoFyZAWDwFCH/B7X1j/fMCN9388lZ3zsAxq/q9v9uOnxSkz142c
T5t46p7c/nNNHKxwXCjBk/kdkRrNBAhFPi7eGfwO0JJEFiQNNCyJTBEf3xkRrAIt
iooPmjAjp87kO3eXv3Iylx+cVRS1wxDXzwO9K7AxnoJBytgs3txNXBA8bBmb1g+G
KXtwvg3bMxes1kFNQV5rfioF9aoqrZCETs6BYibrt2PIkYMhn21tIlTNlUSnnem2
DR86s91dL/10dJJC3hGm+8aATUThxlR89Qea1bidPFi2l01v/F5DS/s0yzTcZWGv
2nK0Rc45X/cT7QhKqQGgaZejoDZ6dMJojcbaeXxOk4xTSaZylT4tGav38d/LUBPf
D3vw1o15eNHaDbVQksRU
=c5EO
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
