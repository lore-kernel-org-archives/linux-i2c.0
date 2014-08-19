From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: double check IIF in case interrupt lost
Date: Tue, 19 Aug 2014 09:53:52 -0500
Message-ID: <20140819145352.GC15371@katana>
References: <1408004954-29418-1-git-send-email-b38611@freescale.com>
 <20140814094204.GW5134@pengutronix.de>
 <96d6e524bc524305904730df24bf878f@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140814192702.GC5134@pengutronix.de>
 <01dba3477e664c88a65e276a1c77c3e2@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140815071814.GD5134@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140815071814.GD5134-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2014 at 09:18:14AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Aug 15, 2014 at 02:14:15AM +0000, fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> > I am sorry to tell you I don't have the reproduced platform for the iss=
ue since the
> > Issue was found at one platform of customer of freescale, and I debug t=
he issue with
> > Customer, at last generate the patch for customer platform, test fine. =
So I want to
> Does the customer use the -rt patch?

Valid question.

> > Submit the patch. In our platforms, it is not easy to reproduce the iss=
ue.
> I tend to not want the patch in mainline. IMHO a wrong workaround that
> fixes the issue only for 95% is worse than an unfixed driver.

I agree. Yet, I'd like to keep the information we have so far. Anyone
cares to send a patch adding a comment to the driver with what is known
yet?

Thanks,

   Wolfram


--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT82UAAAoJEBQN5MwUoCm2M2IP/Aul3EH8JKdYWaAPv9G/yOol
2AjAkpRb7q3Y13+bJO94vd0JvP1hHSQbOsAPEmEofL3MtCof3siqWAP1nUas/aOS
v3H9uxbHS4dn6yJWiO/NGuPTrJYUu7TjfJI/xwElyhSBMQxg/NGqMznjZ2PuVXEL
nt8LZZvvJvIRplMWKsACKwRO3RC41Mua97v5RjuMsa6asvsyAm7bXLeE4yeo3MBO
QNxZqVeMtuUshl8ukNgUaoje5/jG0asCS7UBdxDeFogX9BAqilqQWTPh5VHcvEeH
P0OUiz/P6JEhZ+elobm1svd2CLS/Qo9ECyK5ZwUkelWsVAajdvVhWWta4Hxg+6j6
aXg4uVlzEBpg01MDHJp3atcnztRV2hjVWAMUEKy+eVGSslE36/Vl0yBf99tW+sjb
FMh+eQXntOeEgJ4u+WLqHeTrjogxC2sch685jDJOqS2jwwgFDVZr1YJtw7nLpszT
5GZ+Tr/U5XslrnI+jKKxMHKh0FZQcDwMN3f5stT+fn4ThuoNMrRY2WLO/1ZV61Xo
INzAA5YSiQ9x8isISwKvN5DlRuH0oYKNkI21QFz5tJGUL5AWaJvJVtrdPpxvROda
sM2sj2LPVX3CZ2UUpOZWRIA3FdbRg8tZdAHJEqKxAB3lY3sy6s4ytMTaHvqzeUab
EB+CT18w1/2L9VTmy230
=kw/R
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
