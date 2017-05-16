From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c-mux for 4.12-rc2
Date: Tue, 16 May 2017 19:06:29 +0200
Message-ID: <20170516170629.gn55etnp3pdoyfg4@ninjato>
References: <2ee240a4-6031-3d80-f850-daff4b0182bf@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yg2uwd4mwilks3gb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35406 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbdEPRGc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 13:06:32 -0400
Content-Disposition: inline
In-Reply-To: <2ee240a4-6031-3d80-f850-daff4b0182bf@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--yg2uwd4mwilks3gb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 06:56:07PM +0200, Peter Rosin wrote:
> Wolfram,
>=20
> This fixes an old bug in resource cleanup on failure in i2c-mux-reg and a
> new log spamming bug from this merge window in the i2c-mux core.
>=20
> Please pull.
>=20
> Cheers,
> peda
>=20
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43=
f6:
>=20
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>=20
> are available in the git repository at:
>=20
>   https://github.com/peda-r/i2c-mux.git i2c-mux/for-current
>=20
> for you to fetch changes up to 9fce894d03a98ec8e8e8106a964644633d2772ee:
>=20
>   i2c: mux: only print failure message on error (2017-05-15 18:49:11 +020=
0)
>=20

Applied to for-current, thanks!


--yg2uwd4mwilks3gb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbMZEACgkQFA3kzBSg
Kba9Xw//d5QC62GLTRE7NGVRzhzXj6rAbuQq8uzpb91v+dKmiwgwqs3yn6h5OtXc
M/7Ki+DfQgrDe6MD71vr5UKsnETJqD+oyHc3gAmZRlWCrPlaM0wjPK46S3Gs3BKZ
YgPQI0x9BcNYDEnJ4L6RH5p44yXaQ5kuH/8zmrj9okJiuO+2q8rWdyah0ZzCd2R0
31xPwQP1UD40lolZhqmnf4WYRMqOKQfhxQR81RT+ebLC2FO9TldDjfdvR+sXGJML
Deux9/NtVLdBgO6ETsNSU5NNYI6hKSaSn0mQjQsOSa1kyz4wagpz55rxoML/evrY
5p7d4rQKlGkanqFGsgHRouKRFz072Kqyoc5tJJTZlMbKX/GIRDlurDZyPCzXVROC
KREUXtnkA8TXPr+OuqtNaMIrmXj+NYbXKn4SCRV6vU0Kq4yG1mC2SlQQeA/qPHnW
c10XmCEBTw2zpXMrig9q2tz9UbivfuumJEkDClHuzW46fGO5a6EZhVtXF9HJMxsV
wKwe8r9fsV8vGj9iUkvBuGNAIhOcRgAQ1l26snVW9k/yhfvC6F9x/JUTD9cENVQ9
iGP3pqIcW7VON2/1SXfW7laEfik2qOSB++ZDqE2sZIadwtGIGtspxhbtrkNVQXJM
kidYw+ar+haqPARKQ1OI7WJKmFnfmSoceL3IOjf42K1/5kyf2UU=
=a8bQ
-----END PGP SIGNATURE-----

--yg2uwd4mwilks3gb--
