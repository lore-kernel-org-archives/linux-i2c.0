From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Fri, 28 Feb 2014 15:07:28 +0900
Message-ID: <20140228060728.GB29849@sirena.org.uk>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
 <53073C51.5010401@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53073C51.5010401-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2014 at 12:45:21PM +0100, Sylwester Nawrocki wrote:

> The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
> using standard DT binding and v4l2_subdev interface.

Wouldn't a platform device do just as well here if there's no actual
control?

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTECedAAoJELSic+t+oim9tvIP/2ujn2cEbEw0+ijnFU3JPgfQ
ZSyE/cb1cahfPIrejIUjYn0GZXcZJ72WrVrFOkutfeNHO98FngO8ikFZUnaxItDO
Dgnrgm4LiaLjrW9j6eLxeSOFCCWbb6xrlJZ9EoC4WHzo+NlgaxO3p9J0zZbq/W6c
noaMAXbqt6nn3xDV8avF37m2XTEwJfagsinpOI5ZMA2hiSEXIOKM+qf52MC1XfIR
7qSmkmGsOrfl0WedhOjvIYIfFqXtxss3UetHDwsHTUaLjlEQUtO8YgKwkngoCcP8
niWJ9WkZtG8GIe+1mM9P+oq7oEpCpTARPv5Ue04tc+pJDBspqQY2jZiiuAUW1KLn
tpUa86cg2dGOqRGAgaYS0RLahf6pUQCcmQzo6sMalfrqU31M2rZR+GDT1GYOQuOO
oItOYST2nB+NLHtCVLW8nA8DFRZsP0U23RaYEHJ5/04Be+LpMowTtRSSUZSF5Y3R
q06RM6iFvF5dTuv+/XtX0E0aEy8LAE1879nImnW0L25fE8pJFL9+fgYV2XpuIwfr
GtdNnTdsjy2Hxis9xArsMXb9gX5o2y7UJWuVMNSz1OV3evvCcVLZSD8ekW1DlOR8
A864jPPHPVWL9jm1FIs+yjkvFX2o2Fhn/saDFbAs4ZKSpeYg/ahNwVGSawUPcvy/
chWt7xuqLh5gyhLutR3g
=H5Se
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
