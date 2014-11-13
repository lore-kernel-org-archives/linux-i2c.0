From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: dln2: simplify return flow for dln2_i2c_enable
Date: Thu, 13 Nov 2014 17:23:16 +0100
Message-ID: <20141113162315.GC1275@katana>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
 <1415708457-18798-3-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415708457-18798-3-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2014 at 02:20:57PM +0200, Octavian Purdila wrote:
> This fixes the following kbuild test robot warning:
>=20
> >> drivers/i2c/busses/i2c-dln2.c:70:1-4: WARNING: end returns can be simp=
lified if negative or 0 value
>=20
> Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reported-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
>=20
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Lee, I think it is easiest if you simply add it to the branch you have
for this driver. OK?


--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZNrzAAoJEBQN5MwUoCm2hYEQAK8Vl1LSgOEumr0m0S/r9LAq
wKhjfG3+GePjKw0hubynlOIQd1tlEcK5bnnKLeCHY3KTmEMc93RqvMCOLFQrhjVN
rM+dameOLR8gUqPo7qoC/XyNq2Buk18hUGowu2mvqAjtNykj8J7oOucY7gl0E2jf
VwIMfQfZ6Oks0xY5BwnBo/VgAgEXGezYyX1rcyiBYGKNzZGhW2G+AqkCxk0DyFvY
pwO0pTQZ40KtXSK/tVl/UGcHGn6KWeIwB4gvwl8+HGbZt14rDaAFhYLlHoqThbv0
8cAptEJ1yB7ECeZX/5beu3xP6I3whY89bqKKsQLSiI/6Vr3ay0w4TRWh/v+Yo7Nj
C9ivrjzTnxU3s5fqFRisU0N24IQmpGZ+UUQbedfr+pikc14ShpmXGfaRgrpoXAXA
t7tJuplzGCiK5stW5SAOW5cLsAuuNpUbQ1TUBVe5t14FVp2U7gO27jnpn3PpCKkO
vNVvuolmrIgqiAkKpYO3UW5EEurP6wWQCuWVr/AHA9rQEDKpNMsvifiaGvF7XcIx
aPnNvXjmggRCtmX2vRtjXKwr93Xh4Fd0vs2dl+yuHpV9XBYgzwqlmstY6njp8InD
Wm7OvSanc3BhQJtlljE10fGoXRJJw/aPkUWph6hd//7rsT6B6OyqlNx6lRj4BIPz
ZM0CNRexB4QzGjID8JvB
=gM3i
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
