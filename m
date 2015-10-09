From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Fri, 9 Oct 2015 22:16:39 +0100
Message-ID: <20151009211636.GA1481@katana>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53698 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961AbbJIVSj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 9 Oct 2015 17:18:39 -0400
Content-Disposition: inline
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, javier@osg.samsung.com


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


As said to Kieran personally in Dublin, I want a verification that all
binding methods still work, especially runtime instantiation for drivers
without i2c_device_ids. Also, for the last patch, a verification should
be done if the drivers i2c_device_id hasn't been used meanwhile. I'd
also like to see 'probe_new' instead of 'probe2' for the new function
name. That should be it.

Thanks,

   Wolfram


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGC60AAoJEBQN5MwUoCm2mn8QAJ+5rshXl3pKNXvnWfpz2ZsM
847KBlA4Q6KDd5G+FdV3dp+13iH7UutpC+HaJM6rHS3kS+0CXhIyoxhjmZAuwnAy
vaSeWRcM29S9uOiK9iWYYTQbuKNNtfIH2dyPjOdkTPOz/mENqWD8Vf4aNrt8jVZq
5t/mlkZ0bSIltCVW5tk3YEI9/TZ6Y0elWJUzg6bYhr+Gi5L74p9BZ5FoOXxOuny1
5gkuTDzfqqLYShRC3bCr/IN9BZOpFLyqeDrImtrTbUYOOTREJwmX9/GqNZsWqzRf
0XqEShI9dN5VDw7cx9ytE/bqKoaGFX1Xn7kYGCO/8qjj3GDqMSfVEIDYSTdkZzac
AO8BBmmgXnccoRnaZzdCpCKAgBTnaDxSCQ3F2H6GQTjhSIimI3bB3NpgXmO6w87J
gStWk3IhbxtC8LG2ng29GLIZr+nQZhF/v/3c0lspBWbkUXWEk73ZY4EmGV3pmkn0
F9Vmh7ZISpm4+uGwlhnICDDGd3ZrG4OJhiADwY0h8NIXs12kGbkqHK4yR9Nvp4yO
NaLsQDeJD9sDW62bxH0jI0LeqvF8p/SQBrVfnxT5miFKckfF8tftgVYwsi6yLxuz
W1WHLaLH9cpd9dT70IC9mYhVP60UC6emlhofyLwXuUNwaP/l8oLzDn9Bf/h+Eys8
Yc/5NIwVdUuhPnN6E0Ch
=/odt
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
