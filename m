From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 08/19] i2c: octeon: Enable High-Level Controller
Date: Thu, 21 Apr 2016 15:55:25 +0200
Message-ID: <20160421135525.GB5566@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com>
 <20160420214354.GD1546@katana>
 <5717FAC3.6010406@caviumnetworks.com>
 <20160421134053.GB2623@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49352 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbcDUNze (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 09:55:34 -0400
Content-Disposition: inline
In-Reply-To: <20160421134053.GB2623@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think we should just drop the _interruptible_ and use
> wait_event_timeout. The same is already used in the octeon_i2c_wait().
> The 2ms timeout should not hurt anyone.

This is what most people have good experience with :)


--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGNvNAAoJEBQN5MwUoCm2R/IQAIimog+k6EQsS588FkItvWaz
ab7FL8eJzcBWZrNI8rFX0+hQMb7oDU1AwIRIZbOo7jdC0gG2+mdXoOKUdAxfLAT2
/gJxB/ea34HZ3PTF0vBjSHVBOgmyhKozZ6Hxq6pGvr2Z7276cbNcWvOW45fL9ai7
syJMEKRmsIZZZfMZGo1PkhoxeF2czvdHS6X38+X7VCrDyX/Nrs4g6Sw72nR0Dodc
W0O+keh22gYgiAsn96deajf5f7jNBzjAGoJOQatR9Wa1JOR6RiL+i8D5DtH79C/t
Qijnx6/kX5LKSMj3/SOw7sB8hFpe9jzT6qENwHRSoi7KM3HsRoyZxsVVDtlCREWk
+f2azA4T6isJinkhT6gE3QTQHO4u7hMv158GUfpIoBga7QKkUFbpNM6EFgaFGxPO
0KU5DWQM02Y5GgKz0WL3O1vjYXZTryt2ZsPfxGR3nR0yTY8qXs0T8wg8DBJJgXjJ
RskHbqCSLzYYXZko0TJLz+3Oph57M7OKIkGFss+g+/HWA/HYBpH5ugRJn9WJ76ra
iXn9XtXQ/fhiINHVZLYa/xDTty784VtZ9DSouZeqc9LBsGHrk+yx0lIazzh+c78r
yIA2qSfnVXw1pmZ4QMYaQa+Cr9ya3z6TMR4Z/twpbzw4U5Nl1TX/cwM4Snabs8IU
PHr85cIhW7++N9agNh2T
=Plru
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
