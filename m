From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv6 00/11] i2c: Relax mandatory I2C ID table passing
Date: Mon, 7 Nov 2016 01:07:34 +0100
Message-ID: <20161107000734.GA1442@katana>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As such, in this series I have extended i2c_of_match_device_strip_vendor
> so that it will also perform a search against a full compatible string
> for the matching process. This was not done by the core OF framework as
> the sysfs interface does not create an of_node to match against. If so
> desired, this function could now be renamed to i2c_of_match_device_sysfs

Looks good from a glimpse. Now I want to test, but I can't apply to
v4.9-rc3. What is your base? Is there a branch available? Or could you
even resend, rebased with the sysfs_streq() change applied?


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYH8XFAAoJEBQN5MwUoCm24ToQAIiYz0KAgmhP2bTsjOxbbeqy
9e9RL/hY3ZVJzyQgtNFZAVso2oCti/Dmjgdyd2KEOaF/mGytqMNJwIZG0x0SRe0n
j2S6aJ07CJPddJn61nZRT8/c6xZmmU7WecNlgNO3Z31FLNqN86hzhGnJzet5lm50
+QXQJbWNgcqm2gIF0+Shz82PPJj8CS8W/mLFAikT3QfsRBsFthJkhJg9bLCP9Krk
NAWUd7SLbre1MFMDCzEazDS+Rmx7hXZU3CwSe+JWo6Owdc2kME6BMkiLBxfkZtPl
uEdMrn781CN1Cm4Gke2bcKcyNkWKJyDbylJ/7Q0GJ1Cp0JsvoT0NkKnYl39OxbQs
wzR7mX1AiWei9TNwNyRoBOMG/tI/jlCXGzcLy+1ci8TX/YZ1iE/T482lMuEBOizW
jlvKRsE2AIrbwPqkKE4xHBECnDJjmUY6ZCt5UMQEKmwbFqhBSAx6c+0rMvrX8V1U
m0GeGuLq06zqX2ityOgx5AwLRJ4PdEtQPVTEPaBRFMY0zPxdr+sKbxcLRxvHE51i
aUh19vwwjClt3oo5HZ2LdmUFXDRH8wDqcVtDpws9YTDngc2NR4YFan6sUw9t6y1W
6QCFH/gwXVmEIICJuPpVCwxm7wNHgM9+XP+I3K2L7/HvZ3xEOJD/VgEH5cARnoqz
E2GzlH/mKGuYcHoTDsZk
=elix
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
