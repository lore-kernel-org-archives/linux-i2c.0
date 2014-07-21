From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: i2c-st: Update i2c timings
Date: Mon, 21 Jul 2014 16:03:10 +0200
Message-ID: <20140721140309.GA2734@katana>
References: <1400254330-2547-1-git-send-email-maxime.coquelin@st.com>
 <20140602163103.GJ2654@katana>
 <538D7A1C.5040409@st.com>
 <20140603075922.GB2653@katana>
 <53CCF3EC.6030904@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CCF3EC.6030904-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry for the late reply, but it took time to get the answer.

No problem, thanks for keeping at it.

> > Which also came from the HW guys? Please ask for details why 10%, too.
>=20
> This is a safety margin.

I understood that. Still why 10%? Is it randomly guessed? Was 5% the
first working value, so we took this * 2? Is it a secret value from a
well-experienced engineer? While not perfect, I'd accept those reasons
as long as they are clearly stated. I just want to avoid trial and error
trying to find a good value.

> Note that the I2C specification only defines minimal timings.
>=20
> Is it fine for you?
> Can I re-send a v2, which:
>  - Indicate the Toshiba TV is one of the affected devices in the commit m=
essage
>  - Indicate the 10% margin is a safety one in the commit message
>  - Add a comment above the table indicating these are standard timings + =
10% margin.

Basically yes. The same information should be in the commit message and
the comment above the table. I'd really like a short reason why 10%.

Regards,

    Wolfram


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTzR2dAAoJEBQN5MwUoCm2I7gP/309Sk6+eZtujE9Duh285rpy
18TLXyjvy3r8+6oro7PCbQIdUMEWvGjT5rTU0yklcVZ2+1gFMW2uw/VetQMg6gY9
hHQuc/m2KVbbRDO7OW7hgORolHBvR3tUQWxflMvX2TGloxpfko+hZvSBo6hbRS6+
zaxmUr9ASgSyycJ4PmjGAYd9FUa01bE9kwodMwQTlL6SCMgjADmm8jNZoXQL6q7J
2te7SqMPqqrqSmjelKeSOwFNfZz8l9p6xHpMxtXjjZTcyD3AgymO6YmC7Ey84KGs
/8nnEHn/ispcRuvcFPOxzIAcvq2pI+vyR5hlqXwFd/eJNl1m8mAR/08iIZq4pp7c
CL2ExfGy7VU+fRkwkFF90dyWoUssWdqGCY8+rjEA9HeE86QQjCd20bmIQOwl3ZrD
ZoXYmDu5VwUR2EwKLxoEm7njS206g5mcLH3+MRG050GiTuwW7H4xLIkkt8ouNufC
39+parL6HBm85z/HSxZuXLGgXY/DUqViVS8Kx505DvHPtXPTOvUjVcfPVLYGoL5G
VbQYRfvwuxiS358Gm9/dFDxi+aACRjsi6L997LrIcuQ2ZqN5x8WpIYNlJ/C8ZPAV
q2JX1mT3Pp2MlE3g6aT2GkTYUVOYs8uW5djPZbnHv54+qXcuhbwz6LqOT7imqD5f
A4d/NvRI1w1n8j0ofRFL
=xiAw
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
