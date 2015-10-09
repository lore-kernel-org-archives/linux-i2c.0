From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Fri, 9 Oct 2015 22:47:13 +0100
Message-ID: <20151009214712.GD1481@katana>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20151001203744.GA7514@katana>
 <560E4DF4.4000901@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53875 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbbJIVr1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 9 Oct 2015 17:47:27 -0400
Content-Disposition: inline
In-Reply-To: <560E4DF4.4000901@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 12:27:16PM +0300, Jarkko Nikula wrote:
> On 10/01/2015 11:37 PM, Wolfram Sang wrote:
> >
> >>This is for discussion so I didn't cc stable@vger.kernel.org yet. I was
> >>thinking would it work if we'd keep the stable name but have an another
> >>symlink in /sys/bus/i2c/devices/ that uses "x-00yz" name. However this
> >>feels ill-use of devices directory and probably causes more troubles
> >>elsewhere.
> >
> >Do you foresee troubles already? I am still in favour of a symlink.
> >
> I haven't looked at this for a while but one problem was that devices/
> directory belongs to private structure of struct bus_type and in order to
> create a symlink there it needs to done in drivers/base/bus.c:
> bus_add_device() which felt quite hackish to me.

This is just a quick prototype and untested; but I did something similar
in the i2c-mux code:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e3c2f24f..715dca57ba68fd 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -970,13 +970,15 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
 {
 	struct acpi_device *adev =3D ACPI_COMPANION(&client->dev);
=20
-	if (adev) {
-		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
-		return;
-	}
-
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
 		     i2c_encode_flags_to_addr(client));
+
+	if (adev) {
+		char symlink_name[256];
+
+		snprintf(symlink_name, sizeof(symlink_name), "i2c-%s", acpi_dev_name(ade=
v));
+		sysfs_create_link(&client->dev.kobj, &adap->dev.kobj, symlink_name);
+	}
 }
=20
 /**

Shouldn't something like this be enough?


--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGDXgAAoJEBQN5MwUoCm2zF8P/AomW14UNxguuciGi/6UYf+F
H6NFbvQ3JRADGuakdI++0Jx2Q4MiSe3yX1E6BOIfT48NddgSKQFbrOomBLxXQmPo
0o044zbIWEeHY1R8olVGj6tO9TnEg/AR2flU9jcb9esuKvkLcO3NZPtnW/qwa0CM
iuZlKyIP4+dk+teyBS6d/8B7eKsLNxMYMRGhKKmo8EVS2GbksBctzlFsl+OfIt7c
BwqqkKvXDkdh837xzU7LLFYdyURI1Bpr+fow3hrH6AcU1OnnU5BazrNw80My+A7Y
K9ienrYGle16jmdBP8Aycr0YEQTtb3JBnWxZZYf0QnTzXAxilA2a9y7U67HNR9Kz
vTz+psQGC4lTdKrFAm3ZdF/7UvOaH/+riZd1ebpdhLCy/L4Qc9F0EBV+C4Wfk1B0
YyT25tSgRpp81kcrls2ZLQOfWMEjBE/kA2SK/q8MCgaATcc0jUnbR5ZPckXwoZvy
eDUQ37E70w10Fg+EAWUCwPB2OrPMCQErKDjA6CWO8RVuMVHGfpctm2ixLOCU2FUH
9eJmpaj60VZuEzIpvjpYNKw/xfO65KAZSmX4e3nWhqfoH4LPUJcZb/5oXv6+XhKC
aJD3enuBopvKiSiL6u/1RwLbOv0hByEyv4pXVQ39OTTb3N7h/IZNiVRVG9lOvTJo
rzlB6Arn1uP/nBD/ACjF
=g8tF
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
