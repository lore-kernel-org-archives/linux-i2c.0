From: Wolfram Sang <wsa@the-dreams.de>
Subject: designware platdrv and runtime pm?
Date: Mon, 9 Nov 2015 22:15:04 +0100
Message-ID: <20151109211503.GA3793@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60543 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbKIVPJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 9 Nov 2015 16:15:09 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi guys,

while handling the merge conflict for the designware-platdrv, I noticed
an asymmetry in the runtime PM handling. Currently, code looks like
this:

	if (dev->pm_runtime_disabled) {
		pm_runtime_forbid(&pdev->dev);
	} else {
		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
		pm_runtime_use_autosuspend(&pdev->dev);
		pm_runtime_set_active(&pdev->dev);
		pm_runtime_enable(&pdev->dev);
	}

	r = i2c_dw_probe(dev);
	if (r) {
		pm_runtime_disable(&pdev->dev);
		return r;
	}

But shouldn't the above error path (and the remove path) also take
dev->pm_runtime_disabled into account and act accordingly?

Thanks,

   Wolfram


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQQzXAAoJEBQN5MwUoCm2qkoP/iy4FUhZVDJNmnAguh7L+kFt
wHXEX+sh906a2GS47r/LvhGTuBWR/PlOejvR/Mbvcq5htq0l8kwiCC2rJmZ8vBi6
d8OZ0VXVGNnOrkQGk0o+nuR8S+tKTbYVmCncRFHSUiuFXQ0yxkB2/wcqpFgcLayr
GTZnmHiLH/FWAJEh06Rc/YucoLl6lhzFekeo+dX+CoijIA4EJGbRY7FLkWN1vGmC
s9F7m/KseZHUqJ3HzTp386N3H2GQmcrFHHnaSAbyg2C1qbGmntailHDjbXE/Q4SL
SPcNdYLh2UjRjEP1h+hWEOp3SHQaEnAUmbPb7Lht/ve7//41N+sBK4z+q75SFoAL
5r2tmblT46z4unblAbBTSsDzvSp+ZwQTzaaqefNZ9sdPvyh9+rrlLX2/7Sp4wAy2
QBIKeANNjPNLa0/ElKdmUgOtgc21JeW6bZDyzzmGf/ltKQOQOWx/5bAq4lmQse2w
pUV6YS+2PFPLd/aphCNJmRgjpjve0gnCvopuLaYS2EW1q7IWZftPcBpp0AIWL7vf
jXFUPi7eux2iN6bbSBs/OqjA+47oVF6My+jS66jOBnYsqHEZPiavlQVFDc78Fohg
48PpM/sWxss5/E69GPFr6kvZqdRZlVEbZ1IO0o5opim2/YbMY4TpPwwDgsCd++Tt
M3CGtYpDEf6YJZ/OsAid
=0JR3
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
