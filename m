From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/5] i2c: i2c-stm32f7: add driver
Date: Thu, 23 Mar 2017 21:42:06 +0100
Message-ID: <20170323204206.daxgcczep2daxqet@ninjato>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <20170323201719.i5bqrbxr2bejopky@ninjato>
 <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfk6kf4amhiu2yhk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--xfk6kf4amhiu2yhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yes the STM32F7 has a new I2C IP core compared to STM32F4.
> The engine, the machine state are very different.
> I tried few months ago to write a common driver but it was very very
> difficilcut as the 2 IP are not so much things in common.

Good, thanks for the heads up!


--xfk6kf4amhiu2yhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUMx4ACgkQFA3kzBSg
KbZ+Eg//Z8os1O5VfTfzY3qa9ymLAh5sPqKeCMUPDYNJrARa+YgnTLo74CuAlMjl
Q4mH/iwJoZ7QR1GtA7BY0H8xfsOHoxFTEyqTYXDrts1QrRWhVWebUsDboppS+g9S
2ICaDcx+YgDBPbBcXRT/gc9NO1M9IxOmpSU7gX+Crj3/v4H/ej6NKVjXToBp6xwR
5FlKDidRdZT/QjCReXBJXy3gUGQtvjWHqYUGMghhHmG6XcgpE2XcwhSIykavvg7L
a8lC/NkTwX4L4eLRpRS4RCFmjZ0siH47I3Q4zifFxO7IidIdIhnRQwqER6V8qBKg
QwITxQQrCIcKxutScGyO/nqqGi0O5baSp/hQJ8sJBrjrchffCq+6hPJXFjqU9xnR
5az6WsS5I2srH1Kk6OApE7F901RfgDCYJQdAEyiysGa4p0m+bHMeLBoqA1kumvVs
CekDPvCzF4DV0P644mNBdPWRW3JV/f/y99JH3e1tBzxYtcX12R8/JopU0OaKeCKS
8X9kH9x4wkR09Ut95rLKWTEkrPv0rSFbYWwquG0bRzVAybMUmEAzC7bW7fwe3+bm
Wpzm5WFZGNMBPlJyrglEsYJ2h4zwn3yhl8lb7Ko4At64lh8Uej6iixPPF9NL+iFl
DMOWetfEsarzpOKcvVLwmcUMbbHyS4KZXhmXG3wtylpVsOZWLvA=
=+uiq
-----END PGP SIGNATURE-----

--xfk6kf4amhiu2yhk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
