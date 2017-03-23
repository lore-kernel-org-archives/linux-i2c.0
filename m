From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 04/10] i2c: meson: use i2c core for DT clock-frequency
 parsing
Date: Thu, 23 Mar 2017 21:33:09 +0100
Message-ID: <20170323203309.op7jepa4be2mwkop@ninjato>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
 <96c1b005-063e-ae22-ded4-fbb0b023f02b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nos2t62z74fi5ip"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40966 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbdCWUdM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:33:12 -0400
Content-Disposition: inline
In-Reply-To: <96c1b005-063e-ae22-ded4-fbb0b023f02b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org


--4nos2t62z74fi5ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +- i2c-scl-falling-time-ns
> +  Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
> +  specification.
> +
> +- i2c-scl-internal-delay-ns
> +  Number of nanoseconds the IP core additionally needs to setup SCL.
> +
> +- i2c-scl-rising-time-ns
> +  Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
> +  specification.
> +
> +- i2c-sda-falling-time-ns
> +  Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
> +  specification.

Those are not used currently. Can the driver be updated to make use of
them? Otherwise, we might just skip this section.


--4nos2t62z74fi5ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUMQUACgkQFA3kzBSg
KbYKwQ/+KXhjC+pRWlutSufQXZY0DYKJRh1M+fdvndX2aJ3VG1RCN6gPxBInxdoC
aAXlKx14OUWVP0zIAylYIjXameVoaXk91wcygZOtdVJdfLDzT7nt6/IK3Y9iVOQn
+9AmGFQ8t8Z/3+idu8z680RxjpxjiQqEgWWqpb9TUxFugyLvQ+P63mPN6WIoJjoX
vuQj2Fxz7WAm9BszbuMF0poV1JpTtLwUzgJfZMBrGWLWfn5SXjDknzoc/cVtEx9i
i6rQrMqtJd7WKDuNYEA3OolFWkQXf3ooM7eQEt1Z3Gjw+nzuoB7So4+FutZdrdjI
y88qq82VSske2hvvKPsQFsOk0pL3ELuqz/Dot45ze7kgG+SMj3mRtzRBgLxwC4+J
9QsG96iJKHWb3QZGrNTlxJ6d3CWHs7cMkDZxldiY0DhqjeaNGe6vcZLPTThudREw
35Z139WryfrSA+ZWQ5J9Acp5GtA5aJYIQhVhE6Tpeq8VjXLHSaM4U7BOPNMetaVB
o2tefO1keg1MkIQtliOh5VXV3ZQVXYndP8/L+5g+fdkrrWLYChRQuVwIViJcfC/o
z//Oi/q61i1HDw3O3E4ACvy/W89OpS6hpfB3E3SYESLrcQLeaWEDonZNl+sSasXT
HiigQkoUFyACBAT5ZoTw/G4M+V6PMZsdsIJwUMFAZRyyMsPVCoE=
=SmJx
-----END PGP SIGNATURE-----

--4nos2t62z74fi5ip--
