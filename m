From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Thu, 2 Apr 2020 11:28:13 +0200
Message-ID: <20200402092813.GA986@ninjato>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <CAKfKVtFf+VpinkOGsBFZ2-_PKvx-C1L7G7_uhY2RCvV5dy6L_w@mail.gmail.com>
 <AM0PR06MB5185E501349E06428093B62FD4F70@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200401143254.GA2409@ninjato>
 <AM0PR06MB5185F8F51316FCD5213F0ABED4C60@AM0PR06MB5185.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1059516260593539739=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <AM0PR06MB5185F8F51316FCD5213F0ABED4C60@AM0PR06MB5185.eurprd06.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============1059516260593539739==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jaako,

> > My best bet is to introduce another binding "single-master" which says
> > clearly that we are the only bus master on that bus.
> >
> > Both bindings missing means then "unclear".
> >
> > I think this matches reality best.
> >
> > Opinions?

> I agree that this sounds like the best option if original binding
> can't be used, even though it can also be a bit confusing to have 2
> similar bindings.

I think it becomes understandable if we emphasize that "no bindings"
means "unclear". We need to document it.

> How would both bindings existing simultaneously be interpreted? Maybe
> both existing simultaneously should be considered as an invalid
> configuration, so that it would be enough to just check the one you
> need? The other option would be to treat both existing similarly to
> neither existing, which would require the driver to always check both
> if checking one.

I am clearly for saying that this is an illegal combination. I'd hope
this can be expressed in a YAML binding. Yet, my research didn't give me
an answer. Adding Rob and DT list to CC. Question is:

Can we check if the boolean bindings "multi-master" and "single-master"
are not applied at the same time? Any other combination is okay, i.e.
just one of them or none of them.

> Should the new single-master binding also be a general binding for all
> I2C drivers or a binding just defined for the XIIC driver? Having it

It should definately be global.

Thanks,

   Wolfram


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6FsCkACgkQFA3kzBSg
Kbbvtw/+L5wD8ARrOmtDVYzMRtJvbyu1XsD4cZdfx/fHNB3oOKbL65t9dnKWiuRy
Np7KViYB9VbVGTYtRWPT5EPWUqhtNbRWfEoxONZ02IVVBq8qfl9iIgcXpvrbVU2J
7m3AJSB8x2A9FJ4iE1o3hPw7zkUKtnXui1nn7MIFO34d6QaU7UgxpQ3pIdITKtIm
BqUedfcI2zj0cV+V4RsZFUlZLZ7QsVUkcXDd3tsXt/yKnBxPVV/pzqmsQzNrXI3Q
evWAjIFHmBJzM4B3teelLwsE2toVGVtK/j4x5ZhTSkEpPBnkA++02xAVq+krdM+z
AMBD8ZIoHwQzjoSNGcoEXprLkQmN2nbfl1dgvRGUPotJ8LDIYo5NyaRy4WYBh6xF
QjnMQFg29QuuWCfXDKC8vNG1BN/DYUh+8Bzo7HCGiEPd7B/unsFqz7QxW6WCg29G
MmHi+253Xq9LKDvC6OqB2+Dvc764BGI2xiVu4t4/iXXvWI0VkhCeoZkUdLkx19OR
LKEw7ipKmhiX4sPvhtD38J6c4XKz1izB+4rzTq7ZZH+Vg1cNtYL3/riIfE9BwxjF
A6KwJi6vXetZxROIxWTxj8BX9qjbhErOYDCTWPxFlj815S4RfDgqC5oiHIhGGr4m
Vv3egui9LAtlne0QsqmR0PjP5hQ4fFp+78rjdoHgyyFAtKA9fnA=
=KFqX
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


--===============1059516260593539739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1059516260593539739==--
