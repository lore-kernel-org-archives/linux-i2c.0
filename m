From: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
Subject: Re: [PATCH v6 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 31 Mar 2017 10:31:13 +1030
Message-ID: <1490918473.6823.1.camel@aj.id.au>
References: <20170328051226.21677-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-VM3AeldSdseypz41TxCF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328051226.21677-1-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--=-VM3AeldSdseypz41TxCF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:
> Sorry for the delay, I went on a long vacation prior to receiving feedbac=
k and
> got back in the middle of a hardware bring up that consumed all of my att=
ention
> for an extended period of time. I will try to plan upstream submissions a=
round
> my other responsibilities better in the future.
>=20
> Addressed comments from:
> =C2=A0 - Vladimir in: https://www.spinics.net/lists/linux-i2c/msg27387.ht=
ml
> =C2=A0=C2=A0=C2=A0=C2=A0and: https://www.spinics.net/lists/linux-i2c/msg2=
7386.html
> =C2=A0 - Wolfram in: https://www.spinics.net/lists/linux-i2c/msg27476.htm=
l
> =C2=A0=C2=A0=C2=A0=C2=A0and: https://www.spinics.net/lists/linux-i2c/msg2=
7483.html
>=20
> Changes since previous update:
> =C2=A0 - No longer arbitrarily restrict bus to be slave xor master.
> =C2=A0 - Pulled out "struct aspeed_i2c_controller" as a interrupt control=
ler.
> =C2=A0 - Pulled out slave support into its own commit.
> =C2=A0 - Rewrote code that sets clock divider register because the origin=
al version
> =C2=A0=C2=A0=C2=A0=C2=A0set it incorrectly.
> =C2=A0 - Discovered and fixed issue in implementation that caused certain=
 slave
> =C2=A0=C2=A0=C2=A0=C2=A0devices to misbehave; the cause was that the mast=
er IRQ handler would return
> =C2=A0=C2=A0=C2=A0=C2=A0control to the requesting thread after the last R=
X or TX command was handled
> =C2=A0=C2=A0=C2=A0=C2=A0such that the requesting thread would issue eithe=
r a repeated start or stop.
> =C2=A0=C2=A0=C2=A0=C2=A0This was incorrect because the time taken to comp=
lete the completion was too
> =C2=A0=C2=A0=C2=A0=C2=A0great. I fixed this by rewriting the master IRQ h=
andler so that it now
> =C2=A0=C2=A0=C2=A0=C2=A0manages the entire transaction only returning con=
trol to the requesting
> =C2=A0=C2=A0=C2=A0=C2=A0thread once the entire transaction is complete.
> =C2=A0 - Rewrote the aspeed_i2c_master_irq handler because the old method=
 of
> =C2=A0=C2=A0=C2=A0=C2=A0completing a completion in between restarts was t=
oo slow causing devices to
> =C2=A0=C2=A0=C2=A0=C2=A0misbehave.
> =C2=A0 - Added support for I2C_M_RECV_LEN which I had incorrectly said wa=
s supported
> =C2=A0=C2=A0=C2=A0=C2=A0before.
> =C2=A0 - Addressed other comments from Vladimir.
>=20
> Changes have been tested on the Aspeed 2500 evaluation board, as before, =
and now
> on a real platform with an Aspeed 2520.

Looks like there's going to be another revision of the series, but
regardless, I've applied and tested v6 and had no issues. So:

Tested-by: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
--=-VM3AeldSdseypz41TxCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJY3ZxJAAoJEJ0dnzgO5LT5SpUQAKzEsBbUHfSehE3tQehmNc5l
FKYc8CgZILDxm6IdGjS5uxi7dYhB1Ubg22N7so+wlfaucpOZMrizimTPIbuw8b/R
YCx1/H/LRaANRbqV0ROuxIzDaUD79vcDcS9PtITllZ7NYrfOGLSKdZF4+6a5WN4V
Zc/5bcDU1edh7NrDm+hrA7PZOn9bKGHE0wRcEaBcV/vSnuZxe9GPmQtrkJ+tQ5Hv
7xN4s81VwWjR+4QR73sWZkjKue4u01uvkApakM/nzUbMb3UhoXJnCwHGS5iMXh0k
W9N0bAIeKs1VOzzxXqsE9x/9OvKCrNBKlkrenJ9SOASH7mEBtpdhGAxhQz/zdT2O
sA44AuHOPmPGh0YlyhyTLensoNRFt14od/YVW6CIVc0krlgou79yJbC9hg7+A3aP
pt548UCtnzZdtZ8LKp+cLUsEDAV6rPyAlbwPBKndfgNKqYbQFS95R9gtt2ltC827
E4ufUd3ETQiOWTN4/3AXyAs/f/Un76HxSiZcEDpn73sFYnTDV6VCQZV/X7gckhao
oTMQo9xZNaE1J0Vb+/F5FEdudl/r2dMjZMenrEgXTKPJWkvu6YmVfpXgjExVFCf+
DWe+/96ugv9NZ7NYfm7pQTOng/HiyR8A26fRaG9s1a9dFyDQtmRW7WmPdeTSLSPD
rtg+77Pddb6ywr6iDMuS
=xKL1
-----END PGP SIGNATURE-----

--=-VM3AeldSdseypz41TxCF--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
