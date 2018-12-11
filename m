From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c-axxia: support sequence command mode
Date: Tue, 11 Dec 2018 21:04:36 +0100
Message-ID: <20181211200435.abk3jdsmltz7c26w@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <8515ba7093f5be3ad7bd31d68efedcbe17958282.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3m5n2s5rtnxudgq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8515ba7093f5be3ad7bd31d68efedcbe17958282.1544453688.git.krzysztof.adamski@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>
Cc: "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--c3m5n2s5rtnxudgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> +static void axxia_i2c_handle_seq_nak(struct axxia_i2c_dev *idev)
> +{
> +	while (readl(idev->base + MST_COMMAND) & CMD_BUSY)
> +		udelay(100);
> +}

My code checkers rightfully complain about this:

  CHECKPATCH
CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt

  SMATCH
drivers/i2c/busses/i2c-axxia.c:382 axxia_i2c_handle_seq_nak() warn: this loop depends on readl() succeeding

(and I get those as well, but not related to your patch; still while I am here)

  GCC
drivers/i2c/busses/i2c-axxia.c:98: warning: cannot understand function prototype: 'struct axxia_i2c_dev '
drivers/i2c/busses/i2c-axxia.c:130: warning: Function parameter or member 'ns' not described in 'ns_to_clk'
drivers/i2c/busses/i2c-axxia.c:130: warning: Function parameter or member 'clk_mhz' not described in 'ns_to_clk'
drivers/i2c/busses/i2c-axxia.c:229: warning: Function parameter or member 'idev' not described in 'axxia_i2c_empty_rx_fifo'
drivers/i2c/busses/i2c-axxia.c:261: warning: Function parameter or member 'idev' not described in 'axxia_i2c_fill_tx_fifo'

Also, for $subject, please change the prefix to "i2c: axxia:"

Thanks,

   Wolfram


--c3m5n2s5rtnxudgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGFMACgkQFA3kzBSg
KbZjBQ/+JKkZOieWNTHYtxct2MfgBqvV/GjQ2LNchV0lAsarOYL5+70J8ZRiX3e9
PB/cb5mkjw8muL0fl41fOonxiel/mxy8X9JdVrnPJj7xSbsbbn9s91dBmaKXr8Tp
hGDfBdtTQm2EPwWWIeKsCbd6aRwXsCDdUiQLFSiw21F0QuGBJxywKT4V0rNkfBDK
whew5E94SpVKO74DZZhUO3qT3zGbJIdwfgl3jU9aPAJbpD4GxLWDMenEVkI7bnIO
SOMsmF6S6sp+O1ZSRARaO6qm28RYoi4I96hU/aoJxmT73LiUagbPuPFd9P9aV/vs
ucxXDjQhscVbvqeY+EMLU05mwLicfhwT38j0au8Xa0zDLYCKyzUNa2F7gu82yMpS
lL+LyUYsKWWLUp36pkriH3Hk24jjwXaxqv9JlTuuMf0/QuVRhoIexA9h/eUh/keB
7Xr2wHvGvLgY9VfIlXpC8PyJvnvBT6wxc/R0p8h1IRuOp234DagQhenDySV0htnx
s+9Dl+HusBfufX7ACPa/l+PwIOGCBJ7oEHASq+E5NXJ4zdtSi4d1xZToldT2JBdj
Sm0n6R2p+Gc0vegX9fmin0lqIynb9girYSl3LYbVY0ZE6eXg+8bWun4rJ3447OE7
QOFSN06zcuedwhaqcg6u2v1kBTRYJZ3qRYjMIbiSu9EwjHK9Jic=
=Oulp
-----END PGP SIGNATURE-----

--c3m5n2s5rtnxudgq--
