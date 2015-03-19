From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Thu, 19 Mar 2015 17:02:08 +0100
Message-ID: <20150319160208.GF7657@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana>
 <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550AEF9D.6090307-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >-	/* Only register child devices if the adapter has a node pointer set */
> >-	if (!adap->dev.of_node)
> >+	/* Only register childs if adapter has a node pointer with enabled sta=
tus */
> >+	if (!adap->dev.of_node || !of_device_is_available(adap->dev.of_node))
> >  		return;
>=20
> That feels a bit odd to me. For a regular non-mux I2C controller, that ex=
tra
> case would never trigger if the controller node was disabled, since the
> device core would never probe the controller device itself. So, we'd end =
up
> with inconsistent paths through the I2C core for regular controllers and
> muxes.

I first thought the no-op for the non-mux case wouldn't hurt, but I
agree about the consistent code path. I mentioned in my previous mail
that i2c-mux might be a better place for this...

> Perhaps better would be to have a mux-specific function to iterate over a
> mux's child nodes and instantiate buses for those. That function would ch=
eck
> whether each bus node was disabled or not. That'd isolate the special case
> into the place where it was relevant.

=2E.. so I wonder what you think about putting the
of_device_is_available() check into i2c_add_mux_adapter() once the
reg-property and chan_id have been matched?


--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCvMAAAoJEBQN5MwUoCm2IWoP/AhjW9p5jR9fvBaBn48Y44VU
P2X56TrUHkyrtidzzi9fXjRIY2hSeZcUZR1ZI3opkbTwI8kazHWlsu5fHBTgwehz
d+EejLQ9X7v1//oQSJiucizPm+dkKSjcPhDc4TMIwkSfNQeJgTcd9wH7aqbNIC86
srgCjOLbiSd380+3fWDzicOLGGvVp1sclz3F6Rwjpb+1cuZV1HWbgk4Jo7jENATr
RObnm7pDmkglEQTHc4cS1I/P3aqAURKitn7y414hB5NHfxEe4EEp9s/69YzjAUH7
hQc2XwXKkQAQRA7ka5IjLFnIAOJfhmjaQtVOURdOY/bpgRnpesVV28b3Z6QlzhkU
bi3k/HdOT4TWJWzr2XRaO9YAGRFyUXePO55ESnZio9TGzGqxoxCzH3UXMcmpXul/
iWAkKcQjW3poUTjc++5tqZEgHk9dgMR0Dh08EBTOhf6/4QtygbFFm781BP9KUlIM
tXdgB0FcG5Er5Dk9WDIlvqdghd2Pntv66I1yGlnYxMmJnqTCUepwD7J9l7ycHrRM
AkWQem3SYCkbHoKsKqlTnuHkHeB0feSjepGCtwvO6w2cJcV4fuMoj+GXjApG6rD1
GxNMnqdcqRcT1S234XIPAzmNQcF0K8PNX+I4h9/m4aLoj0ITFzgfMEJaCwsQU54D
QXqWr3vg82BYQ9cc0yFd
=gJDw
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
