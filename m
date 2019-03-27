From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/8] i2c: iproc: Extend I2C read up to 255 bytes
Date: Wed, 27 Mar 2019 23:17:32 +0100
Message-ID: <20190327221732.GB15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-2-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-2-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Shreesha Rajashekar <shreesha@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		if (!((readl(iproc_i2c->base +
> +		M_FIFO_CTRL_OFFSET) >>
> +		M_FIFO_RX_CNT_SHIFT) &
> +		M_FIFO_RX_CNT_MASK))

Don't be too strict with the 80 char limit. I think the above is hardly
readable...

> +			break;
> +
> +		msg->buf[iproc_i2c->rx_bytes] =
> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;

... this here is MUCH better.

Rest looks good.


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb9nwACgkQFA3kzBSg
KbYzdg//TqhPqqJ8jsf33y2YrdjFG4eYNsHy58/R6LsqUp47WsYfxCSK+pIqGFds
w7Tr35HB0oOQCqxAMnsV0hJV1bdITMR3N5KpW2LPL4YHBOIfsdtwJShPjo/n7vJE
XLCEWto8fyIxjFYu/VfIPpeFyMK0djtvnAr1aT0Hu7iJbNuqPtgK0Htu5YqJUAHF
+KqsZtyIue8+16veAvEJ7jzQl7XcXkejpak1oOBrm69i3tvi5P0HK0wRTAninCZn
v1GgOWnoP0iltCJpSDiZIRtEWcstGvx9vuHCu1DI9b/f7bk9F1Qh4V6Vwuot2JiF
oG+J6UptJjoK90ZSBY4Z2yiDRU+qVYAwjskY2PLeG2AgMYP47LhZ7RDzfcNtJmiE
fA+cwS3GhqIiFZbo0FPP1nKMvaJHr4xm0RDgPoTvmqxAUt5BwIMM2V8/ZnI8rlvW
GVPoX9W2V4z5W8BF6/QXaaYk1QY6WLnTEgi31fofCbnYyxSre0MwvvtUzfiVdCr9
IKQKV4N1s4MDYk6nOQ6x+rGa0tmJrw2wP8UJBGD4vl/TtSrCHmd8IJAE9xF/A85v
7L0NpRIomYRXpeJRtm7mYsr8Nl/HY5nXGgK+eKScXanv7kV81P88dF+KrFDh2Ymg
+tB0iOV1QGcCKxNEx0h73cs1nhTfQLL2lCZpz3d0XntkA1q2Ysg=
=5U3k
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
