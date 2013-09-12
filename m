From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
Date: Thu, 12 Sep 2013 23:01:38 +0100
Message-ID: <20130912220138.GY29403@sirena.org.uk>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan>
 <522FC0DC.9030708@intel.com>
 <87eh8trbob.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="579wq2TFqgNMeWbK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87eh8trbob.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--579wq2TFqgNMeWbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 02:07:48PM -0700, Kevin Hilman wrote:

> IMO, this decision belongs to the PM domain, not to the core.  We have
> an established legacy with the current core default (auto) and changing
> that means lots of breakage.

Yup.

> The "forbid by default" can just as easily be handled in the PM domain
> for the group of devices that need it, so why not do it there?

Or at the device level - I'd guess most I2C devices won't end up in a
domain outside of ACPI.  Mika's latest version of the patches address
this issue, the default is left alone.

--579wq2TFqgNMeWbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMjm/AAoJELSic+t+oim9+QEP/0k8z1eX7gkWT8LZAirKrNCV
bIrjbPcaafu6bZZWM3jZYmM6Lv7/OzHDoPlBIBzYVUfmqnAavjt/XGIrUV1DEmN3
RCTYLDOIVvci7CAt94kOcNlcEQymU3iLbPFYaMNFKUQMl2VE96S23MVbZQBuY/21
2g0kjU/dE05/k6fwe0kH43FnQSrMg3pZ6iQjpEC4HvwPLReJwvDoMylJEX+dUCrY
nDhrhG+G3/pJA6dJ1FlHatuaDybQEDO9B4rhGratsRfCro8I74ETKdnaOJL0ls7r
mbNb7cWJ88G4Xfn68P8kkyI9ZsbvBrcjFUXHIaxMxFZD/EKiE66+0ZuCC5D5MPmT
fvwruMvzAIfXqYIhquazx183VipEVfZYNMUh35Q/0XTx2d+lUcB3dYMmmsl/r+1C
n38IXGiv+vOrXpt6AREcJj6Kdsy2atqNyl7a2/y6/mhW9ZEbsHykgm4tSobLo+6v
+plONpdkTuQ7rEPnk7moqw7k0UKaIgzpDgGCA06/XIa3CAbcw8t9NY8gsiQ5cyr0
88lsjorpVi1OmpJT/uyNVefIF4n9JAYkuh9Uc4NheCCwKsMB4K1H/zLxGCav9eYJ
m1zgZXkcY/TcE3g9KWn5cD0G2ZIDd7oQpXKdZ7YBAgyZox1mq6obVwIffO3Gt5+X
H6/TyjtLAcnfR+JgGHlX
=W0wz
-----END PGP SIGNATURE-----

--579wq2TFqgNMeWbK--
