From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND v3 1/1] i2c: qcom-geni: Provide an option to disable DMA
 processing
Date: Thu, 5 Sep 2019 20:20:59 +0200
Message-ID: <20190905182058.GA5281@kunai>
References: <20190905144122.5689-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905144122.5689-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, bjorn.andersson@linaro.org, vkoul@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:41:22PM +0100, Lee Jones wrote:
> We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
> a rather horrific bug.  When I2C HID devices are being scanned for at
> boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
> When it does, the laptop reboots and the user never sees the OS.

$subject is still wrong. And a paragraph that you are/were debugging the
root cause but to no avail so DMA gets disabled for now would be good for a
hotfix this late in the cycle.

>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index a89bfce5388e..17abf60c94ae 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -355,11 +355,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev =
*gi2c, struct i2c_msg *msg,
>  {
>  	dma_addr_t rx_dma;
>  	unsigned long time_left;
> -	void *dma_buf;
> +	void *dma_buf =3D NULL;
>  	struct geni_se *se =3D &gi2c->se;
>  	size_t len =3D msg->len;
> =20
> -	dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> +	if (!of_machine_is_compatible("lenovo,yoga-c630"))
> +		dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> +
>  	if (dma_buf)
>  		geni_se_select_mode(se, GENI_SE_DMA);
>  	else
> @@ -394,11 +396,13 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev =
*gi2c, struct i2c_msg *msg,
>  {
>  	dma_addr_t tx_dma;
>  	unsigned long time_left;
> -	void *dma_buf;
> +	void *dma_buf =3D NULL;
>  	struct geni_se *se =3D &gi2c->se;
>  	size_t len =3D msg->len;
> =20
> -	dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> +	if (!of_machine_is_compatible("lenovo,yoga-c630"))
> +		dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> +
>  	if (dma_buf)
>  		geni_se_select_mode(se, GENI_SE_DMA);
>  	else
> --=20
> 2.17.1
>=20

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1xUgcACgkQFA3kzBSg
KbYXzA/+LjS2mPdsksvarWH8VQNQdqsoNEIn5YCxhi5qXxi0KAdEp5Z3N04ZEOk3
goSeO/4g2HCWM9myuZ9wunwRgK8ucOiSfkatKYPEKHg8buN9f3QfSlLfENIhtwKc
yeNOJyakRyJnfzXpFVRmrrTWjJoLTS0ZhNgHFMPbR8cXu1sAW2tnvzYfUVLUBGP4
w+3ldwl6wzRUvg49x4K4yGmsTJ5NQFPKJnTUUYUJ0IgetTRyGD/3HoEY6k3W12oo
QenoRNh3MEd/HjG+sQYH1w01/86Oz5L0N5OFQoQtFwCR5fITMP4sjy30dB1/cvyr
UzXWWfzzRV5Gbz1EodWPOS2dzPj4e8f5TRzKJa86GkPYcm6Fys4ifFWTCD6yxuTe
A3o2ruGJwaIZ6ALxUAzLfSjbyb3ZKsCJ+JLUeMP7hnTrOI7umYHQKxiAXkC4gL1E
CzAg3CA0BefETQ0vutbyGemZfq8ThJpFktldowciXZrxo55JoPIW2PNMn9YuLE+h
7yxkc0NQB2Y1Pzzqyk8dcQrwDOS+4sEiGD2QEgAe7FdMqv181MA7XIH8C05Y/uqV
gwBYxFuKCc7/dUfKBzHDi5EpWlwGIY7wGTvNzzOwn25+wmUOEidSa3SPuM6ozEnR
Kc9uu4xw4ZB/1cne5zTkL0BDa14aJt4/lkcWV4TWrs7E6voy05k=
=Z3pm
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
