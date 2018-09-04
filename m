From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i801: fix DNV's SMBCTRL register offset
Date: Tue, 4 Sep 2018 18:04:46 +0200
Message-ID: <20180904160446.GB5000@kunai>
References: <20180903090953.7d3e677f@endymion>
 <20180903082457.26143-1-felipe.balbi@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180903082457.26143-1-felipe.balbi@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 11:24:57AM +0300, Felipe Balbi wrote:
> DNV's iTCO is slightly different with SMBCTRL sitting at a differnt
> offset when compared to all other devices. Let's fix so that we can
> properly use iTCO watchdog.
>=20
> Fixes: 84d7f2ebd70d ("i2c: i801: Add support for Intel DNV")
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Applied to for-current, thanks!


--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluOrRkACgkQFA3kzBSg
KbbL5g/+MARWY+RlwufP/DBF6LFwRTAH0yEL9XmEFem9imMz90NuCdqgfUeHywKk
UOGOvyDPqh9vihuncmXJcWHLUg2e8D1nbSIJ/RZoAIam9QIahJ6jO2F81bSV6m0K
ILMVWPzWgxVxCssibF7ETO1dVMGN6ZWLlaIZtXEkivILcT8RJ5JJKsNctQ44l764
8kura3FT29xm2NFDBKIwKZKeZzvfKd07Yir4k9DTydJ+VcKAqas6pvfkbuUFyACF
U/RfC6BE7Q80GDAtgwO4cs0+euzxtXLVuJ8lFxi4pk5IiJAIf3hh3NPJ0Akbt3jF
OEI0hVkp7S2aqRvKiMFGDB18aG94NRHbSKggmFBJkzM4IMdOwdOScIYd3AZswg7B
2g3+EROvbUwuhhUJGqrxfqae5fP4h79bJwO/kdXKZ9lkxWU0M29L6AtsTxi16wUq
RWmOSNjpigvkV310VgnBVaLlAvIVaxZI9f4ZlWiD4hCz+ZOfy1GNhoxzJryRNqky
Wx1yFROMyRX/hbZcVyJcCgfkZNU42snbm9mbREfrDtzrroLF9v8PBvk+pyMo7/PJ
xRlPvSGf8tPAHAMVjR8Kv5Jo0O2Lars3pqIrpi2VoDZ0K3YUMxaaAQxu50RYSvYX
Q6v5J/Kcy64axXcaL5Q4zHzkf7hxlopWywacC/6ftLCgnkuL9NM=
=V2/s
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
