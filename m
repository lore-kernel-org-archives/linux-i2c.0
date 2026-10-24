Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792854057;
	b=Kve6foh/UtuzOA7eW6yWE2+OUo7rneT8h6+2HuFwuEvt8gUHiwqgqkVZMQr+1C+I/JeS
	 PWc1lJluZ0euax9zdcJae9B6uQjmoECcGr7vMqD+VLhrdlV6wKOO9kgK0Pci8T36oxZBU
	 ur/nemRA1Q8sQPtSr0v+ltEnrM4U/0uG218mkHj5JtjGEQmBAmLGbLXysDIZ7ANCm6ztr
	 3tprZay2c2OZS4AQNYIdZCJguM8xIm4suTAmE1MCBe2HpjxeWvk0cfPK4a3XoDDMWQHYH
	 lclNdHOn+rUNizk/OHpUUT5JoJL5UpUfQlB5Ft2sl14jORGwPYiN5NatKKZzQ85fRjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854057;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=bUoaaJ3JrIH5q0k48YfaLnXj7F1Q2hxryzKjmPFAi/s=;
	b=KtwteV4L96Nu4WPkJyg4oP9NUdHPskH8Uin3iyLsyobVRQ0K1E+9BTi1zjdnGtehgwCA
	 wZLwvkMjUIYTwHixJocavdB17Q2bX/3U6DQvQqadOdPzYIihwVmg8tNHxS3IQpk6copaG
	 eouTKOffAl0Mo71uA7aWeLzjePH1H5/+68AWS/vT8YoJ93a54imwzecGDzWLfB3kzeM9O
	 BTf5BnXJunMjnQnRsIBYVRvPotyDHamAHOulCIq3kzg4bIjklNQ8oNenjD69b+Zuxu8IC
	 yQCyrEhqq6wcNgxWbYI64dVDcqRdYOfaMf3kf3jUuxqqcOIOhVOBwIKpNoiSu+cRMXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RnghN3GA;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mrNQ6SgG;
	arc=fail smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02F606A31F;
	Sat, 24 Oct 2026 15:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE02F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RnghN3GA;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mrNQ6SgG
ARC-Seal: i=1; a=rsa-sha256; t=1792854040; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y5WFvCV9JDI/LUGY7BW/NNJbusYxwknP7/2bY9uDGZRz2Ighk71cqEZtcMUXhjGmFJ
    FTXkgbu9FWM3a4ifIg9bPLfY0sZ2Geoc91iKyPJjpPNlEnfgS3J+2ldFMPRI/BFRzmpy
    PK3TlIgLUtvfO0/0sCKI3z+fSuTlVbmXFk/BpQgVcXrei7PuS1xBNxP2neEQtAHCBc/Z
    P6+mxJE484w9gApK9WJL/Dd57us+6n6MqQfqW5oWmR83B4AjcCPKueci4xiWu3thLO+/
    12O3gZo9y0YccA/3yH2Ailzc4ojFjrc/gyEC0j2Bo+uoItIYfRm+LJcZn6Mp0fCtAl+X
    NEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792854040;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bUoaaJ3JrIH5q0k48YfaLnXj7F1Q2hxryzKjmPFAi/s=;
    b=A59T79G69uuRlRJdPCR3i6Zvd59DNc1oU0cVYxaS1R4dI/fsFywXm7jcMk9duiPPqt
    ZqqGsknNRzkDQTOof8bMKrKPjaYrPsDj1XxT6wZSgfcPx0Nt9Yg0tPMgVNgNg9xVrmsE
    uI8MOJ7CEvshrX2yKdkvqTuRsl1MssLpmYYsYMtH/LtKhMe/eh/p6Wa4JABthQjaHJX3
    YJMFQ/0OqRp5SsEINn77gggqsiZeU8g9WLIBLIrn8Jzet7lNsFDTIRnVwqKLcZ7CiXpu
    RIW1Us3SyJ7BLMTrQmqO1aTC4x7Q447r72WUt4Xkr0xCyzL0MkJN+n+1Rd3U4t8ujV1+
    1loA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792854040;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bUoaaJ3JrIH5q0k48YfaLnXj7F1Q2hxryzKjmPFAi/s=;
    b=RnghN3GA9NyHf3GTdnwMMshBpwscTNX+QbmHEK5ua8bgPL68rRuvVoP6Fj6l7Sy1ff
    RsGkYqI2ncVvadSbjtNw2jwVxOyw9gJK0SqOsZsTDr3PM6pyC0e+thPUW5zGmBZTjwBK
    vfN5eHfxz5dBbmpbh27eDLQ7Ym2YK8xRZxf0WivFiriA271F71jZM5IdkTPxaExgDqhd
    pgTG3THkfdtKPdZNGFH1MBW5vUAUdK284YKpDxdNDXI1Z5UY1c2nvNbT0fY+epK37bnF
    3DLpSYF39GUJ8gnyfMJ5VvaK6adVbd5OQ1hfOyIN/TtbHpEPmBVd9xctNtXyDt70BCIB
    qcmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792854040;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bUoaaJ3JrIH5q0k48YfaLnXj7F1Q2hxryzKjmPFAi/s=;
    b=mrNQ6SgGbnq0J4oyJNr8mxdr5a5sU0MpxcU/bctC9RHBTQXbilAuEQ2tDwumRhUpXt
    at3SlveZtfCNcYikUpAg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzptYNlV1C1yk7253raiyx+O3Hxli"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229OF0ewd8
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 17:00:40 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH 2/2] i2c: jz4780: Add support for the X1600
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261023081452.44118-2-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 17:00:10 +0200
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <465127C9-AE28-4F01-8721-8D819258D45C@goldelico.com>
References: <20261023081452.44118-1-olivier@mgcrea.io>
 <20261023081452.44118-2-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 23.10.2026 um 10:14 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's I2C controller is the X1000's, except that its SDA set-up
