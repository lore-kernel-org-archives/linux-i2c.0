From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
Date: Tue, 7 Jul 2015 15:43:07 +0200
Message-ID: <20150707134307.GB3411@katana>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de>
 <5476085B.40009@ti.com>
 <1436276269.3344.94.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436276269.3344.94.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan =?utf-8?B?TMO8YmJl?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I only stumbled across this after it was merged, with the additional
> ti,has-pfunc property instead of using the compatible string (which
> would be better for a soc-dependent feature). Can we still fix this?

Makes sense to me.


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVm9drAAoJEBQN5MwUoCm24+MQAKO0Vni8SekYeEChM0kEQZRd
LeBpgAvMP9up+VKg9lFaK9euxBomQnvRVsIF53FP6fCk3R6bZ6qh+tq9wyZ3QWQN
OmPSHZszRILb22McGkUgSCZzFFkdpcYB/HvYboP8ia/q59VC6xO30jvbGrQflWbq
BP6OR9+qfxrCDttMUcQsKdOviYdz+VGR+/t1qmPRAni8ooo/lzjLQfRiv5mb7pVr
ou0hpkn18hlaaGBVuaUBSKW2C4lBq+I8szshgeAtpRLQIjRg8yGEdv58MsQtJtNF
wqtPB8Y6Wo9DakPn6LEpPlwOs+jDx8uBP9lGNoMWhLpPqyvIbk5z9RAtCVyvNS4t
E6FNdkX97WmJwDSMn4LZl3HjnpKrHv2loPBJQlNqA5RMKjDzjfhAvQQyMdDY0HDg
34CYgxM5wQsKcG0uOPgYyi4J3dM45NS5Sbxwrha+FBn0m21egNhjnSWeB0kx9S3p
bODIJzbPZCCZzmIN7ZAuVQ/lKJLOslzDXfqrlWpiyv5HGzPR/vV/Vk21TW/n2wEd
5QMOVBRLt7Iavsu5OsU6ttXqrW1fOgMJH/1JzndgzWD4/LNm7VM70Z3ecYL87Da7
GIgeBXO1Gpha5QPBP9xe64soQWSuqERU97SFMIJVFscTo6PlPfZfRvSsAu30Do20
JiK1Cwt3F2Tr9lZ7QpIk
=p5fx
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
