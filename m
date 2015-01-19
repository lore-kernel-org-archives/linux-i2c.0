From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Date: Mon, 19 Jan 2015 16:05:15 +0100
Message-ID: <20150119150514.GB3820@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421387408.9323.10.camel@mtksdaap41>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	struct i2c_adapter_quirks *quirks;
> >  };
> >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> > =20
>=20
> I suggest to add const.
> 	const struct i2c_adapter_quirks *quirks;
>=20
> also, in i2c-core.c, should modify:
> 	const struct i2c_adapter_quirks *q =3D adap->quirks;

Thanks, I'll think about it.


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvR0qAAoJEBQN5MwUoCm2kAQQAIn4NHdQ77C3iBtOkfdr7nta
VM8Ft7w+0genCuj5Gkse3W92uzfmv6l50ffQH5vDEG+20b0dOTJI05peBler8+hK
hFBE7V5lkx/ujwtuWUhn4wMcnWOXGLnIyTxm7MQCo146ORIp4Z3th5/jR0ACSe40
vTAlbm3sAkZvArbjIeLfSiQY3MNhYjYx/0wPp2u9Tyi+TxHs27bj/bS0Q8Z8xgxA
jMjhHZzFvplwoy8x76FglCx1ZPpgWajLgQQtcz/JXOwmXqlc+jTMbVcgbunEh6w3
F5WYGEM6eUVT5dKvTLdBvaxrcbhGU56tXiX1z54J8A6ZyXipji28CT/8QG0xJt8p
R1I20oHhwd+Fz9ZX0Y1KJthj+2ZkvoKiBTIVcNyJt0KnCQUU+DKslUQELsBn3dO+
vD3r7kL/DHLVFtXLSWMASyzkB6ytANOBCmt5elHoKD10ZOZx9oBbMEUXkH/6MNEK
IPJSdGevkCMsPnDiKcEISk+COYyzFHyPYIu4Gahl5SgpytIyCkWVRTCl4HBpW+e3
Gc0u08W59eDmuzzOqfmYga+EPU6Wr3YIrhtAnagtmrhGP4332L3htI/kHSt2uylE
3TP8XymlY/PcAWwWfbH+R0Wv5nBfUsCTtJgNa4KHhqdr3O0tLyKKf6MfjzSCtFN9
dOAm/x3bZqagrE8Cq8Lf
=PK3B
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
