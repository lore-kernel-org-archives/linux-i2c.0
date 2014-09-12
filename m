From: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Date: Fri, 12 Sep 2014 09:51:31 +0200
Message-ID: <9935938.eKOCvCAtLt@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de> <1591383.Xdy91rktuP@fb07-iapwap2> <20140911145421.GE5149@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1739861.7zaRQAvcMS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140911145421.GE5149@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nextPart1739861.7zaRQAvcMS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Donnerstag, 11. September 2014, 16:54:22 schrieb Wolfram Sang:
> On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
> > Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > > > b) could be seen as a configuration thing since the functionality
> > > > backend could be changed at runtime even.
> > > 
> > > Come to think of it, not only the functionality, also the address can be
> > > changed at runtime. This makes me think it should really not be in DT
> > > after all.
> > 
> > even worse, there can be multiple masters and slaves changing their role
> > on
> > the fly AFAIK. So the best dt can do is to provide an initial
> > configuration, so all drivers know where they are and where to start.
> > Everything else can be changed during runtime.
> 
> Why do you want DT to be involved at all?

Imagine a device which supports both, slave or master mode. The driver needs 
to know in which mode it should operate. This cannot be hard coded, because on 
different boards, different modes can be used.

The point is, that if we define a dt binding for master device on slave 
adapters it will be there forever. So even if it makes no sense for the 
example eeprom simulator (or even our embedded controller), it may make sense 
for other or future devices.

On the other hand, we had some painful discussion about that issue in the 
past, so if no one else steps up to propose a good alternative binding, I will 
be the last to criticize your approach.

Marc

--nextPart1739861.7zaRQAvcMS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJUEqYDAAoJEKyeR39HFBtozwgH/2bHmcw/6W6u/J5YCNajnCsl
HTeIRhgyVhYg3veMFwivVoQPhSM00YuH7q9GNaKXOspFxkSUuo8wyZQZnaF3/sTE
gQWMF6KV8qUgGKZe7J5944q7FEhKkiGNaOyBLnSNioq4U7hCdfuUgjaLcNVP2HXZ
95gPaRInj7dxyoai7LyfYyHKV1qQdR+rVhStxUUFllRtVw9oZFiKr4JEmPcadcNq
dYdsVkXoWQTLWtAl1dAl2RIvEI3DwygumnqXhwQ9G42FEAgIUbZMlFPsHE6+wDB2
C5pOAeSI1FWJgKqixF40jutMroUb3naendOMSG2Ee2N40BpXk2m5PLi5Pyqba8I=
=fuO/
-----END PGP SIGNATURE-----

--nextPart1739861.7zaRQAvcMS--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
