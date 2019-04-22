From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in
 devm_kzalloc()
Date: Mon, 22 Apr 2019 09:20:31 +0200
Message-ID: <20190422072031.GA1005@kunai>
References: <20190104174327.GA30932@embeddedor>
 <20190104180612.GE3009@kunai>
 <d7950904-23ee-98e2-9a55-77e7cb802e0d@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7950904-23ee-98e2-9a55-77e7cb802e0d@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2019 at 06:15:21PM +0000, Peter Rosin wrote:
> On 2019-01-04 19:06, Wolfram Sang wrote:
> >=20
> >> Instead of leaving these open-coded and prone to type mistakes, we can
> >> now use the new struct_size() helper:
> >=20
> > I am okay with this patch in general. However, I think the name of the
> > helper 'struct_size' is a bit unfortunate. I really wondered on the
> > first read why it needs 3 arguments to find out a struct size. I only
> > understood on the second read. I think 'trailing_array_struct_size'
> > would be way more clearer what it does.
>=20
> I read that as an Acked-by... :-)

For this patch, yes. Thanks!


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly9azsACgkQFA3kzBSg
KbZIrxAAqRI/lLE1BL3c3a5BTNhbBG4FbJuZWSOsVq+RMKxeHoBBes+os1ttWfRf
Crrf9IgmnmsW6yvJAvDmBm14mBx2ZUw98o5LYAnZqmuA0uMqtMDEHBDkDqYnN+cw
78o8WiTbjmC481JdoQCgmsrs1KhyqxCiEV8NnsQlDshCKSbU9xWJM+lR/O6oRt3G
kAI58FqIlSMf76Lhwx7PVio0Gxf2xXVCGkugAOCQwC6+7PgquoUGRh/hryh8bdIb
P2wq4XDu0B377vpAKxysAzDXtVuB0T1qn8xk2ndYv2jh2Rj+sNd7aeAgybBt1z42
qkpKuIDUqiueZkSBAeqns2ybKh5rCAPfzrnHVcsCIM88SxtzdU5kpiMyO2/+Kvm9
B2onHNBwANh1Grzk3UHYIkZAI6zqb3tBK8aOtAHeQnB2mI1GYjfKxAHbhyrRIe75
RSfWfAldOxof6iPU+ezMD1zmQHwZEZDGp9FYVx+P9CbuuDehiiGzVl4txYCntOaJ
9RqwXpLZHwfFc/lftPZeEfp1X09rzxhWWmsdPNgdc4JmmnZL/wEm//kuXHkXnPmw
7mp2TfvPjag8ZfPka0wjRREGLX3iL2u2D3FN72GuxyvpTR9MMeWoVP1smNDo17yL
WFu0eFx10Fun8+M2sS7VdYuw9SeNK5LYsn3sVfucUg0sVpjfTwk=
=SM1N
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
