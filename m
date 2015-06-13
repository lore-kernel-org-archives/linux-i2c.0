From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support on Xilinx Zybo
Date: Sat, 13 Jun 2015 18:49:06 +0900
Message-ID: <20150613094905.GA1682@katana>
References: <CAMQCnXF47Kr3x3yeqba-me+N8rQ-vDJ6ziho5107qcckDbT0mQ@mail.gmail.com>
 <20150610143801.GB21540@katana>
 <CAMQCnXHfcgWpAS4HT=8sCt7RHA29xMK9KzAU6H0rP3RR7DLMuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMQCnXHfcgWpAS4HT=8sCt7RHA29xMK9KzAU6H0rP3RR7DLMuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't think necessarily there is an error in the docs, it was probably my

Nope, the docs are wrong. Try this:

echo slave-24c02 0x28 > /sys/bus/i2c/devices/i2c-1/new_device

That should be it. I am travelling at the moment, so I can't double
check, sadly. But after that, you should have a new device at 1-0028
bound to the i2c-slave-eeprom driver.

Thanks for the code! Haven't looked in detail yet, needs some polishing
to match kernel coding style. But as they say, first make it work, then
make it beautiful.

Good luck!

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVe/yQAAoJEBQN5MwUoCm2AasQALWLxRH/aSPOScBxugL9mK4g
V2jh0oegXs5X3E3HIcc/vrEp546UcG7naoN9TX7DGRD6VjL71taZMnRQka+Kq3hQ
OIIKT6qoy4p0ut+HDEDInfugWvDx1zsivqrgwsc9oXqHR7RZ5sbhMm6/iT5UMxOq
kJ0LlU38VPSy/eBGIkma4yFb5UGyqFNJlH+egNjxHYVBRk0MrmApF9Z3p+/nFKpu
R4lNhDHw5p8xv3E+6OSTU9L82p2xWEA5IhuOguTbC80ejZDmtp6qIWPpW94IFAvg
Ky2s2CW8ifZ4XAwfvvte17BJMCGXH6ynAeOr8XWaFRdMYnjOplPdQBA2i8cnma1a
o10XWVeiRu7muD+cep3lI42HqRKcUZDePLyoQkgrhC4Y8Ss2r2h25Bywbt47Uhw5
igAzUgwAmSDvcOFCTH70DH87BXl1YZCGdUUiP0fQpIIIH+wPZ7ktGmPuIIBsojBC
+dfh3vdzIvvBNvQa2A/3FwTcub8P2srjBmBPGTHfre3pNrjfUBTpedW2sFWxSPTZ
J2w3ildu8nDn5hztp6gY34eWS8Gf/qCtXo/g6xbZB+LMJAvOX+xcDn4jHkpN9I4o
z7HJk7f2H0mYKUklboHXW4ndzWbGnm+hVPhgQGNJh4CDgJT6/R0sWlv4UQIp2R6T
s7rSx9fa0ko+YGxItfBc
=/53i
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
