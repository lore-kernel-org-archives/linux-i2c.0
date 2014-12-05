From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Fri, 5 Dec 2014 18:49:07 +0100
Message-ID: <20141205174907.GA7025@katana>
References: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1417734625-13739-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20141205070313.GA1197@katana>
 <1417795398.1851.17.camel@spandruv-desktop.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417795398.1851.17.camel-hINH/TbAiWppyMZ9rn1DP+ejPoqOX1/hEvhb3Hwu1Ks@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > Since those two functions are only called once and don't encapsulate
> > much, I'd rather put the commands directly into the calling functions.
> Agree. I will move them to the caller and submit another version.
> I hope, I can still use reviewed-by tag, after this change.

If you only change my comments, then yes!


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgfASAAoJEBQN5MwUoCm2QgYP/1CUgRfIsxFnUlIaU5YgHmeI
cyTGRNZrsRo0533qEldJguA3ddJwffJWbQkseBg/kXQWMDxrCuPrvK/7ovUkoEXk
VifHEove9trq3uOGQNN5FTmaKpYTi4HDuDyOyAinMApzxkWQj6LqWXz4f7nHDtv/
WY3Qh3ddU6arx1+U5s2AAkXZzu4Q8rjR7EktIUL3tczC1ymc6Zm0HIxDLHDmqK1p
hj3v/XUQ9X6ELPqcNPXq51B0zVbL74NWPzoQCEXmTj204WL3akxdJyLYk2NevJJM
69FmsQVajEWQVEhjPiQ7sl4y7n7mUCqLn2O89yk4bYElfFpp3IsJxfMSUP6rdjRX
tPKMhiBdX0fYmkr+IXFsBAiMUdiYA2ukV9LF62OvuZSiytZDzMJKe/YEqqnKmMx7
Jvzcr9nk5Lig1aUbwzmOxV64mC/Nec8QkPf+7C/mrcUZ2PasgpKVepTkKMbKXlIV
8qRATGq2xtR354QMrXseT6L2DV8c6T7pzE+zjLzkkx1y2I0DiX+87+tuvUyCFE20
Qg5vUG5z6e++IqS+HD3v+wpdrcGDCqwvKYo+e5vbZvSJCT50SE3A6VGKCa5DGcyo
9WQ4EHggnLWI/JBkmnmNcKMArL2f0ROaSy0qbXuIDJs6l59TZ6Ee2G3mJGS6XR8c
CE6+okyAe2lgQv1fSPy3
=ztP7
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
