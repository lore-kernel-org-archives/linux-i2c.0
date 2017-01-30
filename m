From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: ensure state is restored after suspending
Date: Mon, 30 Jan 2017 18:44:04 +0100
Message-ID: <20170130174403.GA3282@tetsubishi>
References: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44408 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdA3RoI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Jan 2017 12:44:08 -0500
Content-Disposition: inline
In-Reply-To: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	at91_init_twi_bus(twi_dev);

Can't this function reinit the registers to the needed values? I am not
convinced that a cache will always reflect the proper state after
resume.


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYj3tjAAoJEBQN5MwUoCm2uNcP/2+hizkse10ydR3y8hiXjS/7
9rOaZExukAMlHrEiPqZz+sLsZGlkL+uX4FMEFHSTQECIc/qVd/OHHWvCiZSPvdQA
paEmtTwDjz6539OD+2AdmrsaGUtTiswc1DU4zlQqcaLpf6bjJylePlHE8zc5ufZN
9SNCNohq+sZXF05KJdYZhCE9NGsb67hL9cnrA8zKkbFoAtO7ukl4ZyvVXUfuG8Qh
yNDuqX/oAYGDXqB6mVsRcIxStT70QLd3MWidcy/t98ozwr0hngv9oDD8GN3sC5Tb
9UDhz2mr84eJmlA98kXqTbH+/vgQbpGDJg12iF7mDPsVHTel3BIR9eMa3o5GMyww
KJvYjf8fZqeC80CS3XD0a/JYYm1HWHKCuOK5bdvcbMLXxHafxBxvYLJ9Y4aAAFUx
tSM+0ozeuk+jje2yegjNbjsjDdlc/RzccSETSSLdCyHhK8Y9/CRHddHM/YrFbX0u
zprd3P8mX2xQdRBRlOpyo+3Un9curmyFvv951amfrqiGVVXii2u8JwFzzEHYlKVP
+dwkctm/VBmHjrEKf3KuwIeAPC29d7l66BmCBUeAVD8hNA4pxXnl+J4YfARpMDtF
o8GCAo6MFwFVwbXAGh7cWlfkuTLUDwm3orGt6/XZw2LOk9khkJQPWmwUmfesp/Uc
FOIjxUrrPZhJX7/Gr/Fz
=UNrK
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
