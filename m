From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/6] i2c: at91: add support to FIFOs and alternative
 command
Date: Wed, 10 Jun 2015 21:57:09 +0900
Message-ID: <20150610125708.GE1592@katana>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, robh+dt@kernel.org
List-Id: linux-i2c@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 06:22:13PM +0200, Cyrille Pitchen wrote:
> ChangeLog
>=20
> v6:
> - replace "at91sama5d2" by "sama5d2".
>=20
> v5:
> - print I2C controller version in an already existing dev_info() instead =
of
>   adding a new one.
>=20
> v4:
> - replace 0x%x by %#x when printing I2C controller version
> - change the order of patches: the race condition bug fix becomes the fir=
st
>   patch so it be can more easily applied to older kernels.
>=20
> v3:
> - fix braces {} coding style issue
> - split the alternative command patch into 2 patches: the first one fixes
>   a race condition whereas the second one is the actual alternative comma=
nd
>   patch
>=20
> v2:
> - fix typo in comment for AT91_TWI_SVEN.
> - document new device tree bindings like "atmel,fifo-size".
> - explicitly set the has_alt_cmd boolean to false to already existing chip
>   configs.
> - use the BIT() macro to define the register bits and do a little cleanup=
 in a
>   dedicated patch.
> - reword some comments to better explain why the TXCOMP interrupt is no l=
onger
>   enabled in at91_do_twi_transfer() but later in
>   at91_twi_write_data_dma_callback() to avoid a race condition when DMA i=
s used.
> - remove useless TXCOMP interrupt enable line in at91_twi_write_next_byte=
()
>   since this interrupt is also enabled by at91_do_twi_transfer() for PIO
>   transfers.
>=20
> v1:
> This series of patches adds support of two new features which will be
> introduced with Atmel sama5d2x SoC.
>=20
> First, the alternative command mode eases the sending of STOP conditions.
> Before starting an I2C transaction, the size data to be transfered is
> written into the new Alternative Command Register. For each byte transfer=
red,
> the I2C controller decreases this counter and automatically sends a STOP
> condition when the counter value reaches 0, that is to say when the last =
byte
> of the transaction has been sent/received. So there is no longer need to =
set
> the STOP bit into the Control Register.
>=20
> Then the use of FIFOs allows to reduce number I/O accesses: for instance,
> the TX FIFO allows to write up to 4 data in a single access to the Transm=
it
> Holding Register. Also the RX FIFO allows to read up to 4 data in a single
> access to the Receive Holding Register. Currently only DMA transfers take
> advantage of FIFOs.

After fixing the version string in patch 5 as mentioned there, and added
the acks from Ludovic for the previous version.

Applied to for-next, thanks!


--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDQkAAoJEBQN5MwUoCm2obQQAKb3ymsnDSeJRsH03HQLsUsl
DqqfEQThlQWH+1gCIKK8leA/R1bExOoyTSfE7yn59c0P3/UQMGt+nHPyvkAxgrfi
u6a1lvYbNgTonrbyv1c35LZKM4VlO6GTkuWyZNxQs0NpjUN3kkkmQH8qWfx0FZn3
fL0HFGZuEYWT65/1t98sUdm/N9cZcUPaEXprLpdxX1EUTQhY3GBoLusVYvXizOQ0
hoCiP9vYNZ91P9zxXa07QBNgyGoUzUg/V+xfqU55p3BNw892IR2cIGmAH0fJxvy6
cNal9jBZe/lL8TjFkv9gpXKPBNbNV1L6fTqk+/bw8fc3GRikhGFZbVrQGkIO36Md
0P7zHjcwmlbR/zLiINWhJmxMjyVyomB3UpsC8KdhYzq7ezmpWB0kSVocp1Z197X2
pncS9ADPP/gTjYZlTYBCRAP1rNKpIzudi0zSfJnKSlR8Tu2zFYs0AByawmK5Nyku
OwZzyCo1AS2trpxDAHkIA5KiV9C6XJfNv/frbmYeW/xKSuJPtsqHqwpvp90/313v
nhL+CRDbznx9pauc8ayIiPOUwz3kkpVrGcSjU4v2dkj9zyti0r4hCw02e96nVIBH
F6CbBA8aKDZmO7Jdbh1rjguQdMMojY2a/N3VOLSpNKEEFvooMZbRGTHtwK0Pm84E
qhsBmOvujuZ6Qrz/uUbW
=/6Se
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
