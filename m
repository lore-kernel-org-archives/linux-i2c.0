From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Unable to access I2C device behind two muxes configured to
 deselect.
Date: Wed, 17 Jun 2015 20:24:27 +0200
Message-ID: <20150617182427.GA28251@katana>
References: <CAArnDZ=WNAOHzxxPPfW+=OLgE6oSifsjWo9qu++Jo+5T4CA_xw@mail.gmail.com>
 <CAArnDZnbqsFpa-1-OmnbhykFP9rc-P8oq8uOHSn82EAtwx4org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAArnDZnbqsFpa-1-OmnbhykFP9rc-P8oq8uOHSn82EAtwx4org-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Berger <mikeaberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> So, I must look further into the interactions with the other devices
> on the bus to determine why my bus misbehaves shortly after boot - the
> SCLK is being held low by something beyond the top mux.

Good luck with that and thank you for the update!


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgbtaAAoJEBQN5MwUoCm2NV8P/0O9HwHJs0V09Q3hrOtY1Iw+
x5Omgs4Ohp177rGCi9uMUTFONLcVxygh8tXYlJQMSFSBy351e1SVKVO8aUaysMsT
1H5Qh4yKIL5kiXz8z9K9XlzNrEROwT0ivONHQi6IM8CjDGRLHBXen/9rtgPxkVNf
eSTX9tgES4evZw2/zqE7PZZFt8nKp7PN/K386W4SLwQvRPXmPOkXiEYrTrpgEy7w
9ot9Ygfz1iqXw+nHuGepxNkyW0EE6g6emixwg6X2H929HZIOZ6pOyN7DB2yzRySS
AlkgrZM2OQDlofOW9HzMM8CD0NqttZnNIpf7Uhca4HgP0CM6026o5JkUSMh9wniY
rOP2TDhAhU1cca2BlwsDVafe/SR/TycAHUG86vX+aQV1V6YMibVPJoLVKFdnf4WO
rHal84RruwGkTxUB3Zx3MLEStPUZGzvS6w3/6ftiYLHpp/tkS81fVZRx3XCl04T/
0cR43IwoWDUl9j+TyhfQeCqxu4vECgvE8ERoQmwE4sUF0kNckat7OohQFKpJCh6M
X1PTvbR+8XGDLY/ZiR081bCjnf6awXylV0hiVDiBwLOb6sTd5ffFaxRwAR5ukw3p
NwmUfXlaUUjDJDxy5qZ4rjMJjiJmMY9nCgS0LCUf1mePFpChszAWwj+5Yic/elqp
ZIeXD2Qy+Xay+eQ4SVMZ
=q5UO
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
