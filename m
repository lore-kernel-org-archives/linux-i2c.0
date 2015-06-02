From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 05/12] i2c: pxa: Add bus reset functionality
Date: Wed, 3 Jun 2015 02:33:41 +0900
Message-ID: <20150602173341.GA1494@katana>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432818224-17070-6-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since there is some problematic i2c slave devices on some
> platforms such as dkb (sometimes), it will drop down sda
> and make i2c bus hang, at that time, it need to config
> scl/sda into gpio to simulate "stop" sequence to recover
> i2c bus, so add this interface.

Please note that the i2c core has a bus recovery infrastructure.
Search i2c.h for struct i2c_bus_recovery_info.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbej1AAoJEBQN5MwUoCm2LgsP/AsF0VvWSOIaCPzM7lVdxrDx
G8kZ1ji1b1sqq+qcAfvKj5V7supJaVMWzxWfeSSPVVDxtpo+IKqWEjJaYW5E3sHN
ieDHC5ZoPjsU80Weh0nmVH8iVEGdj0rY9kLV/8Gak/hOaHw3wGbFsr7ocoacvTiz
Lrm0HLoLRxnBQnIwstf4BatDWt819Oruh/hP6xTjWsTeYpil0p87+iSaPYtnEATV
E2fRFke8Gpi1sUIPDixVcOdHi0iTXzsQMMHXzLPxHkLdISKdDvkAaXVjAEAw/Yah
PJvVlQ9wgIbQU6bk2+eyxxU5KacOAtRxQwf4GlSfoMg1AtUNqWw+tXh0QUHggLxm
1LJDOQT9f65prSjOlIT5DiXvkJEl8ni9zRPkK90r/M4I3+5/1+iFfC65sCYI4CTE
JtHgxEOvzyTjtH+EQLAWEnJ1cUHmoVt8OH1oKtDT2GEiLl/VPj3xG6BKA0pCMlPQ
lM+zvYekkSHtoDOR79sY2tyJ9If45m0QEdJgTUMMINwvslkSMbYO/zoitWfTDrP9
8Z1BC0BiafEyktsGwO71bkZROWqos/u8xrL7FoUk4ul4+SNEKlHOJIMjMai+8QES
h+yMiWv+duSkwOuohHsOyzIITIWP0jIImxsyU8rh3zfREPJEv5AbmtCcpalRg0gk
MnD5XQDLrklgYjCluzyk
=5Nbz
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
