From: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Date: Thu, 11 Sep 2014 16:52:22 +0200
Message-ID: <1591383.Xdy91rktuP@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de> <20140911141257.GC5149@katana> <20140911144003.GD5149@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6151357.4VKUoaRBI6"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140911144003.GD5149@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nextPart6151357.4VKUoaRBI6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > b) could be seen as a configuration thing since the functionality
> > backend could be changed at runtime even.
> 
> Come to think of it, not only the functionality, also the address can be
> changed at runtime. This makes me think it should really not be in DT
> after all.

even worse, there can be multiple masters and slaves changing their role on 
the fly AFAIK. So the best dt can do is to provide an initial configuration, 
so all drivers know where they are and where to start. Everything else can be 
changed during runtime.

> People will probably find out that it is possible to put it in DT, but
> it should not be encouraged and they should do it on their own risk.

--nextPart6151357.4VKUoaRBI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJUEbcmAAoJEKyeR39HFBtoUJAH/2VkYCMJ+aDlPXoWbktY2AHP
xHbstyCIzfj7kdVl8G4BRmuAbkSzoSGtm/apwz6zQOv0YjwaxUw32gaO6/E3srVT
qEzCTqg7gyvvhenOQY2OWXJvM9inwBPQzuB8DRVtRTbO8kJtyk7YCBhaKURc6xyf
pqyhLjuJrwRuAxxF1hd3fur3uvtop11LFNbv5hxybGWyRRosO38h0vaHfLpKSqSD
RjqV7NfjxoQ8sk25IAghwRquO+YeaItJ1fWcmcaOLGj/ID27X54SHq2vYGVkqMN2
n9+CZ6n795dxd1tj1WQnIVl3CCd/0xcS5QAfmMgVKQ7sgfJB6AX/ElX6BxJf3u0=
=3/oV
-----END PGP SIGNATURE-----

--nextPart6151357.4VKUoaRBI6--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
