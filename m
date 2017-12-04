From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:renesas/sdhi-uniphier 2/22]
 drivers/mmc/host/tmio_mmc.h:249:2: error: implicit declaration of function
 'readsw'
Date: Mon, 4 Dec 2017 17:00:27 +0100
Message-ID: <20171204160024.yv3ztu2ntn2l2l3j@ninjato>
References: <201712030902.U17suQaZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fetm7v3ik3myd4ls"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44857 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752638AbdLDQAl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 11:00:41 -0500
Content-Disposition: inline
In-Reply-To: <201712030902.U17suQaZ%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org


--fetm7v3ik3myd4ls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git ren=
esas/sdhi-uniphier

buildbot is a really great and helpful service, so a lot of thanks for
that.

But please, again, drop the i2c mailing list for my personal development
branches. *Only* include the i2c list, if there is an "i2c/" prefix in
the branch name. This branch, for example, is MMC related and has
nothing to do with I2C! Or, if this is not possible, drop the I2C list
=66rom all my branches and just mail me and the author.

The current state creates too much noise and it starts to get a little
annoying. Please let's find some fix for that. buildbot is so useful
otherwise.

Kind regards,

   Wolfram


--fetm7v3ik3myd4ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolcRQACgkQFA3kzBSg
KbZJng//Zyzycv2ZWQbNVjsL4LrbPzVT8kXUFHiPdhqPYSqdMJ5XDSw3lSW+rs/t
q7qR/kBzj2ItHjZy4lJhhGVgk+qNMsCe8N47LXmxA1Y/VoV/7yIZqNMVwNjboR6c
pAIGcVU5kZrKJqpqABRsh9tp7H/QRGZFDwvmT59cPBhmqZ7zMNrXg6VN9C3wpvDB
eXORKGV/2YWX5IumW3rHZchnna8y7KLDNW2uwF8RCmI04uOVV04W59Mtjv7e0KGT
pzugL6wNfJRYA7k8AT/lt1FwNQ2AiLKhHquxftbsQuo+cUpsAJA40l9EP0a5s11N
V9MglfG1qZeXtFjKcL3jLoylo4hzlgqGjsFejevFY/mbglKkDRzTqQllBxpT/dse
5yzh4uCCTD55eLn+gibTgZZ4JSPI3QF7pocex391WNZRRLKqd+0l4fpNFNrS1gxf
xOThSd3+8FKXN+W27xMJqm3eudCgK3YKhvw5PndtzeeJthA9m4Y0wFh4nyF5Twm/
caWQT05MXGoumm1o9hmtQSS9t20r3R8DyfjvwEIheECzpdCOyKwAo502NIFY9hIJ
jC83N1f76eIjxKePPPQ8osY1RMj9CKl+G4sAZpirA0lR6j+r4YkF7RdmQvVPXRkB
LSdgOcxMC0+fmmdQ9lkySm62fmLTvfQu8MazC1UFSacjObXgZDI=
=ozrv
-----END PGP SIGNATURE-----

--fetm7v3ik3myd4ls--
