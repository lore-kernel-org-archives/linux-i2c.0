From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Sat, 21 Mar 2015 22:00:29 +0100
Message-ID: <20150321210028.GA1078@katana>
References: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana> <550B3725.10209@gmail.com>
 <20150320101925.GC2071@katana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5625793640885012560=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150320101925.GC2071@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Gabriel Dobato <dobatog@gmail.com>, linux-i2c@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5625793640885012560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I guess what you want to have is that i2c_add_adapter() is not called
> > for the disabled case, right?
>=20
> I think that makes sense.

But maybe we should just start simple and keep calling i2c_add_adapter()
for the disabled case. We will just skip probing devices on the bus.
Would that help the issue you were originally trying to solve?



--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJVDdvsAAoJEBQN5MwUoCm2s3gP9jHTKZBAwrIU/8xNnSbGSN90
C1Vlk4gbLWGfrFDrh5WGDQYbz999exus6CfVSukbGa6OJ2Ec5rhX9+npub//wr2X
/fDGZLukaqGFjgsxv+c8SWtp/gcDpZdIahYH1FrPBsh+sj7aMUoUQXMWHVt+8N6k
TN0pZuDguOuoZHVZQEqMHBzTyHbN+YnDr2ADD48Dq03d06ZfAijxUj7geRuwxIeD
W2+RQcANNc0cZX5QXOI3rDqAKg6CksiJ4nAZlw82IfbcKD8xHI9RMELgrIfeE4KA
gwKip0xQFyJH+FW6ji9mcPYmVZg4E73UAfUj85zkSrYbUimH13tni/CXqQfJF7Vu
mWPJThojP9el0ZzANPMvKRWFNE+KdqyRZxauak1J/sh0VL9p4nme1at7YAXzXtR8
Jx6rjvPCz2mGk512XGkZbSukn1Eoe/0F9wHIq3OCDqrlDOZJcyeb2kNz0O/YrRJX
ED4fzEOKhCFbtXfk3sYwypZJLaLeD2aU+X+ELl09Zfz9OkrzLb5fQCp3DEKJ+z78
Xagha9ju81jsK2EC+r6drLXAn2wIT0caTTHVpuUqSa8hRiYRa6qMUVY6y11ZhuRL
LTF/fA7zKjGNN//VDVSYi4PxymQcvY4Nw9dMaigVkpwxIWZfLuC7O1m6iXoZaxS5
QEXiKrmNNjuH78RtEP0=
=fgG8
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


--===============5625793640885012560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5625793640885012560==--
