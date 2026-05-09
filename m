Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212713635E
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778359312; cv=none; b=ov47TRVWaailzEa2I0jy78zP59B0pi06cOobbewPmRUPfo/s8rKuBAn13Cvx3BAW36IygDbMf85FXsGYjECnPV89Ao+T5onOuzQCbfdFRD2OjT659SwReRKdhlnGFCoTgl4paYY12MLNE0VBpYFq27RobvEEX+6g0WOUJXY9d1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778359312; c=relaxed/simple;
	bh=7ThaYaHwtjjywC7C37uImibOYLk+JfJKFa2b+ga+QpA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PhSOfp9UdPyFgXf3j6Kq4KwAhGJlKlYkBA6mnic7A2FR9mLnQYLV5MbtQbWhhvsffAvPUuFIySo4BbGjKdsZvS/4f+W4eQ5yQS03VFaN8/DqYsS16rmcVruDOJjoXgbJODlEbyTcTWiUp8Y50xrOkVvPnaR7UNrcclhf1Jv77nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=C0lP20gw; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="C0lP20gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778359309; x=1778964109;
	i=markus.stockhausen@gmx.de;
	bh=8yxfxbTZn8mQsqV2zEA+EzUPlsJKdsctY3liFzNnamM=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C0lP20gwPxb9O/34LEXz+RGHKvUPzgctjOEzF8Q86J2nvhJ6/3djmwyKXr70aChQ
	 0cPoIarenGGzlsE+JW5sVy2UPxmXo4MUE7guMnj9Aw7PKyfO4Ism2ZZ0aB7m6u6M+
	 ckwSTXaw/fgGaufK12lPOPGmjg5JZSSfiL34K/lF1Qyk8dKgKT2GkFiOICrgYqXj9
	 9jzo4NuwthiKTnldWvDa+SrNhl4a8RYUMleC+qhV0NIx+DACPtv4PaiMbn7nOAnu9
	 uF3//RIGaDCT2Q02oI92Ve565u7xeqqpmOdVcQqUWY+7s3LSig+TCwHSpNnJKxETO
	 Kfi7p3BDuOwaWdfBCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1vmClB3zqD-00j6Kd; Sat, 09
 May 2026 22:41:49 +0200
From: <markus.stockhausen@gmx.de>
To: "'Bartosz Golaszewski'" <brgl@kernel.org>
Cc: <andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>,
	"'Wolfram Sang'" <wsa+renesas@sang-engineering.com>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de> <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org> <007a01dcdef9$05ba7140$112f53c0$@gmx.de> <af9xGlIWG_OmREzX@shikoro>
In-Reply-To: <af9xGlIWG_OmREzX@shikoro>
Subject: AW: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Sat, 9 May 2026 22:41:48 +0200
Message-ID: <00ef01dcdff4$42318c70$c694a550$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKgUW0k0IN4HI9csbwIs8kp6Kp3wLKDayEAPY4WTACKFuNHgJo4OeptWhXnFA=
Content-Language: de
X-Provags-ID: V03:K1:pVzEqyV2sM5VJJgX9QTq2pS488ZY/JAAkZ6Ztm9e/ncXrnxiMro
 591hhN/bhcfE1FT7S70ufQi9psenKayYRp18Baf1dTdKv0F4o9moFdlB3Un6yXw6mNqPKC2
 0Xg0a8H9ApKtocQN1MCej7FMoSK0Ko3yTDnAEEBf2IJOjKncyeMkSOZmunFgCINZQzoPv9N
 ON4wvM4hmFZhNq3V9MLyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O2pd3BMMync=;W4e020ALV+IUmem7Baj+QLjBPEI
 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

> Von: Wolfram Sang <wsa+renesas@sang-engineering.com>=20
> Gesendet: Samstag, 9. Mai 2026 19:39
> An: markus.stockhausen@gmx.de; Bartosz Golaszewski <brgl@kernel.org>
> Cc: 'Rob Herring' <robh@kernel.org>; andi.shyti@kernel.org;
linux-i2c@vger.kernel.org
> Betreff: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
>...
>
> Now, the GPIO subsystem since recently allows for shared GPIOs[1]. This
> sounds like the proper approach to me. Sadly, I can't help much because
> I have not used this API so far. So, it seems you rather need a GPIO
> expert... CCing Bart.
>
> @Bart: is it possible to share a GPIO so that multiple i2c-gpio
> instances can use the same GPIO as SCL? Use case is explained in the
> cover letter[2].

Thanks fort he hint. That looks partly promising. I gave this a quick try=
=20
on Kernel 6.18 in OpenWrt. Set the target to HAVE_SHARED_GPIOS.=20
Finally added several backports (deadlock stalled the boot). Now it at=20
least starts.

This dts:

	i2c0: i2c-sfp0 {
                compatible =3D "i2c-gpio";
                #address-cells =3D <1>;
                #size-cells =3D <0>;

                scl-gpios =3D <&gpio1 31 (GPIO_ACTIVE_HIGH |
GPIO_OPEN_DRAIN)>;
                sda-gpios =3D <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
	};

	i2c1: i2c-sfp1 {
                compatible =3D "i2c-gpio";
                #address-cells =3D <1>;
                #size-cells =3D <0>;

                scl-gpios =3D <&gpio1 31 (GPIO_ACTIVE_HIGH |
GPIO_OPEN_DRAIN)>;
                sda-gpios =3D <&gpio1 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
	};

Gives these messages:

[    2.048352] i2c-gpio i2c-sfp0: Slow GPIO pins might wreak havoc into
I2C/SMBus bus timing
[    2.058333] i2c-gpio i2c-sfp0: using lines 542 (SDA) and 573 (SCL)
[    2.066139] i2c-gpio i2c-sfp1: Slow GPIO pins might wreak havoc into
I2C/SMBus bus timing
[    2.076333] i2c-gpio i2c-sfp1: using lines 543 (SDA) and 574 (SCL)
[    2.084817] sfp sfp-p9: Host maximum power 1.0W
[    2.091419] sfp sfp-p10: Host maximum power 1.0W
[    2.200954] In rtldsa_vlan_setup
[    2.397223] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.407907] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.418605] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.429275] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.439937] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.450584] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.461223] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.471875] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1
[    2.482539] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
set_value for open drain err -1

I assume I must dig deeper here.

Markus

