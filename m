From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/3] i2c: Hookup typec power-negotation to the PMIC
 and charger
Date: Mon, 4 Sep 2017 15:56:14 +0200
Message-ID: <20170904135614.w3v3yvrrqructa37@ninjato>
References: <20170903124156.7440-1-hdegoede@redhat.com>
 <20170904045645.fb6scegrypdodvfl@ninjato>
 <be26a8cd-e089-0997-2438-5f12ecd02988@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="awn2vh3ydoalziol"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38754 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbdIDN4R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Sep 2017 09:56:17 -0400
Content-Disposition: inline
In-Reply-To: <be26a8cd-e089-0997-2438-5f12ecd02988@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--awn2vh3ydoalziol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've some other patches pending which require further changes to the
> intel_cht_int33fe driver (*), so I think it would be best if the last
> patch got merged through the platform/x86 tree. The dependencies
> between patch 2-3 are runtime only (and not fatal if missing, just
> inconvenient) so merging this to 2 separate trees should be fine
> as long as both patches get merged for 4.15.

OK. So, I'll just look at the first two patches. You'll know when I done
this.


--awn2vh3ydoalziol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmtW3kACgkQFA3kzBSg
KbaFNg/8DR19caCyAyHytZFcO/YvcIWTHNKLqR/2ARE+aRz1uy2aJpkUfMpcg2nP
oMZXJ5Uyyd/pCL05lZXD7+WLDJk71w7SZwXunpUNB3coSkrV7JxBmelWfKk3aurF
WhXUVL8omJrqM2SCnNq4TNnwRgvjGrVyOD3qKzljDGjc0uG5XTOgNHimNYNfnpwK
keWifu/kAiIiaxy+E8cTON560CiVGglbYBJ5FdbP3zAi0cZXiF+FSe/m9RlIO/HE
+p4Z4BFri0Kc0feCi9Uaf4VLOWRE+NdiAFPCrkOEFxfHTdcFqBiyFDW7zNN+E3T7
mZs97JsL52qbZFNT8LCrauauh/PD0/oUr7pdaNdyByK7HwdhJ1jsxpYtRYamsJPm
P18SDV4Xc9GXfL8Upr+GkwyTqGmjG32K10E2tUJEAIVyCd/K+bVk0gLyjwup9KAY
KyKNtjuRr8iIqk5m1x58TjgA0TKv0OO1EHHhuGQFAMGsQOpLpCCOyENdSUGFHOYF
+SsnhOhY5IK1tQwu10VjvtvU2a81fZDYJPIZ520ZhMIe9wenMxKEpuj3YYvVM2GJ
zhrNQGc2hxgRO2KERNVcTxyO7ykIF2yhKVRv/0niwO9sVufZxpJ9EfXuIXU8wblt
lriq+2X9Go87hToFRPHinzCnL5w7+VNfk0MRHBDv4XTO754Ws2Q=
=GaLw
-----END PGP SIGNATURE-----

--awn2vh3ydoalziol--
