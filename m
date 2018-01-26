From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Patch proposal for risky i2c addresses in i2c-tools
Date: Fri, 26 Jan 2018 19:03:30 +0100
Message-ID: <20180126180330.3ep65ongfdgffbmu@ninjato>
References: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zg7kboc7y7ps3a62"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35754 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeAZSDb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 13:03:31 -0500
Content-Disposition: inline
In-Reply-To: <20180105150248.3170-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Porte <romain.porte@nokia.com>
Cc: linux-i2c@vger.kernel.org, jdelvare@suse.de


--zg7kboc7y7ps3a62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Romain,

> This patchset proposes a new option for risky i2c addresses between 0x78
> and 0x7f that are currently disabled. This behavior is marked as not
> recommended, but is sometimes needed if you have a device using an
> address in this range.

Yes, meanwhile I also have a board using addresses 0x7c and 0x7f.

> It was inspired by an email from Wolfram Sang [1] that encouraged to add
> this option for using i2c-tools with devices using this address range.

This handles only part of the risky addresses. I once worked on a device
having an EEPROM using 32(!) addresses in the range from 0x00(!!)-0x1f.
And yes, because it was the only device on the bus, that actually worked.

So, the lower boundary should also be removed IMO.

And I'd much prefer a flag like 'R' which represents 'risky' better.

Thanks for doing this!

   Wolfram


--zg7kboc7y7ps3a62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlprbXIACgkQFA3kzBSg
Kbbi4Q//foZdJJK+9n8w/Ru3WFUIA6yzHXPWKAU4gYE41tetEZoqZCuIvgk01HJm
qnKXXo8f6K1tkf/2uAZzWE9Plu6BRQ1Y9EiCCk3MewKMTzviGaPyxVFIY52z+2nK
k5ClWIU82E95r3imIOZISaukwhN6y47D+6pXAftBS1mZ1Z7XR2PqODcKtvZmK7Xv
T6NCgiU0pl9rHDoIRv/9M8MlXA37w+vIxMscnJJYnjb9OTa+s8Xz8DG+1ggZVJsJ
Jyhu0ozKtXglkXWFXlKcIEPmaBCcrMTveDp5sV9//cU3R98EnsDrdXsZZGdvnVmv
Ckjm3MddSb/S5W+VTm6YzyfA5DpXA51PFuJYGNE7RCUAf6aL8rU4+ielyitfSTMJ
vpeEgLajj/iypcMZZ9d2rAdZzZfzBNLDnK4o4bUJgAaoKWXnUcgq8Z9V1i9B0Wr3
pwFhXY5fUgPDs33GiOZPAwselspBI/VRfK8h/PDSnDfdtA1Uw8eaaRGdrO0bueWG
HojhebrMbOSUwGR3Pm/giGlY3ctaQeQwi8TaW6S3uuu9lDE58E2aKHnwungibfkt
9TkNVf+N3g+D4/CXxnINVhdZyuxx0i+3ua2fdNXRFuT7ZidsQ0TMKxI3GJ7dEw1k
aItUWz31EMB+GBaq+jlEHw6byDK5YnXJaqeC/mJIr6LOojKINtY=
=eQaF
-----END PGP SIGNATURE-----

--zg7kboc7y7ps3a62--
