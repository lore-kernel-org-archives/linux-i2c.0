From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c-parport: use new parport device model
Date: Wed, 20 May 2015 19:35:17 +0200
Message-ID: <20150520173516.GA1615@katana>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150520154907.GB2001@katana>
 <20150520171452.GA9069@sudip-PC>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150520171452.GA9069@sudip-PC>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tim Waugh <tim-xbtOLCSHb9Lk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >  static struct parport_driver i2c_parport_driver =3D {
> > > -	.name	=3D "i2c-parport",
> > > -	.attach	=3D i2c_parport_attach,
> > > -	.detach	=3D i2c_parport_detach,
> > > +	.name		=3D "i2c-parport",
> > > +	.match_port	=3D i2c_parport_attach,
> > > +	.detach		=3D i2c_parport_detach,
> > > +	.devmodel	=3D true,
> >=20
> > Minor nit: I prefer to not use tabs but a single space after the struct
> > member names. Less hazzle in the future and still readable IMO.
> It was having space originally. I changed that into tab as it was
> looking good with them as aligned.
> I will wait today for some more review and send v2 tomorrow with this
> chanage.

Thanks. Just to make sure: Keep it one space only, no alignment.


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVXMXUAAoJEBQN5MwUoCm2LAkQAI3GD0CiKe4g10DwxbK1rY56
67IGo5eZYiaSotv4nxU1esXo/D4sAlX7ekBIJo9B7/86TmP6CZqiOfkPziT7jshn
3XYc/v2sYixyNBr3c6cLtfmaQuUTgxTHcEwgoBo07DV5cuSFsLvrNympRyGmuTJC
+mehzBVGLUXFHyHODehx8bRNkZrFs8boKEJvFHG/VCJpOeSyVkcJdJk1cPYDJ+VP
i0XXqYDiX58pbaO6gf5iM0VyVyuEtnarCvE3uYzJMarRL8OfxYvP0T+V5Ur+PMGk
ocUSewuexL9Rt0nxaDQePCrpMB6MBffgTymTbZ7CmNtKTJEyUAFwAHPZsHBWE7hI
PhNbBuddrht+UiVG2eKjz84CltqIcCMvJ4Oh9vbR7IEhh3d92XZ/f4z1GXZ6qH9+
O+e3JH2iXtDLR7MlTh46Y14Oomwpgu45HSaBTwDUBZxpvhuxY5A++igitXXBlOXG
1pwPrhaGFvF4PjIyq9zZcBZEJShmeeVfvshz4yi+o8yGdt5Oa/z8k1PZN3kURCqA
+FvKdbAWGJraYXoS5ko9Vo2z4Znk4Gm7hmIXZodvfbY2D+O8OMvHDOmEB/T7cOzz
NpJnzogfAbc06/vyhOYpsfungWoO9F3Rv6vHA6lQpM53OArPLB7uqRgDC14ONs+J
w5Sbm6pW8r3Sk7EztQIO
=kLCe
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
