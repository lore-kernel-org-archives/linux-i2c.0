From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
Date: Mon, 29 Sep 2014 14:51:36 +0200
Message-ID: <20140929125135.GA1327@katana>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com>
 <CAE0=X_0guSvMqZxHvdS39Zxx4G7qVvnddv96t72rp4FwpJLgfA@mail.gmail.com>
 <54293F2C.2090206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54293F2C.2090206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>Its looks good if we move the entire ISR above probe/remove
> >>functionalities...
> >>
> >Not sure what you mean here... The ISR _is_ above probe/remove.
>=20
> I mean ISR should immediately above probe functionality. So that we can s=
ee
> devm_request_irq(..,isr_name,..) ISR directly with isr name..

Not so important to me, '*' in vim does that whereever the function is.

Still, thanks for the review!

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKVXXAAoJEBQN5MwUoCm2x5cP/j4hOcPDPDd2N79y+YfY46Xi
M1CFTPQJi9kSikY+0pPnd/zDd5Wk3Gm3fR9oxBTAW2Zzt+EPlkiYr8YFd5STWc92
l8dKoLd0OIgWS20FQkFqnfNg1pXS+T0OTnbt7fbFR2W2/zJi6TAMVWQ/fXtok3N2
mYvAkklO7m7p+cpBkHuw0+uBYtbasDyFh/QEJI4mGxry8TzXZs0D23Vi2JfkP3Wd
xKHH4D2AfO8ktBm+lVVMFtH09+inxqCEitNqyBhTtg35ELd7LpIai3EEBJPuod/p
eRBvtqxRVQeIuf/DKp26eesTDpj8h17qCeWatl2R2zkTtZ/as4t+EMwKq/HNIX5I
hnKYwz0K0T4dd9BeeC46j3gMXtwTqzCqtEvpgQvYEgkRvXg1yfZqRmtwUHm34TTV
+fTGjRzLPb3jZrJ+U3VXl4D+l1nWmUj8HVn7eaUFKohUMv8nfLqUVdm30ZzDJzMI
aiiOq8z/BLVB8EpE0gbbibIevgReXaf7ikZMPUDFodpK5hyBUm1ToQiF6iKfjUws
oPuLGOLcQi0CPCYUHbJQClbjMPucd5x7Ho0i1Z4IohLbIXX0s0FZJeK6naU+K1b4
5W5zzz0RRLliU0YSLlmXaaXjylmd1GJ5f0s3BIEUvdtLrlb5aZcMIlPpDxPQt461
UxXgXm52Pwl+vUcbsNOa
=euqh
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
