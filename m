Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921680;
	b=Rzglfijd78+1SYqHKjoIiHmTBEAwmuL314dyqZQnTJ0Lp5lwGX2EetsWIFJtaWnChWiS
	 l9FpTPghvF0UC8nmN5Fj4CU4LnAp3r18IFwIbS+z9IIrYmzAoCzew5vgcJE4kOJwXSUfU
	 owKbC/Q6802v4VlTcRB+oVivp/X6dbZ/PE65yJU08LxW9X9+/BbspkEVWnF7238Z7KSKD
	 mcZNZY2ik48fKytcJG7Ya980t8qwI6ndZ9AaMZsrTum9pT1gqNnYZH+hy9vjsrC71urir
	 Q76y0ChHnw0D3c61JVfFfsWDrpB6KZ1U0UfXvskF2CZi6h4F/RATQhFb9ryRA0tR1JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921680;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=O15KmHjK/IjChmIg1MswoAKQRe54mKR/YNVKMpoI2GE=;
	b=xaZxUT4IKv3jnJz5EILuXtEG/VlF5Bs8Wy9FURDKGr4zDGZYBEvtGjMOJqPiQOA4/vFm
	 wvYCGD5qMsKkZOjTgbXq0wrISgclDKFDYwXHiLHgulf4f7jcbkAFJBOlzPUM0YL7ZG3P+
	 ocDk+h4JwPKwR8UGh5n74aFGjGOjlsyAylG3N/370tWSIENbM35ifD4VKXeJvPIAXuhkd
	 mHKx17qLLbUTLVFDXjGqcRJhGE2t05V7RwzF+01OFMCB7eIdQdBag+zwx17B58BVqfNvv
	 /VLb+WTjrhiuvpoFSL/tRGDoabnEjygRsmRHS0rzn5lBFzRoIC6v3fZLnBNirQkngBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aPLpo4Y8;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF47606A323
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 13:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF47606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aPLpo4Y8
DKIM2-Signature:  i=1; m=1; t=1794921677;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:pWU9Flf8757X3U7HtdnwYcWocJ45
   AwS5tSxlLyV0cTpENOQ6aPZKykv/lH0ynRP2cA4cl+6/endMsbDQuG/C8845/qEpQCwzpfA5J3T
   ayKl1j62xNuo/dY/10eZYpA1jpIgx5Hnh7URle3rM2un2seLuHCV4xgtnxEGGr0mnNmCyLEqGgc
   noPjAvAhySRcSNS74PsGK5Pj45xO1jiGmRLms28PsXK6szKsUT2KlWz3AkOe54IWmls7jV67VLT
   hCi17Upranbu6o73RdBMnkT8ZenDvoJZy20CvTmkoJFNC7mdPNZrQtgbJV+ix5BQ890Ck/Prv/d
   t95wBbJd4ymeMA==;
Message-Instance:  m=1;
 h=sha256:
   wk8Ebnxj9+uopn4oAfe8XpNBl4GkL+Ot7cX4DU6EhPY=:
   S8Svh5yjcoWGeKVpnzI1TFn8gCquX/Z15gpJRqPt1ZA=,
  sha512:
   8eXnFb3w2Nkab4Z+20FZIBTTnw0F9c+jvS27XhdGtw7lliSG6/ZuKQxlxjGaeXBQIHAKAn2souTmbnt1zZeCdA==:
   UMcSWdpUjOx21yU3m9ZtF4VAL4Bhqao2FLpjla4ft5MnND5cAUB0Goe3D2UTUhc6WdqxmI2fGmu2nIV3tvqpPg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794921668; x=1795526468; i=markus.elfring@web.de;
	bh=O15KmHjK/IjChmIg1MswoAKQRe54mKR/YNVKMpoI2GE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aPLpo4Y8DtSyFl7Mthdr+W+ylySNgZTQrZ58sb5NGgqFj++PK30a++2re0BR5bNi
	 kHyq963u5ID0J6uvg7/xalaJlbmaWR4P+kMmZWo487/b9e6jYpRqpejAYvU69fGGB
	 xHDPZCjO06OTE71k8ng6BCFoqaaOpHYr0b1u8HO6U6aPKlSB3TI/VLD2YqqXLKDb7
	 FWJ5mGL57y4lVWyAScHYHhXHO4aoyhShuqgsn7ZysVCgc7wYYaA1MYLg8w82FKnXL
	 OyvUEyydaGWYpRBSlJQbwK7WdV7Vt6dIVAQLEtxNPXnNd0oMMCXVj9ApjVJscIG/7
	 DN7ewQI4V+tOv4vHHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwjc-1x520i1eFU-00Puxo; Tue, 17
 Nov 2026 14:21:08 +0100
Message-ID: <23a72c5e-7eb7-4a4e-9f06-fdc4976b05bc@web.de>
Date: Tue, 17 Nov 2026 14:21:06 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] i2c: amlogic: Add Amlogic A9 I2C controller
 driver
To: Junyi Zhao <junyi.zhao@amlogic.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com>
 <20261117-a9-i2c-v10-2-33ea9aefce20@amlogic.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261117-a9-i2c-v10-2-33ea9aefce20@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yeW+56fcqwFFgnUzBcgflsIOb76VlxacHTsho9siUjw90d9mZHr
 dxav4ru3MrzMawKzrlfhN95X+hCUY5BaAYCNL8np5RMU0dDbKHJcmS2wbMebvFXgONnUlOV
 B3Qfk5dh/HntvJU5BUcxq5/6A6Zrgk02MbN3K4POWPqD4Zpr/bwhUeXE+EXmNUn5+dWgeWD
 QkocangnXLGbMPiABL3uQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HIpqy9YjjqI=;apDQbC5a7Xs5fGXisT7dSxx9Hdl
 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
 F/mz2v8wPPH2F566/h+HFA=

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,428 @@
=E2=80=A6
> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, b=
ool last)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&i2c->lock, flags);
> +	i2c->state =3D (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRIT=
E;
=E2=80=A6
> +	/* Start the transfer */
> +	aml_i2c_do_start(i2c, msg);
> +	spin_unlock_irqrestore(&i2c->lock, flags);
=E2=80=A6
> +	if (!time_left) {
> +		guard(spinlock_irqsave)(&i2c->lock);
=E2=80=A6
> +	}
> +
> +	return i2c->error;
> +}=E2=80=A6

Will development interests grow also for the application of another scoped=
 lock guard?
https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/cleanup.h#L=
325-L328

Regards,
Markus