> time register (SDASU) is at 0xa0. At 0x94, where the driver writes it,
> the X1600 has the spike suppression length (FSSPKLEN), so the set-up

Comparing x1000 and x1600 programming manuals I was not able to  confirm
that the registers have moved or been replaced at all. They even look to
be the same as with the jz4780.

Newly (compared to the jz4780) introduced in the x1000 is just the =
I2C_FLT
register at 0xa0 which is called I2C_FSSPKLEN register for x1600 and =
x2600
but has the same function.

But neither SDAHD at 0x7c nor I2C_SDASU at 0x94 were moved around.

> time stays at its reset value: 116 cycles of the 140 MHz APB clock,
> about 830 ns. At 400 kHz every transfer to the touch panel of a HiBy =
R1
> ends in an abort with TXABRT 0x1000 (lost arbitration), and no
> transfer works. With the set-up time written at 0xa0, they do.

So your problem seems to have a different reason than the setup time.
But spike filtering may have.

But I recently have seen issues with i2c on x2600 above 100 kHz so there
may be a general bug in register programming which may affect all =
processors
with x1000 and above.

>=20
> Add an X1600 entry that writes SDASU there.
>=20
> Tested on a HiBy R1 (Ingenic X1600) with a Hynitron CST816S touch =
panel,
> on v7.3.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> drivers/i2c/busses/i2c-jz4780.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-jz4780.c =
b/drivers/i2c/busses/i2c-jz4780.c
> index 695be3b21460..5e904b8e6dea 100644
> --- a/drivers/i2c/busses/i2c-jz4780.c
> +++ b/drivers/i2c/busses/i2c-jz4780.c
> @@ -58,6 +58,7 @@
> #define JZ4780_I2C_ENSTA 0x9C
> #define JZ4780_I2C_SDAHD 0xD0
> #define X1000_I2C_SDAHD 0x7C
> +#define X1600_I2C_SDASU 0xA0

see above.

>=20
> #define JZ4780_I2C_CTRL_STPHLD BIT(7)
> #define JZ4780_I2C_CTRL_SLVDIS BIT(6)
> @@ -126,6 +127,7 @@
> enum ingenic_i2c_version {
> ID_JZ4780,
> ID_X1000,
> + ID_X1600,
> };
>=20
> /* ingenic_i2c_config: SoC specific config data. */
> @@ -335,7 +337,11 @@ static int jz4780_i2c_set_speed(struct jz4780_i2c =
*i2c)
> if (setup_time <=3D 0)
> setup_time =3D 1;
>=20
> - jz4780_i2c_writew(i2c, JZ4780_I2C_SDASU, setup_time);
> + /* At 0x94 the X1600 has the spike suppression length. */
> + if (i2c->cdata->version >=3D ID_X1600)
> + jz4780_i2c_writew(i2c, X1600_I2C_SDASU, setup_time);

this writes some value to I2C_FSSPKLEN suppressing spikes
which may be accidentially useful in your situation.

> + else
> + jz4780_i2c_writew(i2c, JZ4780_I2C_SDASU, setup_time);

> if (hold_time > 255)
> hold_time =3D 255;
> @@ -751,10 +757,19 @@ static const struct ingenic_i2c_config =
x1000_i2c_config =3D {
> .rx_level =3D X1000_I2C_FIFO_LEN / 2 - 1,
> };
>=20
> +static const struct ingenic_i2c_config x1600_i2c_config =3D {
> + .version =3D ID_X1600,
> +
> + .fifosize =3D X1000_I2C_FIFO_LEN,
> + .tx_level =3D X1000_I2C_FIFO_LEN / 2,
> + .rx_level =3D X1000_I2C_FIFO_LEN / 2 - 1,
> +};
> +
> static const struct of_device_id jz4780_i2c_of_matches[] =3D {
> { .compatible =3D "ingenic,jz4770-i2c", .data =3D &jz4780_i2c_config =
},
> { .compatible =3D "ingenic,jz4780-i2c", .data =3D &jz4780_i2c_config =
},
> { .compatible =3D "ingenic,x1000-i2c", .data =3D &x1000_i2c_config },
> + { .compatible =3D "ingenic,x1600-i2c", .data =3D &x1600_i2c_config =
},
> { /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, jz4780_i2c_of_matches);
> --=20
> 2.39.5
>=20
>=20

BR, H. Nikolaus Schaller <hns@goldelico.com>

