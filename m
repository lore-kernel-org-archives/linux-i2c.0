Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993619;
	b=tjOsBX/ob6NO1oB3vgVzMkDrOD+bpj+qJRxNfDs4BbIqQxWwh2UGNodsif8I8rbRuJEX
	 +KLojIH5VxEupY98zMrbvUPt6cc5+YEEM2NFMW55Ko4PqOhVoWNZMkl4iV1xFCryb4hls
	 5Q1DBHV1HfNN0r/CEpuQ0BoO/E7c2KJmqsqINqrm9VArpI8LYgT61h58sw5ictBzrcAP5
	 xvvS/9HmP6ksKIWxari8sK98VbE4uAQOAHjD9idN7M8oYzAZ4vQYE6aZBjfnXpx2eeZpJ
	 jPgxwhkFnWJhv3KozNf0u2sfG0lqGw0ynM73sQMZhdmdNzWTvSHSvIJOfZuAqC9wNrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993619;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=GObtdwpy4zKEzBxH1BL3PsMjqBCcWz5qiEKunv440zo=;
	b=umthJJQGZlb0RgW50i1MpJgMowrheUXQ68LZXEf2UJvvDrj5oi0xkcSwnY2QQhld+uDZ
	 N3AVydDPaXNVjS/eW63xkBCL0JQTieKyBAwH2wUS4DKI38DD3o9wRyY6WQIiiC4T27/TQ
	 flJah9dMuBVo7SAFFoxtiYpP2oHDb41uYMkEu/mBZN1ETAYeLnu9Ob5C6+0b5QpGZihRO
	 r4G7av+uOCJ1/8i4pTaNwXlkZZ1JEgarcPSCyjY8cyxze2XgcuIOnNE7SdTBSOA90/xbf
	 kq/A74kZgOdWpZiIWkTPDsKx3Y0Qs5FFRchLZT59xkFYYy3OwR+4BzDeaVP20PsqD1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=RaTH+co3;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C315606A329;
	Fri,  6 Nov 2026 19:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C315606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=RaTH+co3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793993605; x=1794598405; i=markus.elfring@web.de;
	bh=GObtdwpy4zKEzBxH1BL3PsMjqBCcWz5qiEKunv440zo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RaTH+co3uoe75fYstb/k794sBnB19U+4mYHcI0GF4rC/zbwVSfDmNKazsoAFkTMV
	 Y2mo+FjlPYsVru0KGqig1Ojje60U6q9UToRUya88R5IrbHlYiKhTo6Z5c1l92aCXF
	 4hN3M9BgNq1MFX5erbxezjpw5Xy5KjJ7+5y01qYYcNmNfE8jFJqXTy9sWu1oJ3nPc
	 3UNlIEOBgfVIcfXz59OEZqWRkc2YWWyStTZT2B4I4ZwW1MnoIzZcW+T0KwSXA7+RC
	 7Z/qnJyBYyF88IKkweL1UMqYETNjtsz+UnAGamSrKwkyrrd9m6fILntNN558xB/sP
	 9PpdKmFwQuMqVdvp+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1wk08y2fTV-00oqTs; Fri, 06
 Nov 2026 20:33:25 +0100
Message-ID: <01d3c9aa-ad7c-491f-b99b-aee731c1ad1e@web.de>
Date: Fri, 6 Nov 2026 20:33:13 +0100
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
References: <20261104-a9-i2c-v7-2-b31f2b53faf4@amlogic.com>
Subject: Re: [PATCH v7 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261104-a9-i2c-v7-2-b31f2b53faf4@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZyrEaLO16r6Hg2c4NfQ4XXw03lVF7Bsy8ldZEwFf3O+mmlp9XPD
 c+bfqmb5NGWxtd5kkVTIi3oL0Bcz22AKwfOuxSZKqI/efy6ujs2C44O+n/8dYzNgYs2iS6q
 Tk1ChyBLB1rnvjUlaxrIWm5GL2f7pu1DuulHnYNKLVN4nMqh1R6fOrZnYmVsFh0WfccV2R/
 BpUXXhuS45TtSrMfx/Zew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HNYvuxUPp2U=;eGrO1oeVBy65YI5WwssyTuTPlyo
 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

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,432 @@
=E2=80=A6
> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
> +{
=E2=80=A6
> +	spin_lock(&i2c->lock);
> +
> +	irq_state =3D readl(i2c->regs + REG_CFG_IRQ_STATE);
> +	if (i2c->state =3D=3D A9_STATE_IDLE) {
> +		dev_warn(i2c->dev, "i2c irq triggered abnormally, irq_state:0x%x,irq_=
en:0x%x\n",
> +			 irq_state, readl(i2c->regs + REG_CFG_IRQ_ENABLE));
> +		clear_irq_status(i2c, IRQ_ALL_MASK);
> +		spin_unlock(&i2c->lock);
> +		return IRQ_HANDLED;
> +	}
=E2=80=A6

Please avoid duplicate source code a bit more for such a function implemen=
tation.

Regards,
Markus
