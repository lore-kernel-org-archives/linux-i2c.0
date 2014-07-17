From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Fix the alignment of the device table
Date: Thu, 17 Jul 2014 10:41:57 +0200
Message-ID: <20140717084157.GA2740@katana>
References: <20140623103658.57df2c14@endymion.delvare>
 <20140716172309.GD2759@katana>
 <20140717082930.0dcad551@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140717082930.0dcad551-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> One possibility is to switch to tabs and shift all columns (but the
> first) by 4 to the right. This rules out the addition of a column in
> the future, but otherwise fulfills your desire.

I'd like that. Plus, I am not so strict with the 80 char limit. If there
is another feature, then be it on column 80+. I don't think the table
will grow to 100+ chars in the future. If so, we probably need to
redesign it anyhow.

> To be honest, I don't really care. All I wanted is that columns are
> properly aligned. If the plan above makes you happier then fine with
> me, I'll do that.

Please do. And thanks for doing annoying whitespace work.


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTx4xVAAoJEBQN5MwUoCm2w10P/32kgn1Ky6WfiDjoK2xVmlVy
bqH4/PZl0K8Ywjku5zvgJMJrfnN/KAAk+FN6zLpp/IIui9wSrJuHCvfgkE28RlZG
km3NJLOX3tlMCKJjN15yVcuGQ98+7i0a7Lz21Rda8FrGy/Kc+24dU9OjS9AmVWbQ
1HmuqsTnc4Wpur8Q/RFNIBZIveX8fYUkJVFjo/Duav/1y652YR+0QugiWkTPflkP
siwvMj9aCPl/+8Nb641JpSk4U4tHQjcR+C7wSyN3uztNFBDbOlNOvhjFMts0OpWe
xgOSRfWRr5MRQcwk0HgmEW5tXYE629EoXFmoTHoPfg2w5BjPOS/NyLOoD6rN4rZB
ONojYiFcy/sEjExuzTZjNy7bJLCtJ/2vg0DvRq7BUDhErpCZqQx8X5580XDbI5qO
wh/FozA6wQuuFwJIvrike0QO4GiGbdZuYbPQz8stw+keceowK3Aj+yqa2J4BHAHg
GsBK2auNZltRJ3PZIeF8V8zMq1KVm6dfuEdbp9N9fQNO6xeyfYLsfOHXuif2pnvX
cWCVzyhB4WbdV7KEOhf2+GoS7bdaJvhEdSH3sxoRvAqkHpo9DVKHNP8kln8dFluZ
RFgDoOG6GdACzuEHBykicu+LHeXcJIWVj0XGdIscPops3tXer+ubbPSCLKBZWY5A
J+sHPGdDrGU6Q0qhiXCA
=byyi
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
