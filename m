Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868065;
	b=o6sjAtZ/RfdKFvWretmu1mfUL7VBXP7khcfhDhVPw04l6oxLleiMC7RpBwilHOx+ecUu
	 4BkA4azBAjtRBQ5gKEFbKwtjBtjBEFM14WmuHnv7iQv7mSIoOnq3z3OmP9T98okrH41U+
	 MdD5Byf8v+CLmzRKqaLerl1kA3XgjBzS/484u4rOWy5CaR8oXixaxulKo0PEl8MEtYSkF
	 c26yWyjm48jpbhfYA1X9rs/Ac45woL8O+qfcuKIIteW+/p06MbEbzegv87uZLhMGanTd7
	 yMzTU61awjsWBRnpuGKew29Soi3TYxxrh6qyvK1Ud1q9VIJmAJFhnXRM0DypluDNckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868065;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=EyS1Vaex1qh0ymGPOrjfqXS9hLerdXLqS1mjQFe74nk=;
	b=HO9c+oQ0GYrRakjrQcGynaTtKm9ELDCFHBNJmPJNg4UShfLIfP9V80GUp6E0n+Vbupo6
	 LBuaQsJRgR7gDXz+CtTj9ODjBEN66tm/G12PLOKrrSkyZoeQazEK3gKaOa+ZAdPddg3xg
	 xl5ghz6+Z1Fippd27Ad8qsTc6ct8Q4qmFgqSfD8eAoVzG8YViBCURQ0kjb1GRzPX+23fe
	 EKjqOFswOoBxUnPN3Tau7Of1NdlPFtgvrCeWziNX8lWXbO/ieAM6QrzqcOe5iK/uoOKk9
	 Sujx/kCvK2XNYSnr94QVYxrop4VMgz5SwhQQ/fxFaNpkVx+kppi2i2IwKeiB650ehog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtcmsLPf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 65C3E606A31B;
	Thu,  5 Nov 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtcmsLPf
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 693161F000C1;
	Thu,  5 Nov 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868065;
	bh=EyS1Vaex1qh0ymGPOrjfqXS9hLerdXLqS1mjQFe74nk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=DtcmsLPfZkmEcY5AarenNSNJXh7GTf+Js3l8r5iueA1ACJ1FSoRyYXPrl4qK35qG1
	 HSkGuxQZlyrYbLwVEws86T0zoiAsLXBiPk6mpQojhjl2EJnSzs96Sxspo75s9jtg12
	 E3I6YJgUDAMsbIteWO1LKwHsW0wKoRb1M+0LmzxYqFg7LUChO5gVQe1izV7DeAhd+s
	 dAPsSGsXNenHPCi8YzaNMHHSwfkmuVq4UToXR0u7l/GkNykhgsvj7XgNA+KFWodKZE
	 LC8J8s+tT6AtZOzl+Y3ASw22eEj4x0jk08jNKtOGQvpIHZ+1aQ8KdiULR+IQZMUAjb
	 +PEmGyBVM9oPg==
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=be7b4e5d39c5489a31f05dbd21d857bce5195eedfb88e8c4c34fff550383;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 05 Nov 2026 09:41:00 +0100
Message-Id: <DMN55MF5SLDY.21QNY4T1VJ4IQ@kernel.org>
Subject: Re: [PATCH 1/2] i2c: imx-lpi2c: fix SMBus block read with PEC
Cc: "Carlos Song" <carlos.song@nxp.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, <linux-i2c@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Carlos Song" <carlos.song@oss.nxp.com>, "Dong Aisheng"
 <aisheng.dong@nxp.com>, "Andi Shyti" <andi.shyti@kernel.org>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
X-Mailer: aerc 0.20.0
References: <20261104121108.659820-1-mwalle@kernel.org>
 <e0094b33-f73d-43f5-bd07-19bc0e88aaa5@oss.nxp.com>
In-Reply-To: <e0094b33-f73d-43f5-bd07-19bc0e88aaa5@oss.nxp.com>

--be7b4e5d39c5489a31f05dbd21d857bce5195eedfb88e8c4c34fff550383
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Carlos,

On Thu Nov 5, 2026 at 9:29 AM CET, Carlos Song wrote:
>
>
>> If PEC is enabled, the I2C core sets msgs->len to 2 instead of 1. The
>> length calculation for the second receive command assumes it's always
>> 1. This will lead to a short read and eventually a timeout because the
>> PEC byte is never received.
>>=20
>> Take msgs->len into account when calculating the remaining bytes.
>>=20
>> This was tested on a board which uses an IPMI SSIF BMC.
>>=20
>> Fixes: efdc383d1cc2 ("i2c: imx-lpi2c: fix SMBus block read NACK after by=
te count")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  drivers/i2c/busses/i2c-imx-lpi2c.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c=
-imx-lpi2c.c
>> index 7302464c371a..f57e800ac3b5 100644
>> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
>> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
>> @@ -563,7 +563,7 @@ static unsigned int lpi2c_SMBus_block_read_length_by=
te(struct lpi2c_imx_struct *
>>  static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
>>  			       struct i2c_msg *msgs)
>>  {
>> -	unsigned int temp, val, block_len;
>> +	unsigned int temp, val, block_len, remaining;
>>  	int ret;
>> =20
>>  	lpi2c_imx->rx_buf =3D msgs->buf;
>> @@ -612,9 +612,13 @@ static int lpi2c_imx_read_init(struct lpi2c_imx_str=
uct *lpi2c_imx,
>>  		 * keep MTDR non-empty and ensuring continuous ACKs. Only update comm=
and register
>>  		 * here. All block bytes will be read out at IRQ handler or lpi2c_imx=
_read_atomic()
>>  		 * function.
>> +		 *
>> +		 * msgs->len is 1 - or if PEC enabled msgs->len is 2. Two bytes
>> +		 * have already been requested.
>>  		 */
>> -		if (block_len > 1)
>> -			writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_M=
TDR);
>> +		remaining =3D msgs->len + block_len - 2;
>> +		if (remaining)
>> +			writel((RECV_DATA << 8) | (remaining - 1), lpi2c_imx->base + LPI2C_M=
TDR);
>
> Hi Michael,
>
> Just to confirm my understanding:
>
> For SMBus block read with PEC enabled, the PEC (CRC-8) byte is appended
> at the end of the transfer. In that case the I2C core sets msgs->len to
> 2 instead of 1.
>
> The previous code still calculated the remaining receive count assuming
> msgs->len =3D=3D 1, which means the PEC byte was not included in the tota=
l
> number of bytes requested from the controller.
>
> As a result, the last PEC byte was never read out, leading to a short
> read and eventually a timeout.
>
> Is that the issue this patch is fixing?


Yes exactly.

-michael

--be7b4e5d39c5489a31f05dbd21d857bce5195eedfb88e8c4c34fff550383
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCauxBHRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hpmAGA7NYvq+xpxg+2/2QVA9m4GNTNFDpS+4x/
0W5UOIiTMaupw5X9BSdyNznrickkvakGAYCK8XtgVS2/9dfE1Ux0lx7UZSZDT4+T
bjWi7Cvu54ACiyfU2Fmo4GKjsy0++bfnqzc=
=I6KU
-----END PGP SIGNATURE-----

--be7b4e5d39c5489a31f05dbd21d857bce5195eedfb88e8c4c34fff550383--
