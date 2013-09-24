From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Tue, 24 Sep 2013 17:59:25 +0200
Message-ID: <20130924155925.GA2995@katana>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
 <5240AD6E.4090905@wwwdotorg.org>
 <5241B1FA.6020500@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5241B1FA.6020500-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, Olivier CLERGEAUD <olivier.clergeaud-lpHj6iFQ3dU@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> "glitch" is is used to tune the I2C timing requirements, and has a=20
> nanosecond granularity.
> These values are added to default timing values.
> I'm not 100% sure, but it looks like the "samsung,i2c-sda-delay" in the=
=20
> i2c-s3c2410 driver.

For that, we have the generic "i2c-sda-hold-time-ns" property. The s3c
driver hasn't been converted to use it, sadly.


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQbbdAAoJEBQN5MwUoCm2xjEP/0cHjX/2Ozq+yhaNXOqivqTk
GuXvuVQERNOcBikKecWnIMOhawbQkprOdtosuc2uFgbEAIA8NKsc+OtN3gc0vyQB
bTpLyCY22RcZ26NRLMzT1cSYZdes1dOHpZ5yfeIdJCJxjsOYGquk8whF19lXtrIr
j4U3BKbcAcukjBkcQNnp7li3u4JgAWgZ1HOnOstmZL5Q/2ih8VSnYhGMO/ps61Y2
kBSwfTjWBiZy/qxArQytl9JX2KXD8lPCBpbuEQ65o9tWAuUy5k4gf1fLG1tz2oyS
BCL/C8SEHLNC7Me7PJDBkHwCWVkCv5UnfrHDYJ/XM95UD00QWJ2jxNIKQEofdPbf
4MmayhtAsq0mjTpniV9OWXfZJiYZDQBA6Q29BTsgByFM9IhxtTvmxCE83Py/O1Ux
2BRcNtg913PT0nhcRjSbk7Sk5IJ+YdG6Y9HGiKMj35GmNhOaDgLtoQ8LOWOeoox8
V2vKlO19R4NOOqCMJHefRcusZO9a2n1j8seDCveJnYf0j+XsKqdfvrEKbFJ+ObmM
kZQqMOeLSpGARYQfrvYNIgsRQ+bQRHvIZLkQw2iC26iUmJLjkVdxLqpNUinZ7syP
wuGRoGbCeeodCBamCo/Phs2lc+NDlgIj6qLCBeZXGjMdsMgc/S4DkPO0HteCwKD3
EdGxQvicSfKfAaA3ip1G
=kCEp
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
