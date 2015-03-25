From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 25 Mar 2015 17:15:04 +0100
Message-ID: <20150325161504.GA29838@katana>
References: <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
 <20150319213937.GA899@katana>
 <5512C213.7030705@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5512C213.7030705-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Guenter,

thanks for the update

> Ultimately, the real problem is how i2c-dev accesses a client, not how
> i2c client drivers (who assume they have exclusive access to a chip)
> handle multi-command sequences. Forcing extensive locking on all drivers
> because of i2c-dev just doesn't seem to be the right thing to do.

I agree. i2c-dev is too much of a special case.

And since at24 has its own lock (I missed that), your patch might as
well be good enough to be applied, I'd think.

Thanks for this work!


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEt8IAAoJEBQN5MwUoCm2qtgQAJDr+hixiYRCZ12iVtrGe1BM
jH5GCPjNQIkDe9xwr0qVt6JWGrHYCVTzQ0qbAhVL5Uyfm/TJMeX5iRssxUjxiBZh
qjszh4zzSIUcBa+8gWBvJyGLj3nnR8vyJpacj33pUyKH3f24XUFtWXLWwZOGhALi
LAr3ATsQfQiD5ysL1q7QPb0+OqnyWMLAZ/jSQzrlVDmX96sUH3433TUv5wK2ehhd
dhX1r+9f1HYRg7j8ZSCK3jZoIGHsZoAZE+0EAZwo9By7TbYH22yGoThMU6xR1C5j
vwBt4yate5gb5qAsqCKa/uoV+Mmgl1CwTSRkDSVpYJe5C41Xqt17SX/CfHbL4dgY
wJ7CpDoH7ClJTOaqeV7RCY6OS7woAGzjzpxNvhqs2DwLhIBgtiMGGQaAb3TdqnM+
oev1mZmHVL1ToqSINSD+v6LrMy/R1szZlUE/82+SvOu0p67Oql0/fJHYJY5MRnQE
EXZKhANMbF84rnDWmItifkWSK5AfcN+juZuuLxiktwljiP7wR4VVg0IdvoonPzZE
wp6GaWBEZwRItXTIpqi9CxCcwVGpRo9Gy5MIYHtRfDm7+OacEIhyCzFayNWls/qM
DnXQrJYdzzifQgFftXK2YFuAJJYm3Si2xf2x2T8ViOGQ0FPTHUzgrqKVKhYbE4Wf
d2PZxUZbxJ403G5k+kUf
=+xUI
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
