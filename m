From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 12/15] drivers/regulator: ab8500: Split up probe() into
 manageable pieces
Date: Mon, 7 May 2012 17:58:38 +0100
Message-ID: <20120507165838.GN17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-13-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336155805-18554-13-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2012 at 07:23:22PM +0100, Lee Jones wrote:
> ab8500's probe() function is becoming quite large, so in the lead
> up to Device Tree enablement which will fork the thread of execution

This doesn't apply against current regulator code.  Please also at least
try to use changelogs that match the subsystem you're submitting
against.

--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPp/83AAoJEBus8iNuMP3dFpsP/1X8YSt8OVClK4YGpQrimK+j
G2A80c/ezVdtr5CAQwf/KcEUB7UJMZ/0JNJN5AlJKFPGkdydCumRfYKfPDBXqVGS
y0xu/Ix9noQzEApdtjMjnoiWWedad8O+2K+q5ZEIkqPv7j4On5smyVm0b5WqYp9T
NhRA7bJyChJ4W5yPHL0pCnnjiyvh7tKdRfM0fvo3Wj7z2UgBGfFgX6KFXplaAMgV
1PYPub6cP+0Wr6uupttZi/tVZc3KwXgv6w5cW1pDFHV3fKpCTi/FatvasWE0jt2Q
P/fKH4ZH0I/pO43ZZ0PH0bGnW/MQtrR/ya1iX9w83AkqUdbbLeHKHPmXXMy0eRfD
+vBdHgP2pIg3kNxKpIkfOZKOVwFNEzQWACdTJXjHfo9vcee2WCRWQiWleqW7g20E
jVn3hdVUdJHkeMrqqS1c0YjqfbWikoYZj5G9abHf2/KzXf7pZg3A52Uh1q3QpjKN
32/mPJYE/t6AphbJEu/zBr8USg4/PqX7WdzPZVZiFTWA2XybopHvjTXxarBRrkRK
GB5/VfEY6DpVHp11oemLm3ZONwhwRIXn+x7mZEklQ/64K/UBvZSJLoFq28aqStUB
k1LdwD0jZ0pQtzoCf5Ka96A8CMIZ8xa9u4QBHjFlQTJ/OMpLVIoQXWfRvnGE6lEK
tsfWpPraG2p4L/vXAmLh
=U/lV
-----END PGP SIGNATURE-----

--LvAn5G4Ewe70kJ1i--
