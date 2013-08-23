From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
Date: Fri, 23 Aug 2013 20:11:44 +0200
Message-ID: <20130823181143.GA3037@katana>
References: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
 <20130823170411.GE7015@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6677006213257552540=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130823170411.GE7015@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Nadav Haklai <nadavh@marvell.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <Leif.Lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, "jcm@redhat.com" <jcm@redhat.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, vanhoof@canonical
List-Id: linux-i2c@vger.kernel.org


--===============6677006213257552540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > +	i2c@11000 {
> > +		compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>                                          ^ That '8' shouldn't be there.

Oops, well, precisely the '8' is missing above. Fixed it, thanks!


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSF6XfAAoJEBQN5MwUoCm2rA0P/2vNeFSvpPCm/Z3+SGmCAM7L
njp8dAQrlQ6srCgqy/eyrFh+bpM/brU8oVMDEKCrk2vtV3TBjUq/5cFqDmKcgJ+h
95+3fm1VL7Ns/zjyA2wG2OSir3n7LS4HxD5OtOXSZ1ejZ1Fl8YkIGjc1VA+t+ZX5
DW5XyJYFESHalJks7K2RZaGLay45B6k/YBn5hIelmsMFbxg3gHKWmuiZDJBzWrpW
TK5jEOI1wlh17qb29shaFcy4E17o6/GukKQ2BENJWYoqiXPrltNCqbdZjyVenNAM
DRQ9ROAt13nWC54LVeESfFtbpIcWPl7coLQ1mddu1rmNWoMqMphLf27MvMumzPLb
0+1mEJ0Apc2ATv1CN7rVjgjHc9VpPp5KQ0dGo+R1pIXZIcOyXhG6QTZNtzJXt7bG
Ozk8YjTEB4QqLpet468ydpmifMHz/14kbVTmfO5+Ipc1AxT2CKMSzNA+TBp2rGeU
5asR+kpAvEuFeUMBrQFEgsPLh6by+AsacRYJYM+iJsRHo1QnMwZFkrH4CeB8Hapq
WdrHP/zo24Q4UWTKdRG49F85Oo1dOuHaiBgs2+i5GzKBdbeCIxnMgyVP+4cmsrpW
SgUM+DJGVuCd4iihKPBnfbCGBtBUgnCApH97K3zS43g60y9n+IQS80j55vpTG169
FGb7XpQYvj/7fkv7YFFE
=auqn
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


--===============6677006213257552540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6677006213257552540==--
