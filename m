From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Tue, 29 Aug 2017 23:00:48 +0200
Message-ID: <20170829210048.mqcyep22tqn7t65l@ninjato>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
 <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
 <20170829201826.htdia6olxs3j5k66@ninjato>
 <3cc3df29-b2b5-4a2a-fce4-a9d2302fee54@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xxyyjbdsudeshzx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46441 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbdH2VAt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 17:00:49 -0400
Content-Disposition: inline
In-Reply-To: <3cc3df29-b2b5-4a2a-fce4-a9d2302fee54@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org


--7xxyyjbdsudeshzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The speed comes from an ACPI entry describing an i2c client,
> any compliant i2c client must at least support 100KHz, right ?

Well, due to flaky board design, you may not be able to utilize the max
speed because of interferences etc even if the devices would support it.
Such knowledge of flaky boards could be encoded in the ACPI tables, or?
But probably not in the client device, hmmm...

> Alternatively I could wrap the entire round-down for loop in
> an if (acpi_speed) {} block.

I don't know enough about real-world ACPI tables to suggest a best
practice here. I just wanted to add that busses < 100 kHz are legal from
how I read the specs.

Oh well, Jarkko liked the patch, so let's all sleep over this patch and
if nothing else comes up, I'll apply it tomorrow or so...


--7xxyyjbdsudeshzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlml1foACgkQFA3kzBSg
KbZjSRAAsKsTnwW0qMkwB+kYa27l400A+G3P8ySPQoxDFDhPO6K0TIKPjqi4OLx4
he0n56xae52nv7n9X6HFs+DrjlXrvCLNE/IvVkDLjGOzMLyzF8b1F7zNVjsJ4DoT
d3t8DhFemadtNZaqNIh6+NquxIg5mDkXCwt8ARxXzNXwYn8rRld+/7khfJ8fpWqR
3OcPCFz9cT41Buj3Hfv5RB3vtmlHwTL8zMRbjRI0+KHCfPs8I3SmPFlsFQEgZz7v
nYk5QBEyd7RJBVh1OBcJC2nA4A3o7FiBr+U76Y8ki6uIcOkHm4dk95V6Zab5ixVS
6nYTyzBSJTHZT3cAEdXEotjsxUGLnOJ111OVvjYBcF1Oh7/sEdpJYCTmTxYuR6xA
dzKKJ3TK3D9JvHGg0yFRWcSMS4HRNh6s7ZHKNrJ1LEThhi0nnwo95m0r5K1NDAAd
9rx197sNlyZYLfaK9v9frjqe42QH9cCA+PDucQxlOGNiaQGofLxJUGLUqxM/SqRy
rbd6nGm/0XMz4ma/OwMSkRc2a5qZkAR3o+nDivJKSxeHVOzRNlylPKmINXLNclSk
sA/Xdy54dFnJARalcEZi7OLOBCZbpBlZ14WqEn7QUYCNld/VqFq5Pknd4K3mOiL+
wiX7qvAWwSvrEC88fdtjrQKmkP9rXHUQjiG5VhYRuMxbvcsOiNg=
=qk4r
-----END PGP SIGNATURE-----

--7xxyyjbdsudeshzx--
