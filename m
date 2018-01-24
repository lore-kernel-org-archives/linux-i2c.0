From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: fix the cpufreq transition
Date: Wed, 24 Jan 2018 07:15:50 +0100
Message-ID: <20180124061550.m4l3ogzpsbidajta@ninjato>
References: <20180122144258.13627-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ykbeajq7zollxb5y"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53876 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752265AbeAXGPv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Jan 2018 01:15:51 -0500
Content-Disposition: inline
In-Reply-To: <20180122144258.13627-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>


--ykbeajq7zollxb5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 03:42:58PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> i2c_davinci_cpufreq_transition() is implemented in a way that will
> block if it ever gets called while no transfer is in progress.
>=20
> Not only that, but reinit_completion() is never called for xfr_complete.
>=20
> Use the fact that cpufreq uses an srcu_notifier (running in process
> context) for transitions and that the bus_lock is taken during the call
> to master_xfer() and simplify the code by removing the transfer
> completion entirely and protecting i2c_davinci_cpufreq_transition()
> with i2c_lock/unlock_adapter().
>=20
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to for-next, thanks!


--ykbeajq7zollxb5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpoJJUACgkQFA3kzBSg
KbZqmQ//c6XOfxonXmxMGdGG0H2CwMD41Zkp4yM65kO/0eGFdxMAsUDBQ+y4wqMI
W13Nu00dY/1ixrzsbfBsI0R7TWnsXDs2yEmh0SeiWAJsWWXOeakZKVxWxko9t2+L
JHVaNipSQxJ87I6HzC4zJOJkwsXeDbj2ycI5yarEUJwqAi2mkI4OgkfxZzVxVz2K
7EoMSX3RuNfZrizpHqHXv/Ub0R/sCg1gpvlKQHnM8sFo4qiWq6paiLRH2ldBbioz
w11qqzuBNp1kGm8+8Cgk2gaWI6tnmQLpL7ZIvYc2uGYcOtjZrsVoKNFaJlgCzwLx
6L1aCF8DrWqZ75JWFlfuZ470LaqdMNzAEi8X/+ltHjf/6Lsq1GK64kH+jn9Ios6D
D5qIejK+bvLGemegbrAsdb3bkYu8/PFmblMfDQVkSwZhj4Y6gtE+lDo97haJeyBN
t1MwnND5rFHDrqQ1lnKZdGj1DrbACQVgN17YgdKh7f7hxDPS52UPrWxSme0UXYbD
txR0SxInxkKF76KhUWXnSqbLgTAKq8YDmaRWfgT3q7lm8jcakvxj6omkiWsyYGK0
Njhbn06JBgEJ6gVY46ua/q7cEzOYo8OSda+b0kdxgZa9Q4M1VAk179r2sZMxoxBj
uftkPASI62/kobarXcagjP0DwqNB6Rk5Z6UjWV3rfVRHF48F9gs=
=OFvF
-----END PGP SIGNATURE-----

--ykbeajq7zollxb5y--
