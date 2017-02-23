From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: thunderx: Replace pci_enable_msix()
Date: Thu, 23 Feb 2017 13:06:11 +0100
Message-ID: <20170223120611.2pb2duobiugbypak@ninjato>
References: <20170221130750.32277-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7h6bmpi3a3v6v6sq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47093 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750944AbdBWMGO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Feb 2017 07:06:14 -0500
Content-Disposition: inline
In-Reply-To: <20170221130750.32277-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--7h6bmpi3a3v6v6sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 02:07:50PM +0100, Jan Glauber wrote:
> Using pci_alloc_irq_vectors() instead of the deprecated
> pci_enable_msix() allows to remove the msix_entry from
> struct octeon_i2c and thus to get rid of the config symbol check.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next (will be in this merge window), thanks!


--7h6bmpi3a3v6v6sq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliu0DMACgkQFA3kzBSg
KbYC6A/+Pv9okrvc2lZ6As9nm7Sqhvwjv+1/iS5RjU3ab5113rTt7sPwhXdjH7aG
VJKpQoyHo+0EbHiUwI8zl3ZnQBpyobtetnccNy1Q61Qu9pASlNu++owcTodKRbg8
huDVHgLGJOE9mNaVSId7hnv/nU2iqT6V63unKi/3nzHOV5PLLvGKNSrqT8ptLDVK
wUlPjGZNLebDp8qYXrpKvnJ4pjB6iqSQYktC4PB3CCQ2Q6mJ6WD67iDbsplVR4KT
3Wevq0ThJD7gh44M5KtbBuuN2KcNMuMqmQmld1qd3JVmSogCladFRdqln3iDYjQT
mNzuXUZa8FIU5Val1j1ZUMuhw/7X5d7hYw1o6qcXKrlXx0c/nwVl7l8kAiNg07+k
iKD/cYhVBFNJu8wIKAdvvVVAs2SJYLGXkYdyUFQeMMEQPkAMwmKM12vXRDAGSNKE
jP+jzh4rR9r/cC5AqnNZ5ma+gFlFrdCu47Yg+tmWXD+cr7BAuwAuL0Dm5/THQJqo
44SvEUvV5KCeHSYqbOOlxQMpv37vaJ5MGR/6k+3oVG5iM5kTCfKY+t2Cp+IV4QM1
WwM+WHzZ0LSQuKyp6i/q3xU9PSzxPzVAL8p3QAjfN9z1yR6WdYbL1yJXZhQqmWFM
peJd/Kd0dOHDOIsczDNQPJ97BF6Mx706Ws9+2OOh8lomueJ1ATg=
=Y9zU
-----END PGP SIGNATURE-----

--7h6bmpi3a3v6v6sq--
