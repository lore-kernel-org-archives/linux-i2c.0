From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Sat, 7 Mar 2015 01:24:48 +0100
Message-ID: <20150307002447.GE993@katana>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
 <54F5E120.3090705@alitech.com>
 <1425400650.17965.53.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425400650.17965.53.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org" <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Presented like this I wonder if this merits being a dev_err at all.
> > Wouldn't dev_dbg be more adequate? This might remove the need for the
> > condition and also avoid bothering everyone if something in the platform
> > device structures or device tree is not right.
> >=20
> > >  		return irq; /* -ENXIO */
> > >  	}
>=20
> We've just had similar discussion related to DW APB UART with Andy here
> https://lkml.org/lkml/2015/3/3/412
>=20
> So yes probably we may safely remove error message from here completely.

So, do you want to send a V2?

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+kVPAAoJEBQN5MwUoCm2sWIP/iWM0t69eEDBUU2nD0ZMczax
NPMZyhgd872046PL/32QAGQBgg86bw85Qrm8urit507N7vqfl37MBAxBXgpmAfEs
Mpff22GjR0/8qz18TbLMzNAAi90a0GtkgDf/7kW791HWJEkw17+sQvHYXnzvQkg2
LARzRVAM2S4ewHJLT4FgyVxomcR/Al9RR+zmXk/DgaFsuqyQepKYhxrPKeIG9cdq
Mv068ZAL3fIW0pRWvU1QBrRecX6kUooY2MQIKblTaixDeQOGNOLGw3zDBRInXvqn
3uJqKaYO3dNWdQk08DJmxjMnDm69iwAIb2QRokmvSEosqUSLiqYxcHbhLccXqPxh
nEHgGLJqAri6m5k8uPifBx6UHi1Hczf/GyaTtod/jZ9Tdckittai6khDmuhW1QFF
VzzdXpUO41F6l+2WAR6Hl4zM+Gzo+3DkzQ6EThEzK2mBYQONrHK1k+unAh6YGNZB
A3waPVC9I+4GfvfGqZyhBx0wdwAqTOtMuoF6i/9eqAiLbQAvYacjrHfi4Gh0v3Ox
3e/IoElSSNHCuG05yWqo/eOWcE91iUoLS4hYtNOfUj6dfmi7SyGyhU7qmrl87MZc
q60nJI99I6V6e50rWLtNd+RN15rA9XOrouc6dzzHned5mlsl2TOxdzkNZyZ0Y5QO
qpN4Mt2uSpYr51kEE62Q
=sMwx
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
