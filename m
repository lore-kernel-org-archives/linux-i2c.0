Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794647451;
	b=0/CiCuuhBJtwEtkY17kgrLYTbMc/1mz6SwL65p8Z21BdlCsMPgN8JovWjfRZhBf/ttSm
	 Y3FYU2nbuBsgCLUnX08BbvuYOYJyvjCXnDdOPlUa+lr68tuvskosagMhbnBDpdkhIppxi
	 o1dXwjG5ilfdo2bm+u5i4E5T6wBDhzr3A9HvELw8k8STWlFLAPQwxGjilQuWBpm5SctEs
	 ECF6uwQXvvN+Ow4T689SVaNz1dQMjHwEUQSm87mpefJKhV2VgbGe1FrTeZ8pov3J13ihY
	 xZnEnQ52qrq8OYLqYl9OQMXqsjpRbzK1ta3RObgXHRKtFbme5OJA7FBneoJz4TU9T5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647451;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Cc:References:Subject:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=f9t86iKgY/RA+c+/FaB5GFCHep1CCR2UihSVVBNfavM=;
	b=rsF6Gq4PJak8EcfqgZ+j/g6hnHWmk8oWz+oFFHMySRNZs4GQQEGMeWceou3o80RxNKl3
	 DPlnPkMHKa5jI5o3M5JsRfb1X/1zkI5TcucBu4tML1bZ0WOSCucHUtc9iX1H/LJqVQO0/
	 CXmwBr45JJPLQ1/lQc+1vGo4bHWUevG8IwhrNM6fOoC7ZjLvxYBohV8ZZyTegTcB2Fn+m
	 Bit+K1sT9l2ffGchhGHAa16Lyf7j6s2d8tZgTB1aOGGn0fbgIHutgMndRgJPrCKzuEXwL
	 iKH1hvWcxDYyGz/pU1cJ+zFUzwZ9Eb4oGcSghMGxxO9mGqyOXxH89tUAiG+wVLU2RwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=et4hn7GR;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E9606A32D
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 09:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 688E9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=et4hn7GR
DKIM2-Signature:  i=1; m=1; t=1794647448;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:KtX6nCi3z2HLb9Iw24CyAPJgGt84
   LzagYRlaYy5hImLCP1BqfkCfU2CDs6ynQvmQ1Fs6o2V234ABSBb0VR06KkUuztoF+4nj6R8UnGp
   Ekr7crMfoSfUggdPg7AhbcQ753QV5zyuN2tgzyV6UTCljkw+tFNveWzwSEez7MB2rId0Jm/OZ1D
   iKclZpSFTr+hZUL/CumC8SdQfY3yuBFM89VhwcpRawrptT+SCdNTLOZqWk6sK5OzQysjJKYYW8J
   ktmiqEVjDQDms0uOB/ge8SMj6kwYT07r1sf5qFDn9yWdZ2MWRILi1/yMd3P1NFHfBPOEQy2YyOi
   JnyrBfI3zXI2pw==;
Message-Instance:  m=1;
 h=sha256:
   zCgGOO46jbEx7tHixHD1B/wiAcFKW9YGy6fpLA4gVu0=:
   srJchHbhFIM00WY0OUPcWUvdjsj8qJknYDvV+oECsnA=,
  sha512:
   AiYlbsKy9Rk2b47dc4pYMTtT8ftYllGiP6IcnRGdbWBv6zE7yymZNBQ9XTFiYyJwppRBtlpC17pdbwWa2sgdyA==:
   yyCIOEFfPsjH7sBC8+dn7B7FhZAOmDKUgHvdI0FfDR6wO8Jfa13fujo9ATKRvMJfTQCBvGAK5r3+MTlbLpeoOw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794647438; x=1795252238; i=markus.elfring@web.de;
	bh=f9t86iKgY/RA+c+/FaB5GFCHep1CCR2UihSVVBNfavM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=et4hn7GR62ZVZ8zIcPn5+JhifpooeSKXPB0txUdnIlRfkkS/ib+MPIgv5+6kebK4
	 xww0lAbCY/l4TlE/APakl0GHjCtPYIbNipgcDP4lj6k9B8V7B11rWGD2Tr8/ITikh
	 NRZJbucDb4XfxaGLRQ2Ae9eM+M0Hn4HmmoqyOZ7i8Yc1qHPQR4Mw4ITDtflHAZGDJ
	 4QIZxzyU37kMcAOmCdBYmLT/b5dNTwovVmLTn3js7Jqm3fHCx8rOrwYZu0d8nPj9J
	 LNH/+onDM2QPItk0wkB1ElnlC35OKVlVLbk2W074NtP0b4sab+cm3FLu+4emB9Qtu
	 QLaPAl8R+2hMk6o4GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SPD-1wSSkj2oDH-00vn5Q; Sat, 14
 Nov 2026 10:10:38 +0100
Message-ID: <c879e1a7-8e5e-4bde-9742-5384ffaa13fd@web.de>
Date: Sat, 14 Nov 2026 10:10:26 +0100
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
References: <20261110-a9-i2c-v8-2-1e9d2682f86b@amlogic.com>
Subject: Re: [PATCH v8 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261110-a9-i2c-v8-2-1e9d2682f86b@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PGlWamaXRSV9ETjRHbx4oaj+rDS9VzYqFmfDjgNQyipWoROWEyu
 QOoVfGtR442ROSMPFBClWp2LzU41mdNsX0GGHb4vhM35dTm0v9f/yMv0/P6ZhhpNqM5dniS
 GQKXs7N+IL0hQKTVXM8omZvQapa9605+2ptaSWISqnCEz75rvhdXWH5R4qPIR2VSolkCrMH
 Ui/QUj3L607YQ3odsAhTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bZB6lC22pII=;Cg6wmmOPLGpADUZr4vaTWj0JUKe
 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

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,430 @@
=E2=80=A6
> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
> +{
=E2=80=A6
> +	spin_lock(&i2c->lock);
> +	irq_state =3D readl(i2c->regs + REG_CFG_IRQ_STATE);
=E2=80=A6
> +	clear_irq_status(i2c, IRQ_ALL_MASK);
> +	spin_unlock(&i2c->lock);
> +
> +	return IRQ_HANDLED;
> +}
=E2=80=A6

What did hinder you to avoid duplicate source code a bit more for such a f=
unction implementation?
https://lore.kernel.org/linux-i2c/84565a50-0c52-45ff-b43a-3d30902690df@aml=
ogic.com/

Can another lock guard become helpful here?

Regards,
Markus
