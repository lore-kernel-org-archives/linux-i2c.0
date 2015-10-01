From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Thu, 1 Oct 2015 22:37:44 +0200
Message-ID: <20151001203744.GA7514@katana>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47233 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbbJAUh5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 1 Oct 2015 16:37:57 -0400
Content-Disposition: inline
In-Reply-To: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is for discussion so I didn't cc stable@vger.kernel.org yet. I was
> thinking would it work if we'd keep the stable name but have an another
> symlink in /sys/bus/i2c/devices/ that uses "x-00yz" name. However this
> feels ill-use of devices directory and probably causes more troubles
> elsewhere.

Do you foresee troubles already? I am still in favour of a symlink.


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDZmYAAoJEBQN5MwUoCm25hkP/3+U2dMOIHZGya4yUggP8AYZ
YF4qLzQtFL5l6FU6v+JJKBtS0eTKO7zTa32xF+ZoehMzBxZqLJY8bszneh3v1+ig
NowxWNTgRHe4phdd0OWYEk25iL3AMfRFO5LMn9JkbsdIv7FGGwIzx7vqPJQS2n7j
L7YW2uAs1RwjrGKBnhjID/+40fBT8c2U2GjXiQUt6YxndUIMD7O9IchfVgcN4AuM
i3eDxnPtJSGb8icBTLJLKTHKftM+NtgO6VOuZz7TTQTyQPknjXK9srlCDjt57nGo
9nY9FIjAnSVwwioWJvOrxNOu+nocidwyTf8wwqvFZmmKzzByklpq9AI18Y7sa1GX
zWM7QK0dC9H+xjc1fuxfFNEp+/1q87ML3bbfiNSQWcrlU59RrsMouL47dnT3qS/t
70Tb3o+GfmoCIy7Vb/t400mFPWBNjYwkQ8iNqjTqclMghMFkZgXInH6tvzeZB2sU
IvfEy3gZL8qQ7YsZcyShkbzwL/JdTuob7B4AK+6nXUcrezCOvarJ/IS4iIojdwnh
4huTEGy2MlQjxhKThnaxodHzhU6DIvGcQTmivMZm7KEHg3FA8I3v347Ym59jUydp
9pzX7eA3j/vKgaloHbGmratapQwcQd7aTXeTBtZGllEDFZv68k/HV9EC4+10pp6v
ZsK8vK0wvQCcTyG7SSpE
=rE/C
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
