From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] eeprom/at24: use device_property_*() functions
 instead of of_get_property()
Date: Thu, 9 Feb 2017 20:58:59 +0100
Message-ID: <20170209195859.GB1431@katana>
References: <CAE7DoPan8Y_-F-Fj22xYkKBeCTPPD60MvEAv+hjSzU+H5DHovg@mail.gmail.com>
 <1486661768-21456-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50164 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753303AbdBIVpn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 16:45:43 -0500
Content-Disposition: inline
In-Reply-To: <1486661768-21456-1-git-send-email-gardner.ben@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note: Matching the driver to the I2C device requires another patch.
>  http://www.spinics.net/lists/linux-acpi/msg71914.html

Do I get it right? With the patch applied we won't have a regression but
the new feature will only be available when the above series is
upstream? So, it is a "weak" dependency?


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYnMoDAAoJEBQN5MwUoCm2We0QAIKaDEGZiAH1MlXpkru9Ov2U
3ivvBc96Oojn62m1h8XA7D9dowdU2kyEq/Y37sgxflujqo9MoYK40FTPxZ6FwjK6
uqmW4XS05fW3Qnl+DR8CMp1ntKSAmJUxhdmIgCArnISOBKaGerRzZw9fuSq+sB9q
ZJULjMqraFAXY7eF0G73lceiroyVWfhR1lK0CztM8cuqRM4+mp3GKzciScH1KXOG
tcBz3t0Grx7Az09VQrd7eaEagwGmydE/K7oj6nx0vMpejH/l4UCqvlFYlHDX9GUR
p9/147ZPwTNItRJgZw2HMCkveZ6Id3CqxNeWlVtiWwfkNzjoZ2cvM9sjSZOZZPvK
JsgYB22tQoOWlEc87DkKBD/BKKmY5x5zwYscaus/CJlay3dzID6eQiupmPP1betn
W+wLZKuoLkT2iyjBYZMNcXFJaoUiPSj6Pm0kF2AHhdAOeA9l2E7X3bVMmgbYiJ8V
9yylyJHCWvMX3TekaiUssjIUn6MWPVY3vt+TbYSinwFcL/jCjPmlVWkXvw/polJF
otqQ+6FVGTXvGTnNDuwm0+RLp3wNK4XfTDU8vUCk3S9T3j+pFswYimKCVb88yEQN
TkP2MHKz4aS8V9X+nS7hyM9ChJJ0ccMA7kcJhrAHvsZLUwdQeYlCQyXH8So4jyH7
VnlWX2RahX1Lg5E/dGAB
=n/WR
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
