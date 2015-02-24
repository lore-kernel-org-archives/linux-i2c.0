From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Date: Tue, 24 Feb 2015 17:04:46 +0100
Message-ID: <20150224160446.GB19444@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
 <20150119150514.GB3820@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150119150514.GB3820@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 04:05:15PM +0100, Wolfram Sang wrote:
>=20
> > > +	struct i2c_adapter_quirks *quirks;
> > >  };
> > >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> > > =20
> >=20
> > I suggest to add const.
> > 	const struct i2c_adapter_quirks *quirks;
> >=20
> > also, in i2c-core.c, should modify:
> > 	const struct i2c_adapter_quirks *q =3D adap->quirks;
>=20
> Thanks, I'll think about it.

And added it...


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7KEeAAoJEBQN5MwUoCm2jRYQAITq2tQyrAoIW8anKxRI8hOl
dpQG58/aM6kUwQVPbU3OJVTN+///VI2KPqKDg6rbTVDCePMKgyCr/kYCCfOxJbkr
xSUR9csPjPmsJn2ZeQW2VE1OoOBQeC27rOj4qpZ3qJu9Fc9vNi+8Ze64OStsLEw4
P+ZEAunCNvAhU777LBsU/MuAeKZTNvV6bKwOMR3nxfedMQt9zBMFPGYi2C78N5T/
gb/j4W+QVnoDQrvebUeWlbZeKIDgQgP/ychMHFAQ2QKLlRIuCIFFjg2jWYkRUK1I
qm4zuCji8pKs0StD3xrZpOb5MndO6EEjm8xyTbgtCmMwE81FdUwORmuauyeULjzH
ArNxETpZI2YYhtmtkiynfWPXMv/s62gAP+wLt28o7f1IIpJPMryQedYmIxHmIskq
CeBsqwlYUSIyiFoGVkWsC7AkcEoRcpDkSVdHtkVN+o2LjDxwGengcb7MdXNgt/xJ
j1eqZ7d1XQ3DzHMNvYfEwDE8gZPnzx3cIo/7aqfXSl8gx1hT+FvjSSHpZcvf1zqb
OihC3ZEQdsgreaP1qhSJriv3EAdZvhTlY2YOsKxjPONtDYpObSgoBpM1gXZCLfuf
ysRev2E8GhzoB5QFIAmJYbhRE5lJ9IXRKovz8wg+lO55tP0lJCYJPXtUIFhjgH21
nxtKytmO2wMfl25NQ2KZ
=dDPf
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
