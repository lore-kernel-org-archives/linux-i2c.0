From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 07/10] i2c: Add driver for AD242x bus controller
Date: Thu, 12 Dec 2019 17:33:15 +0100
Message-ID: <20191212163315.GA3932@kunai>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-9-daniel@zonque.org>
 <64adf5d7-754a-f1da-aa9b-11579c5a2780@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64adf5d7-754a-f1da-aa9b-11579c5a2780@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luca,

thanks for the review!

> good, but I think there's a problem in this function. A "normal"
> master_xfer function issues a repeated start between one msg and the
> next one, at least in the typical case where all msgs have the same
> slave address. Your implementation breaks repeated start. At first sight
> we might need more complex code here to coalesce all consecutive msgs
> with the same address into a single i2c_transfer() call.

Note that it is by far the standard case that all messages in a transfer
have the same client address (99,999%?). But technically, this is not a
requirement and the repeated start on the bus is totally independent of
the addresses used. It is just a master wanting to send without being
interrupted by another master.

   Wolfram


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3ya8cACgkQFA3kzBSg
KbZBdQ/6ApPjJEPmloupECtcOPxRdHIBMJSbDi9HpBk6QSvFwtknvv6ybcJHJ3Dc
2GkbUK4EAcDvvDx4mTqhw7t8JPay3Bu3O13a/wXP5PDb7DeHJ5xDaBsEYVLC9id2
E1I5aEfdrrxsL1HFUZn86BmmthMuupvelZAyfL7pXDT3AU5oNkPipfKzoiC0EiBP
MPu2HN8BIX7l1ECvOL9j0pZYCfz00UHA4PtWHwz7zjiCG7RmY3qlm6xw5l6XFeq3
wbcmTXcLr8OIG/8sw0PMJjJFqHfH9Vlj8aYcRrsgjDEHQbSTKAQ/RTDw9rcmAktW
/1u6RUea0ckwX6rhKWZSXVktPzCV5LWaywD6lsMGXxhF/0T2tvKRqV6+xIngUY3n
8KnzpK2i3gvLmP9BYYxa/BM8qiuR4SimZi35lmofttUzXUs/5fgJwxFg2UuJqpPD
Ex/lyLc1AUbRRp8mDsSMsGg7Ku6WUt5T7OxmVjzvIYPLJ84GlTvZLA4WIskzWFVw
aZ2+E4YZq35snfMfawdrDmTOOmNOEPfVuT5Cm2ul1HVTprAgF/DVkQHVWPzNtOo9
xxwPgX9lrN0I+Ek2F1kSJguphMzVjIFRvFCl77TJUQ7qvBEWYDLQs1hBdmXieBxA
bNZoxeVI6DmFF5qTxkQ3Qh9NUGWkPKuslRF2Fh7dWQIoS9FauJo=
=Gmcp
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
