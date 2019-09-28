From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
Date: Sat, 28 Sep 2019 20:23:43 +0200
Message-ID: <20190928181910.GB12219@kunai>
References: <1569472808-15284-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8185875550141010931=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1569472808-15284-1-git-send-email-rayagonda.kokatanur@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Lori Hikichi <lori.hikichi@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Icarus Chau <icarus.chau@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Michael Cheng <ccheng@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============8185875550141010931==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 10:10:08AM +0530, Rayagonda Kokatanur wrote:
> From: Lori Hikichi <lori.hikichi@broadcom.com>
>=20
> Enable handling of i2c repeated start. The current code
> handles a multi msg i2c transfer as separate i2c bus
> transactions. This change will now handle this case
> using the i2c repeated start protocol. The number of msgs
> in a transfer is limited to two, and must be a write
> followed by a read.
>=20
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Icarus Chau <icarus.chau@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Shivaraj Shetty <sshetty1@broadcom.com>
> ---
> changes from v1:
>  - Address code review comment from Wolfram Sang

No, sorry, this is not a proper changelog. I review so many patches, I
can't recall what I suggested to do for every patch. Please describe
what changes you actually made. It is also better when digging through
mail archives.


--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2PpSwACgkQFA3kzBSg
KbadWBAAsEsPbvgqUxIfN2/lLOcJlf8l/MNqDio3L5sdrExhkEckEd879vd65rgh
rw+dKI3vJMG2SDDa32bM0HZrqLLEhOa0aQQr0KFQeO3mPA/drLlz/9djjJOJNeE3
EorXS2QIIKzWZDXF7MSbQ2d60fXUmKEEwm0K+uHO+bzyrlh7WPeri2k4DNnYRmDn
uLqggb4V1mmXpZ24npue0GYXJY8hyIWbWtXXHFFJHvBa3ngZIb3n7xrgBsFbCvdN
u3xjTT/DVgQf/RyVY/Fz7CNBkdqRm4jHTl+4wWC3EsULkV1fsOwS62JQynmfc99u
AJJYoUGUtaDKAqVdwOfzfnUdQD5v7hkLVZfMKtNZum84+JLXwMC6RdvIhvoaBTSt
6MpQtFufIcHHovxFUfg9vpU+qZNOpDEaQO6Aw+gzax1zi6qUvgW4TE4Ow8vfvmYP
xYkERkVaSL7BtyPsLQkRwW3AeT50kA0ZbuzUZf4/0yKBCKmSy4BdA7tin8AbvIQS
z8+IluQjP2lKJIdZPMEH/R7X8gr+pcHRsaF/Bp/SLcU0+TADW4nCUmLiyxsO9Mba
Kr0WHFtoITKyHkXgE+cTSFpHQsZPAF2jqacyN6TblPIFYo6RAjJ+KsWaY52gFY4M
lVjKa3uSSS3hCwwA3gHzr7bMFpghhOTdIipU+zefg00lPxyVYEg=
=9s1s
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--


--===============8185875550141010931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8185875550141010931==--
