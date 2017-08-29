From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Tue, 29 Aug 2017 22:08:30 +0200
Message-ID: <20170829200830.op73cdkwjmhrht3k@ninjato>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
 <20170814193105.cosdlbf5gypazlzn@ninjato>
 <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
 <20170829102225.7yjh52hivygbdbc7@ninjato>
 <20170829113558.GA5406@hmswarspite.think-freely.org>
 <20170829114933.7ymoci5snjicuvuu@ninjato>
 <VI1PR0401MB23035B5367515C92CA6820E7BB9F0@VI1PR0401MB2303.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="orqjx5v6vks5wepj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46158 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdH2UId (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 16:08:33 -0400
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB23035B5367515C92CA6820E7BB9F0@VI1PR0401MB2303.eurprd04.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dan Priamo <danp@adiengineering.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Steve Douthit <stephend@adiengineering.com>, "seth.heasley@intel.com" <seth.heasley@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--orqjx5v6vks5wepj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> We are using Linux stable kernel version 4.4.y and would like to see
> these changes included in that version. So once these patches are
> merged in, can they be tagged for other Linux stable kernel releases
> to pick up these changes?

Okay, since I haven't pushed out yet, I can re-apply the bugfix to
for-current and add the stable tag to it.



--orqjx5v6vks5wepj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlyboACgkQFA3kzBSg
KbaCPg//Wk7cS22j3GOAtu0Y7maIrBmdao4pGCPoqCd5ipd/iq3/5eg1I96AjXEk
DcG30gvxbczUjznZSJdpWszVMTUOkd9mXIb/rh+2foEysFuv3II14rxFgN3h+Z/w
Bnx4TJuVa9h17JrFAcrC3MTsyXzNaD3h4OjbNjpR0G1nLn6wab6ElEjMJ7JzgRGg
YdFsnYC+k3x5sAm9ZKkHPuGA1ZsCWNqjYIS0EpngKoixNqsUZ3MUxD1xyVB/YVXf
IpC2MOHFTX5ZtYHRYA4GOAep5B9IqKlf9UG1K4nUnaUSQwk8zLOy+1+djFKNg8Fs
OlHw9hncP0crlcxLwMROxcUr+st+kyGRT+zbimOEISnTumxNPieGLYdUAlkGXP+X
jv06iXL/JdzpxIse6ojTpu/Ic9tLOBjhwSMJHugU8QIl5rwS7Z0WVfrj3tai4/yh
hh5QxCPTmB0xn6clDzDOerRM0GGLxBx8g6iwebQckDaYjlk8iNGZk8uLgJZJ4qQz
+zak623Y2EAY7ZTyrh6FEMdmNgyCeRITKJQiSEQ8yocl+X9peXx9tDEKObKGGtTA
6rSzUJ5vsKu6JqdVg1YE4KSeoym0S315yTjQ++Ws5iPFQeY1EyQvUDWeO92Ljdwa
39yFGQ8ZzJGtmetYtI6q5nncya0Vi1AGZBHZR4bQOvRGVWMUAv8=
=XiZT
-----END PGP SIGNATURE-----

--orqjx5v6vks5wepj--
