From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Thu, 14 Jun 2018 13:19:42 +0900
Message-ID: <20180614041941.4i2cadzoevujmzha@ninjato>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="st33g2u2nspyzp4d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-2-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <gala>
List-Id: linux-i2c@vger.kernel.org


--st33g2u2nspyzp4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

> +/**
> + * struct i3c_priv_xfer - I3C SDR private transfer
> + * @rnw: encodes the transfer direction. true for a read, false for a write
> + * @len: transfer length in bytes of the transfer
> + * @data: input/output buffer
> + */
> +struct i3c_priv_xfer {
> +	bool rnw;
> +	u16 len;
> +	union {
> +		void *in;
> +		const void *out;
> +	} data;

So, this is probably where most payloads end up?

I didn't notice any sign of DMA in these patches, but given my
experiences, DMA will come sooner or later. And in I2C, this was
problematic because then a lot of drivers were in the wild getting their
buffers from everywhere (stack!). We now have an opt-in approach to mark
buffers as DMA-safe.

I don't know if typical I3C transfers will be similar to I2C with
usually small payloads where DMA usually makes not much sense. Yet, I
think, that it might be a good idea to think about how this shall be
handled with I3C right away. Maybe simply enforcing buffers to be
DMA-safe. Or whatever.

A clear rule on that might save you hazzle later.

Regards,

   Wolfram


--st33g2u2nspyzp4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsh7NkACgkQFA3kzBSg
KbYaJQ//WvuZkJrJ/IluxoHlKtN048uYvkfLNZCpddYE5p7JfxrreeOyn/EMQYUX
ftikOAIWzo93LpPAgeKqHTD6FCMgfUDfB7RWZFJeRuMLZ/cOdDbsTA0Y/1S76SEl
LEXebvQYhHd3YJsqDDGmyhCoXGtf/1n7tEJ4ax4NdJVMx0QGXUWuAlQAs2QAzNYk
BzDfHEIbKc9469T5naQrQIVoaJLUqLCXs2RBzRnMDr8hl7wRtMckq64U28CiTNuz
Hu/yh7axdg0EIqy/famCHzsbfg8Z5GXig8PNEBG5fCf0vL4aMap+56siQHsP4UgV
bQgcIPSxqWcYBy2YVU4aiaLUdSYsAs/qympVnrWwRa6Lfy1z/JxPIs+7bI6TSER4
OlMhrTNEiyiZbP5uj4LF+JlmFwYthzxwM9/j8ae6ZMsry6nQ5VFTYyUjOSUis4bQ
05xrq8eZ1LDI6Kex4S9kY9OaN0bDo2u8xZv5yVqvbJaJ8dsD7uul94oGJPlO2jGm
rUErZxjH8Q3u3QeQIyyZWRZlX1dIv+feeLbjRXlPqcdQfPcjbrv98T6FsuYqttzs
FpA6wa1kbUZCchsuaxCvZu+5ja3OkYieYJ4keQlvO3EVzGnl3b0rcrOoSktr4ONs
yBoV6WvF7+a/c+2ldQvi3/qaVu350CbdLowLWvX5yIFWtCOSkGM=
=ojn/
-----END PGP SIGNATURE-----

--st33g2u2nspyzp4d--
