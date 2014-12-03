From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] i2c: add support for Cypress CYUSBS234 USB-I2C
 adapter
Date: Wed, 3 Dec 2014 12:07:55 +0100
Message-ID: <20141203110755.GA1039@katana>
References: <1417241986-17841-1-git-send-email-muth@cypress.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417241986-17841-1-git-send-email-muth@cypress.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Muthu Mani <muth@cypress.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for this submission. Looks like an interesting device. However,
some very high level questions first:

> +/*
> + * It exposes sysfs entries under the i2c adapter for getting the i2c transfer
> + * status, reset i2c read/write module, get/set nak and stop bits.
> + */

Yes, I see that. Yet, I don't know why they are needed? The driver
should know when to send NAK/STOP. Why expose that to the user? And why
do we need a reset? Are there stability problems? What about unloading
the module? And what is the use case for reading the status?

> +       if (num > 1) {
> +               dev_err(&adapter->dev, "i2c_msg number is > 1\n");
> +               return -EIO;
> +       }

Ouch! Don't you have any repeated start option somewhere?

Thanks,

   Wolfram


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfu8KAAoJEBQN5MwUoCm27dwP/jUckD8IWoeAS1kk9+9NzIhE
ewCXbdGw3QD3HMoWGV5m9PxBl+FaCb2uskZ0NtNygH1DrZlOOUihwm6G8GUwaRff
8KZxmn57zGw+7r1EjYkeNfa2I8VJ4g5diazJuLazwBxtYQdYaUBtLE47uLoudSCl
0L8pMO4CFeDLP/A3aJonIeqvF6qHshFYbuMNVp5yEtZ9rpIlN+JgFCGUXVrNN6hj
tO134RAwLxdar4Yh2V/FlKntlY/IJL0x1CXlBIEThlaBvx8zGfLfeqyFn83Pc4vw
xWYsFVthsX6ZlFEfJPWPJwHw4j7aN0QtpcT8HcK/RlwL9WoSZj0mZFutnigJhc29
pj5zkPjghD9EKKcGH+dKmDf4zoQs+QSi5s97JSWXQ6qPoIhAL1Qb2Kwc4dugw34A
g1dw7qnEx+BlcLaHcLpDzBcKfWeTvnA7/swwj1ZFopNdhSyKkBVCFQA69hzHHuvC
EEDyyLsl0uyv/qM2y4r40A5rkpTyXLcJPyDvlnOr0BzXfOF6yW8Ce9QjX7yb/JYX
Q+fogc3zrk6x0gLTWqoIGKFgBBwxkLQZWxXp6MT5xepQ5LiPTG3U6yKV0qrakIl+
umD8LUmaG3DbrOi+0/28p2SQd12j1rlOB8Cyh/k8iRa7aahScLOKMVnO/y4+A9AV
W8t4HXZLUheEaVSG4Zhs
=UTPt
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
