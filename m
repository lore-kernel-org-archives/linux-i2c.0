From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
Date: Thu, 24 Oct 2019 20:55:40 +0200
Message-ID: <20191024185540.GF1870@kunai>
References: <1569825869-30640-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7152735402345194131=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1569825869-30640-1-git-send-email-rayagonda.kokatanur@broadcom.com>
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


--===============7152735402345194131==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 12:14:29PM +0530, Rayagonda Kokatanur wrote:
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

Patch looks good but doesn't apply for me on top of v5.4-rc4? What was
your base?

Also, I will apply it to for-next (v5.5). If you want it for v5.4, then
please add a Fixes tag.


--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2x86sACgkQFA3kzBSg
KbbPMA/8CufaNQxLVkDpAOG3fBebE+n7XkatUJvoVOe+joL7ZdVIR+d1CqXEDZf3
zXuUk/02btaiw9vRkmpUwHOjOT08mF9OWWO6XRxvEdvEStfOsejFmcvUtdnuMMXA
9nX2xp2/KjB83qdFcne9KePbHvOCNLMLCl6GQbc3Ko/jQMTHQqRijkwxTBUhsILn
Njq6taaiiedlHX6/o4vEl1gOPtmxqhXghU2TyOzmIG9fyjssatn+41ri1K0QseG+
1VkMixa074wbtqDp44AypbpuenSYxR4AKfGgQPnPx7b3RpJxhH8bXwEVLxGdSJJh
Sfw+MrGfVouOKQZIGd6IKraa+Zh8AleMvT/l/qf2vwQKfKqMEQ8ehmtVPJwPf/XM
7XMPQeYFu9Leo/3a/KsLUTC31isIeosP/hB+ZOZSKGTWnyw3XD6DYNtJwFSbpQh5
shjRb0GHCwaBRsKJnuX9lsY2tfHdbN4qzGMh2Imctfk3Shy37eeovhsY6QhhiiNl
TR4TnOHx2DwRwgzm921MjLGomJ9w/t4KlczdyJAV+GMC9k4dcShxzdu1/4s8TpHM
fx9/MIqdbc5ZN/xroaO8xyJeHPhNJy80UJ4gXriji8/IsV1dhtwwHvIrRS6QqSTj
DxcC4PpAU+JAu4Z+ny9Q6TVdcY46NyHdgW7hyl+Q+llMHx25gO0=
=rr6Y
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--


--===============7152735402345194131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7152735402345194131==--
