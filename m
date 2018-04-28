From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/6] Add different features for I2C
Date: Sat, 28 Apr 2018 14:31:36 +0200
Message-ID: <20180428123136.hxcg4njtbrykuisi@ninjato>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eeyigs6324u43jku"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--eeyigs6324u43jku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 03:24:52PM +0200, Pierre-Yves MORDRET wrote:
> Append new I2C STM32F7 feature set. This includes 10 bit support, slave
> support, SMBBus protocols support, DMA Support and eventually an I2C release
> mechanism.

Applied to for-next, thanks!

While building, I saw this. While this is mostly not related to your
patch series, maybe you want to have a look at it?

drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'node' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'presc' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'scll' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:255: warning: Function parameter or member 'smbus_buf' not described in 'stm32f7_i2c_msg'
drivers/i2c/busses/i2c-stm32f7.c:307: warning: cannot understand function prototype: 'struct stm32f7_i2c_spec i2c_specs[] = '

And don't forget to add yourself as MAINTAINER as I mentioned in the old
thread.


--eeyigs6324u43jku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkaacACgkQFA3kzBSg
Kba/xg/+PdVh9QyKMTk2bG07qvDoqop+JIVBryGtiKBsU4iMdMOrUVEE0Xhvj1dZ
SDJqFF2GWPrDVn0fRcWd7bupF0OvxAH7CLmz9s+52obwTu9Dm4zSv42XKfEPkGm4
/gcZ0qyCTN5t4nBvZiQmcy+pTm8L3KmqpM41rWnV+uCLnA3thyre3rPq7RAY27it
nKawHzZHVnJ6SDpSsaF/BIBflj2CrVqZ4RYtIh7oL8V5HViHiW6ohFavgAQsNZe6
ymgtAzK28PBquMDMRBRzvRwDp9MDkB7rfooxvaj2ZfcAu9Zu1sKJbd0J70MIwLVV
uLEMfLe8hU+3YAEqf4tPgXmDxsyhIbbB+jhZKKCwi6HVv/z3L0BWo0TYPsNr15CV
lcZ31PBhuhVVGVFCBLtTKFPfnkZ4sr0qJh9ADqJXfnsPBPYKrcTwUE8E9sSiZzfE
B1gu9dAMtaLI5PHAnAUnxC5aqpUwdjBbYtZPQqzJBRI/vUlgThJcbEgY1YlmwZ/u
smkZlRbOMIhRODmBLALlWdmobUYyQAlrUKyzJJZvpTN4YboDEpLTg3n9FKP7gJw/
6fymIeB39n9iWZEgw4r1BcI0veVuW4Vq2s2npTveAGCeLxMqgREf8izptIGpPCdX
YfaSnjyVEFqDdcFcn6lAprILV46SxCsfNwDCxNOJyQNeLC7iakw=
=TWxI
-----END PGP SIGNATURE-----

--eeyigs6324u43jku--
