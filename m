Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442416;
	b=5MHdRJR8EurR0Dms99Khjt39XMPcJF38v26honBgCqbCS4wou/4SBS+BGMHVkCkg+JRe
	 tX78kTG0CJbdb9Nhk5CbfC/5bjiPwudKyqmDqnzSxQqIftPnIasJKymW35aNjQpikXdVu
	 Ut2Bw1oiy2BPIkRBPnOYStolxAt50n3xniNHTUwGgkHQ9isK6NZyKXixIqxP9CcFE+zG4
	 +FiqJi4bzOXSX625CD0utYot0YGTA7V5yJTDnWVK4j9gMl5RQcymQBK4A+ctGtWlmf1pv
	 iwHFxldqEmBHzDKl318yp14q1Fwl6ClSU4O6vvn/TvMcmlFiYgAq6sX1XJ2E4+3WChw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442416;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=Iy9HO+gNK9IXjb252RiD/ED/eSAHfegOWLBV9KmoOlg=;
	b=nsr4u1q/ggXsrnlAZ2HfOIMVUmCzJv7H7g2ZtcSmdU3ItB33tNML3EMA+y9vgN3qHlqw
	 UxAA+w7V8jua7/93mM4FcmQZQqM0+qBXTcqZoJZLnBCn1Gz0gg1Wb4quEEXPQhljGQFXC
	 DUIifeCzeBY3hwvXq8VY4wSsuLx6ne6b/rLSzKaOpESCFDtLEIeJUHLAJAwRZHfUf4pQt
	 BnYo3nHPV50/E3VLdtdimq5LWusN9dioXLeaI/D2xJj0HMObhRmslIvgUnnlYtxTjFy58
	 5kjfKQ0scdclOa+BwC50uM1c2cul46KdjkN7gFptxL97PsmIN/z6EdZpNjEfLxpxlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=b66X0nMk;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0488606A31D;
	Sat, 31 Oct 2026 10:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0488606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=b66X0nMk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793442406; x=1794047206; i=markus.elfring@web.de;
	bh=Iy9HO+gNK9IXjb252RiD/ED/eSAHfegOWLBV9KmoOlg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b66X0nMkpXM+SPIdlCzJGbVo9UnZSbu47whgkHknTDLayfYm+2nS0DWH3slRPgjb
	 R20Nq5HZqV67iJ0qxiZIK3gpvONRvic+C3khiF6pB+wsqZcoJd5B/770wCB7HYT8V
	 /IkBFdqH7a47YeZbUN3yjsfYR2vSSXpJlHJ0d2vdeQ8xsa3pGsdvK4sd2AL62dVUZ
	 rsLDmAXzcczO1hsIZqkWyy635P+8N6IU2N9/zK60MxtipgihFmD/LrgQQ1IG9PLtu
	 R3qRvOfgqVDzfst8Wn0A0E+z8NAfXLd1MbV1EK6RC2X0DPxelDBkHiXSowljNsHii
	 VzerlXsf2TewKca3uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1wZh2X2xzr-00wzHm; Sat, 31
 Oct 2026 11:26:46 +0100
Message-ID: <d675424f-fc17-464a-9495-b1044806e5b4@web.de>
Date: Sat, 31 Oct 2026 11:26:35 +0100
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
To: =?UTF-8?Q?Matthias_G=C3=B6rgens?= <matthias.goergens@gmail.com>,
 linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Peter Korsgaard <peter@korsgaard.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261031033244.2491032-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH] i2c: ocores: synchronize startup with interrupt handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261031033244.2491032-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FkegX9u/T9rNelzN1h2FbJC0jzo5bF8PUe4Lbko33WPnUdhMny6
 bSywjlumAWAhnAPmnZyAN8+/5CN2ndIVgzMX/oVSiR9tyAQYOQiiGtAReThJ/G0n/Q8OeZz
 4AOD6WuTUgmk2ehdzvjcOs3UJ6IL7T+YPWD7smpXovfnfex83KWDFSlo5QNrVL1E1nJ5Lpc
 bGBCzBuCiVJwG/0SL3DDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j37D0ZGQw54=;ZMKPf+4vmB1k8SELokPX8Tmabn7
 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
 ZWy1DsgAuEdv/F

=E2=80=A6
> Found by Sashiko AI review.
>=20
> Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@=
gmail.com
> ---
=E2=80=A6

How do you think about to add any tags accordingly?
* Fixes
* Cc
* Signed-off-by


=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-ocores.c
=E2=80=A6
>  static irqreturn_t ocores_isr(int irq, void *dev_id)
>  {
>  	struct ocores_i2c *i2c =3D dev_id;
> -	u8 stat =3D oc_getreg(i2c, OCI2C_STATUS);
> +	unsigned long flags;
> +	u8 stat;
> +
> +	spin_lock_irqsave(&i2c->process_lock, flags);
> +	stat =3D oc_getreg(i2c, OCI2C_STATUS);
> =20
>  	if (i2c->flags & OCORES_FLAG_BROKEN_IRQ) {
=E2=80=A6
>  	}
>  	ocores_process(i2c, stat);
> +	spin_unlock_irqrestore(&i2c->process_lock, flags);
> =20
>  	return IRQ_HANDLED;
=E2=80=A6

Under which circumstances would lock guards become applicable for
affected software components?
https://elixir.bootlin.com/linux/v7.3/source/include/linux/spinlock.h#L642=
-L645

Regards,
Markus
