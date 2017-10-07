From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Sat, 7 Oct 2017 10:14:26 +0200
Message-ID: <20171007081426.inlxjb4zevybkai6@ninjato>
References: <20171002124519.GA13496@leonis.localdomain>
 <20171005124133.7ue727bib2mlpnyy@ninjato>
 <20171005141311.GA8565@leonis.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7eenpfsu7pz52tn5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46229 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbdJGIO2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 7 Oct 2017 04:14:28 -0400
Content-Disposition: inline
In-Reply-To: <20171005141311.GA8565@leonis.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pontus Andersson <epontan@gmail.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Stephen Douthit <stephend@adiengineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--7eenpfsu7pz52tn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thank you! Is it safe to asume it will be backported to 4.4 stable
> branch and upwards as the problematic commit did (once in mainline)?

Yes, it has a Fixes: and a stable tag. That should do.

> > Might have been good to CC the patch author of the problematic commit,
> > too.
>=20
> Yes, of course! Stephen is CC now at least (kept the commit message
> quoted at his convenience).

So, I'll wait for his tests and then send it to Linus ASAP. I think it
should be in rc5.


--7eenpfsu7pz52tn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnYjN4ACgkQFA3kzBSg
KbaHYxAApRSTQJfWuy7tThwj0mNDv78vEfq1BSr8X8CqRaAGg+yNLmyHg5GD2RVm
VuCQQqT17bN2FfZxloyuZy86QSjhtNjzhS/R5P3MX65ibZnEDzh/gQvFsqYYVLZ6
qKQ7ca99AfhJMhcD/gZUnDovB3qAQDUD1VWrYhsgky2zYPw/s6/DatNpbXaAE/Ft
bI7QxeRegcOgpjsbFaFSLqT0e9FG2sftQgWkENQmqMC2FMP7a3P4BmK2acQdMKCY
v2wBpszTk1SU1/4tcl4HUhoLqI1Y1I/9fJw+K+f2QHfq4Kjh/F0YTXlNYQAMAFf0
fvIHNNQg2PtWT3Vecpn1f9BMm4ImnbBi1hNpiYMDBVoAXMtjU2uRLty0qL7j6sql
EOqLR5VDPUcv1wNmgl0SPfsY/QNO9FED19ciGIiMQd8zYI1YMncBZN5txH6FjJ4a
97Nk3cZ7CfmjmE4kIB4ieswQbpx0UFDyvyoO0CF3A3zZCe1P/FO/YX9wnvYv7k6t
kwPKZoGvYyNnKQ8qMfL2w60EBeLk7L/f9T6pDyWOinNqy12BIAOjR/cB1sMdi2w/
uBRFcdu0Us4uaY7uPc0trCDq7/Q23fEZ/010ktMCtsU2x9gaj+BY/cgOJHv9ntRC
rtSyr4RbVwqmrz257Gu4G8fS3jlWqt3wLIoWzXJ3j6omoSFap5Y=
=THDB
-----END PGP SIGNATURE-----

--7eenpfsu7pz52tn5--
