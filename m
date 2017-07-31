From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 21:17:21 +0200
Message-ID: <20170731191721.GA1542@katana>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:36036 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdGaTRY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 15:17:24 -0400
Content-Disposition: inline
In-Reply-To: <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +This document is just a brief introduction to the I3C protocol and the concepts
> +it brings on the table. If you need more information, please refer to the MIPI
> +I3C specification.

I wish I could.

> +
> +Introduction
> +============
> +
> +The I3C (I-Cube-C) is a MIPI standardized protocol designed to overcome I2C

"Eye-three-See", according to:
http://eecatalog.com/sensors/2017/07/05/after-35-years-of-i2c-i3c-improves-capability-and-performance/

> +Backward compatibility with I2C devices
> +=======================================
> +
> +The I3C protocol has been designed to be backward compatible with I2C devices.
> +This backward compatibility allows one to connect a mix of I2C and I3C devices
> +on the same bus, though, in order to be really efficient, I2C devices should
> +be equipped with 50 ns spike filters.

I just found a slide which says I3C does not support clock stretching.
That should be mentioned here, too.


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/gj0ACgkQFA3kzBSg
KbZJzRAAldnFRC1tvImhgxmo3kHYW0c/2ICSWaj1rJd7sbypvsSY99wI5RtRwi1J
odmdukQQvdbfKMhIDv+XmV/cIlffSL9iQR+8/EUbjR0gnvFEM7JMZdmR+70qiUaT
h7hgfi+okPXmDr80ZBLTGsAje2cG5u7iiAFsvL1BOMrCc7ldNnY4o2L1f8rgL8OM
79dRV8MBGkBpyvs0H0ZiYtuOIoxYTL4X4zzl6RKlBmO9+n9pRMjjRD2oI2nlB7ZR
dFnHP7HRxykQAWoh9PJ62guyf1i2BH4ea990v/+3U5ugowZRWvtkrE7AQSa1V0To
F2AeApIBFaA1kszTZdqQc0Of8P0DYypPK+ko6qKYbpN1bX83ast1976NA27gOJ9i
ZdblFygMG2GZ7eTYD6pjPBHC6uZCyVl7jfXP5tFivpOkZA7RqzfeZidD+3l/4m/B
noC4XAznWSikUqpiRdJRUzX225/JV08K10EK4HRof58veQL4kgPCstFXoElp42PG
wFQwTYvqJJtELpcMSnjJPLfuCcHq6HQvuoCHqtTktpg/xXDvPb9vNyYupU5EA/C4
Q8QllvzUL1cEOoGCNtzYdNPuk9KfGfzRO4cdiSy6hNDWGgmt0xUdyD7lrzAOHk9V
pIk88FzLUixTuNYRqMkmRybw187dkCiEdl0aVQNQyiJESikqX0I=
=Ll99
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
