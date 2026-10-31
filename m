Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434168;
	b=UZZ4sCo8m79j6N6N4cKV96xoi2ajg8vTkw2u9KC+75BKPmbZoMvtIuwJS5cdSE0b9U2M
	 WFt2/k1noIKkhcEuCgWe3uZORxEjRSn1UxkVAE3gbfwy08/YtfkfSutyfjP0WyP9AEkx0
	 A9wlBj678dEvUOVps2zt4d0onHAWJhvc0N1uJZSfIeod7xm8Pm+rpylQLE9itkX0Y4Ntu
	 JXYJ4p1a2zLad+guQBYAjlM4ec0Co+V3HOiXScY7cS9DiCRLZmglk9/jpjq7Dc71nZAL8
	 L+hEZdlHm6usPtxCkymgeM6+Kh3Ftb9KxMPuP+uLzO+brMim4mTpecOaB08qnyKlbLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434168;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=qMp7WtDDsowc5EZ8yz5xTumcSQBgMEW1TVtNkDP5Jeo=;
	b=iARKcFbTN9a0GfpRmCt5tQiLRHUlBKaRE2H+zwTzMmMTExFlc6cj7KdQp0Mt2EuPjC+y
	 bLeYejv0Y6TrEh3abVtWBB3eMsuStjVLRVtBUEbf6yMiTPmXgKpD3l9waYDrH2A6tqiZD
	 ivtRUyixc+TqqyOi9EFDKrld42iUoiNAXm3gCCLMUZwX7Lp+bqFZMrhnOiDTY/Gf4CzIk
	 u26NYmnS36d+/f4JRuebmIhDly3jyvFW37FYmtOJZsrK+QJMVjB4mQ5++VDm3E1NQ2PaK
	 9VaLrmwHLd9nK6d5nidO+Gq3bbdoklWq17PxIx51q778wLhO0s/EHK8ak6jZBnf22mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lUe2Tjg6;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DF606A31A;
	Sat, 31 Oct 2026 08:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lUe2Tjg6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793434165; x=1794038965; i=markus.elfring@web.de;
	bh=qMp7WtDDsowc5EZ8yz5xTumcSQBgMEW1TVtNkDP5Jeo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lUe2Tjg685EgEQdyMvIkxuriEZ3TQQtvxKbr4PeIcF3bBOvvxvcOqjV+mpn6frib
	 qxpFeqRg0IkLVgCYoerfkDKR4FMpjSmq2+y1Ori9zTYcHjcroVyMS93mNs4bQK4gh
	 VKPiDGnjzAwgAi4xzxjvJ8Urj7Jug69qjIVzekmJBEt8icBKfze4Oc++0SMnkh+fT
	 hWO3JKZuFTgHQgfzP5KNVE6gGlfFeGgZ1G4nYCJNE+9wHpeUqjArqLu3b9V5HRSvr
	 dZdSikf+2ylgWAxJ0G5W+TDh5TljRjAgtQIJ0p5iO3HzBWB9TbVFXKh31hYpz5vOt
	 BG29xAYoHGuSLP7dfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1x5GJp47Hd-00IOyj; Sat, 31
 Oct 2026 09:09:25 +0100
Message-ID: <fa1813ed-c908-47f8-8176-24b8fb5acfd7@web.de>
Date: Sat, 31 Oct 2026 09:09:13 +0100
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
To: Junyi Zhao <junyi.zhao@amlogic.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261029-a9-i2c-v3-2-7b30ccc00533@amlogic.com>
Subject: Re: [PATCH v3 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261029-a9-i2c-v3-2-7b30ccc00533@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OAL/h9LrhauZec+Z1Gb3zz5oWOomnw6KwrIHj5kimUqPglHc/5r
 EdZmCeeKQTQMXVFaCkNx8tDHHh3qMGtHEiOLhBPmdZl3QppuMWgLakjX2WVmUqLUqIXE5DI
 TBoNk1jqc2d+Zd4/+ZNejmkeRoyYT/pLeeBtZ16e5/Dw3+qAJlDywPWsyCiSCC0eQhWZbiu
 pGDom4i8/w7r7ulhPNLXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vX50RL4e1kI=;L2CBKnLb3f4+Aiux6yxgEHnch8i
 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
 DNbPqGTB3RwM7Yi6R2Y6FBHvpituNZY=

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,445 @@
=E2=80=A6
> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, b=
ool last)
> +{
=E2=80=A6
> +	if (!time_left) {
> +		spin_lock_irqsave(&i2c->lock, flags);
> +		i2c->state =3D A9_STATE_IDLE;
> +		clear_irq_status(i2c, IRQ_ALL_MASK);
> +		reset_fifo_pos(i2c);
> +		spin_unlock_irqrestore(&i2c->lock, flags);
> +		return -ETIMEDOUT;
> +	}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&i2c->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.3/source/include/linux/spinlock.h#L642=
-L645

Regards,
Markus
