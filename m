From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Tue, 25 Aug 2015 16:59:52 +0200
Message-ID: <20150825145952.GB4066@schokonusskuchen.bad>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150824132612.GA10078@katana>
 <2688486.RKUY9k7hgx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2688486.RKUY9k7hgx@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net
List-Id: linux-i2c@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In this particular case it looks like we need a mechanism to use the old
> naming scheme for hwmon and the new one for everything else or something
> similar.  I'm afraid I am not familiar enough with the i2c core to suggest
> anything specific ATM, though.

Well, it boils down to directory names in sysfs. So, to support both
naming schemes, I'd simply suggest symlinks.


--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJV3ILoAAoJEBQN5MwUoCm2fyEP/1HTcVpqaIxTyLHUJBABa/Kf
KntblSdjAR0sCmph29olzrXU8f7FunQ6I89KpQQD+DZiMCOOGzajB6wnzKu0uhQJ
gDuxsMgBLVLZIQF9Ib1PeZOH4V4dAtAsDKh1b6rNo1K06ySvUFQkl6e00ckCjUPU
gozksMR1KJah5JI6L6wNMgYd3FMQRtSYiIu90OO5pQ/01YHM3vvvflbv/Bf5LmhC
5SHcEjCI/Bhjkj6E8hzrAKkVZnS7mVIoGCFH7WL/mNTfYYdd5qdLAtM+FmEIEdTK
Tv3C3hFbFSdYctO7cBO19jq040RJmuVBcLhgP7lWE3CF1HCUH+fBH0Ry6Fe+kCgM
wnw89TBuP2DDLG9a3SQXPAK+EbRgGDv8RMNpMVxWCwNq4qd7okv5dzlb8vzgPJi6
ocbAyEtaCrXvL/uuFNNhkdp/V64CfY5lYZU1Igxxr0rdjRWrPetIr/E8BcJ6rh/b
Xaxs3nM7dQtxNpO7ra2lyFYjIOKwrricRZAKAY47SnC06i51hy13sCtJddYd7y0z
NSgc1cSR8TEF4Q4mVt3oc3iZ1gX2ywRcQKMKPWf/K6pkgp/+pt4CWLvY42uVK7jq
4ZWtG6uSw47HlCNIxMJu4kC+OQxS/AvUck5Xw/Wpt36FwFf6W+osSrnvXz0qV4NM
OvujY6lEvgHzo3NHPw0g
=yeoa
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
