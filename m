From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 8 Mar 2012 14:41:54 +0000
Message-ID: <20120308144154.GO3638@opensource.wolfsonmicro.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXoUnAu9pZeaHebo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331213407-10135-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jXoUnAu9pZeaHebo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 02:30:07PM +0100, Linus Walleij wrote:

> The key reason is that we have hardware blocks with different
> characteristics on the order to do things, whereas in some other
> systems (like shmobile I guess) every IP block shall be twisted
> the same way. We have a mixed legacy of ARM PrimeCells and IP
> blocks from different corners of the world and just cannot do
> it in one single way. ARM PrimeCells already have some
> centralized runtime PM callbacks.

Yeah, the other issue on some systems with long histories is that if
you've got many generations of SoC it can be easier to roll updates out
over drivers than get all the SoCs updated to the latest infrastructure
along with supporting new ones.

--jXoUnAu9pZeaHebo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWMUrAAoJEBus8iNuMP3d2JwQAJgP9X9qYwZy0LCU5L8QAHGg
A+hcHV+BILeNzwPL15VXqVZCqUdhfSDW118S0zmKiGnARLw0nqe+TB8Xl9ZNkSWw
aJWUV7aq6ulMXy1cihR1CpflDEZRmvq5bgg7C+lom41FgrNvsuE/iL3XRfyn5lXo
2q+AJnDvEbWbr4loLaBGjB0IOwYc+RdOAh1ADWYfCTeqPw4sN5vaaA4cyoowVWMP
zlqQKUiCAcDzRp87ZtYr0RqWEpRMidODcyCC1LOO2CysBnVIs80lPA/vQbdFvh9Z
Pv4O1zSgc0FbnM2ayhcTBGvQbjpkx/tBAyoDtATqV2NtCSMWRkdarNuB32fT3aAK
Cnpf7eRN83NRUZXqKWlmv2wLAkprUE0gBxgEb0Hqzjn3I5/bWNue/jD1Cl/GXi2c
gUdAOJoeksjtupDFWtuDRTYU+jO/rggDs/aRqBZ5EPZaDYtu/D3RXYOTqCk71S6g
LSS9iOPEQzf5HLFrmZkCefkkgVdQ3A65CQUWN/KxLLULCt2lRwYbrFsJTUfNla5w
eTcLfyiY2BGk1Eo//HSDv++IGJUgo6h8KjtCxZIdZl6qC8Ezn0bll+c8P3C8MoNJ
wZZGA33mynC3FV2rkntAesom69YVU/2Laup6pzkH04x4e28KdIUPStDNdh8WJBKv
te3MGoROGhc37Lwyp+kZ
=rPZQ
-----END PGP SIGNATURE-----

--jXoUnAu9pZeaHebo--
