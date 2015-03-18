From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C Slave support - how to use it?
Date: Wed, 18 Mar 2015 07:31:24 +0100
Message-ID: <20150318063124.GA916@katana>
References: <201503180014.08870.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201503180014.08870.PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter =?utf-8?B?SMO8d2U=?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think the I2C slave support is an excellent feature you added to Linux =
=20

Thanks!

>=20
> --> the slave-eeprom file mentioned here is not present.
> https://marc.info/?l=3Dlinux-i2c&m=3D142616417313963&w=3D4

Does your I2C bus driver have slave support? In upstream, this is only
the Renesas R-Car driver so far. Check the 'Developer manual' to find
out what is needed.


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCRu8AAoJEBQN5MwUoCm2TRoQAIUo8zQ5+KljkL8ZVE81jPLW
ZcOgYwzHWP9JWhH7+zvv8HYm7ylto5qYNmCeJLyqIqRySc9WfPL2HZiJB/UXUzET
60lMaoEFQLtQ3PFVoN7JMkypLYnuHcG4KEsIJoRe6elJojN202r6vuMBqL1LrC/t
zttfKy1nX25ecSF8WxigYx2dpY9SkNHyaeX0hgSngvotamSJ6Kick3Y1zzcvbrs2
zyFWjjAuy1wopGAZ/ys6Yig0j15cvzpmL38gwSRbIv9FZV2oKHGCwuoYF+L+Qty2
GgvyQ6gYCJLE72fb75co6Ss2+otXEsq8gRZ0GdIU07Q4DW0INVrf/0ktY4gWkVf4
t2C6FCsuosCrCmkumgPcCuz4CKfkwdmt3aBUXZwoKWef7lNevGH5AcGGk8/uA5S4
KOrqqaElTK/Ajb1w5cajVc1YKzrY1IdJbc8I72UMruNPswTq2xxkY4HmBZnqCiKK
cCFcJKd6ACL/j+tJ9i/eouG5/liz+GqcszMcJV7GZ1rLm2zfS9JGswcfh4H2QK7z
wf5Lzzss5hax6abxb/VVbO/cs1NCzR9FGhtauC2mIYo8FDq4ehKPLYvk8Nd5Cv4K
3HVAN6S21/2fD7ONEPvk3XB9SF41VljAfbKPFF3oG7AWaQl7KYbaS1k1Q1DP/1gs
W8DnPzFga/qONk1Vedp3
=qtX3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
