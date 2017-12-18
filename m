From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/3] i2c: core: add device-managed version of
 i2c_new_dummy
Date: Mon, 18 Dec 2017 21:30:42 +0100
Message-ID: <20171218203042.y6u7uvlhdlvozbkv@ninjato>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
 <ca47ea36-9b0a-c247-29f5-1c512f52e835@gmail.com>
 <CAMRc=MfWv0yZsLuF8wfqBK6cNoPkMoG6oNwa3ov9nRceJ1ykHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p3syauw3r37si37j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40588 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758331AbdLRUao (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Dec 2017 15:30:44 -0500
Content-Disposition: inline
In-Reply-To: <CAMRc=MfWv0yZsLuF8wfqBK6cNoPkMoG6oNwa3ov9nRceJ1ykHw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--p3syauw3r37si37j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @Wolfram: if you're ok with these changes, I think they should go
> through my tree. Let me know if you agree.

Frankly, adding 115 lines to i2c-core should go through my tree, I
think. Still need to look at the latest revision, though.


--p3syauw3r37si37j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlo4JW4ACgkQFA3kzBSg
KbafeQ/8CoPJ88k2MM7lyvatcseaPRjdPpVEtoCBKUDmGQ8r+Yi5snuNeZ8NajUB
mAbGYy6KW7iviXlIc0SmwwANqkwlSewNUiPAGZIiP7LsRrIIn//PbXbq2bt5sYpN
TslMuvY8gOkrefHCVwv/iE3nfYAQr5F0ml+hSmepPS/Wf4kX+GhiDivSZY0y8XEJ
SdV2hLyjhIk6S/5HoZkRGdIzcdYYgEa4q835QdhVWMBZUrQ5kSEGOejVFbfIug/o
GdPYPG1F+z2BhSopqVixC6N1Kh31K4cpROR1iwoVFccvcnqiJsM9W7V4AUorjxmp
Ttzj+Etp2daJK37mH1Wzj32IYDtPqOtCiwsAJ/oVE7DOJ9vlejBv6oHdxR+s+mNM
h1vx9SkDJxLOnNOQ/F5bs4hWH2aoFblM+7JsPly9KN6B6oOYADxDizkhdUfhc8Z7
oJEMXntdx2WPnw3GnBUS4HuFgsr9+6h1s3Li8EvqeslJIlaUPvW8SQfgwV7VTG8J
k84JuI4Ar4DcHF+W10a+1TJ/II2oSamql6ZoOdDVmZVpPMaX05hUKK1WDkdRMlX+
LNs7RApddg6cj4WYsx1+u/JnVHL9+e78NV7X3zSmsytd9vIdYiIb3Re0zJ6AyQb5
GFk2w4wDmUfygnuXS3IQdOVzSPTXme4W/fmXjb8j4w8+VuQsBPY=
=E6Sq
-----END PGP SIGNATURE-----

--p3syauw3r37si37j--
