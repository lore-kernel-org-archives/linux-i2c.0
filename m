From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Mon, 18 May 2009 13:04:49 +0200
Message-ID: <20090518110449.GB812@pengutronix.de>
References: <4A0BD1DB.4090305@doredevelopment.dk> <20090514083453.GB3043@pengutronix.de> <4A0BDAD6.5020005@doredevelopment.dk> <OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se> <d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com> <OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se> <d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com> <OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795@transmode.se> <d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d2b9ea600905150552u6951a92es5dd119dcc37e641d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could we go forward with my initial patch, and then continue the work
> on this repeated START approach for future releases?

Then could you please send another version of your patch with the CodingSty=
le
issue removed and an updated description what this patch fixes and what sti=
ll
needs to be resolved?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoRQNEACgkQD27XaX1/VRs2mwCfb+jtW2eqxoukpI/2Ic9PiaSy
r5MAniPKpdOqvYfoZ+inYXbUvI68QtGl
=PdJ5
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
