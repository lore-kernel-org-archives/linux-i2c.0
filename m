From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Sat, 18 Jun 2016 16:04:21 +0200
Message-ID: <20160618140420.GA1430@tetsubishi>
References: <1464077343-1665-1-git-send-email-tanmay.jagdale@broadcom.com>
 <1464952474-15714-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53955 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbcFROE2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 18 Jun 2016 10:04:28 -0400
Content-Disposition: inline
In-Reply-To: <1464952474-15714-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>  #include <linux/module.h>
> +#include <linux/acpi.h>
>  #include <linux/platform_device.h>

Keep the includes sorted, please.


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZVTkAAoJEBQN5MwUoCm2cbUP/2PI9EeuK4LFDQfaRbwh8+Qp
Nb3uLGM/KevZZ0Ug2Pc35Fwljb2fCybTWFf/DjuRiH3Ey7XsF/Bzs4jFOJq0VlP8
4rom8rPkZeOl4HNlg2nvIQ7LlsCJDY+ClMUsfX5v296PCd7CDGPyZJtE9WyQA/rs
M1kgpq37KeN21pDcR5enEHOVR3Dc7ddB5mP8x3P6ZkFpq2aFIX926JklousFoG81
/GWm4COVTWwCR8Kc8ep/IzZWgDKHPWwt7ODevNL475FbJc74B9z4Mt8vfMJtKEBX
J/iyCE8GN9mm4ewJtHw/ynu9/61MKSWq4ky/96xc2yacYCnzUn6Pk1W3RkMV8Pdn
ZT9YvBvNRqu+BRxlJBCK+PuI6Ud6O7NRozoEr7TGybpl3Caa2yoOJCfish8HaZH3
c1NG6RjatrqUN0skBLlGyGlMLbtd7jlM2wMZk3ZTdcRB8Q55ychMn5f+3FW9BGAV
pCTIoAQD9jVYxqhkVi2SpzOzlAWW8mC8tiaNUeCRf+JTsnR/g6+IwsOmZl2WfJTo
bjrWe7KB84zG064Vpmz27wb7iGFI3MbJgujjVzFQ6RJtclQoVs4uxN9dvytePYkc
sLMA2MHbL+WDOvKofX9YP5QLHxsNV1CWrc2MBtvQsBEbjC3ij1dfaW5sGXqsaMst
6B1xconV9sarcCheVz//
=mJnu
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
