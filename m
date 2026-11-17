Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908180;
	b=trbtZTCT26i1pIp0Tgn4ZvcFK3vdKgToOpxtIEvw/oQ16r/+rcDMuVL5SnvEGynVG5/Q
	 UKnDh2O+okt6B9RE9cM0wQLf4Uf7N2RyPwLY5BtwPLc7WuomXGr/7DgTr9d5E9pTI8aXJ
	 fgRT51iKQMbNv6zocRzSLq12YdNQ01j1nEGstcCgqjWdWjkmn9q6U4lRw2IqjSU5BiANu
	 WYN+nDkkfm5iICGNBznnig/5ie7WvUNde0T5AeT7CrGtm43Obq8QiyhKtUT/EY3FnLEfu
	 hXxy+JIbXnwVxCQVE6z2/NA+yhJL20gKhZp2D3WWe14SnNGzxCMRke/Pgwvqk3ulWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908180;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=/ncvCBklO+h3bmh0YuAA0BLzwrczN0XE6jYGCKN67zE=;
	b=MPW880J6ZT3FC/Yk4WPwSwHbRFT3CJTQErlFcuN9OCwpZ28daj1oqD5r+J/XVsVrACIQ
	 w/U/cPl0BoJpoMEzngTFUB4Ohcu2p3K+MJZRTz0JfrHgNVFdfQAjPg/xcWm73sUxZktAc
	 XBDlT9NsHF5nJd/XvEHXtOGhnU9xYydCVHOn7lsXwU9arvc9uZKm2KIlw+THDzK2VibvH
	 yQkR+34iALHFE72DSpS89CwuUxcl1Oe98ouBS12QOIFBCg78LQbG1dBAhHxH6s8e/loTC
	 lhs1R2QL+riROowqTChLPiBCC/3vE3LH8MpJVQkhs5Bjv++MATl9VB9XM1iO93rShfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rNcJslrw;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E606A31C
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B689E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rNcJslrw
DKIM2-Signature:  i=1; m=1; t=1794908177;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:JMk5aDaaWgKTxcpkoOHLdeZocE5k
   DqqKc7pI+k9oxllhCksl2VrX5Ls3CRDBeNkvOeovd7AMMjBOZuixDF93EV4uajIxMse/++SNUQv
   5e/6M5uIOUzargxLI2V/dP/EY9jnepQhO24tLHLsXmL9HlKv6WK//qEXBrKbGgqTxE0P/8f+nyF
   7UgqMS1DKxrerDdjRbSNNbAZ4Q5mXK/iYwzOyot4bdwlu8kyJRjUgsTrIZQUn4QG+uBdw6AlP9+
   AZ5CEpB33Fxlax/PB0O4uyGQgQo9v1EllrkXs64Q4ShgzgRtGsn9ImvpOgTIvoHB3dHqFQekXwg
   RqRqwhIs7Vsgpg==;
Message-Instance:  m=1;
 h=sha256:
   gFWHieg9IP2NAvvVFo9wy0+uKk+v0UsQq0r2F2jggMU=:
   vr9YRkKriSGaiTcbRKHlzDxAQWDEJoMvRNZb2AgR5iI=,
  sha512:
   FRXhmwknbysRtWWPG3zczLdVufhvTzeTis4TH0VDg/MWNWRSVeA1Rcs/hDnoxOgjGnuHSMUw1mJgIJ+eayA52g==:
   jqIuvK3+1TAxk9pWVUGI008LCUqauSHD2Hc8vfGt/Ueoe7MynipYEU/oUzEZiexfx1a0aJ6h0+ee3mKdTEiQaQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794908174; x=1795512974; i=markus.elfring@web.de;
	bh=/ncvCBklO+h3bmh0YuAA0BLzwrczN0XE6jYGCKN67zE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rNcJslrwTE5ioXjjoilZ+8YXZcJrb7DYgY21/lpN5rADEN791MoLb+poaB1oPhAo
	 Xm7EBurUE0KdlxDG7ALRyZZ7nZYYaWnR3tcioBzmYpTbh0TMw1huE6ceThwfzIK2L
	 WuNcbMLqYeQqOj/mRLS8RhJkEJbpr+aj5G0hZVVHgGcIa4r6FRm6nUrb2ykcxpp1C
	 vDyySjXXRTZ2U31KuArQVqp0JON8bi5yNd7+ly5MGO/NePI+4KR08MxdWKVD4p2w+
	 Q/9Y4k2pN/0T4zcjYKsMj5kNNpT0fZLXN5V9HcQwmMHSAbKG2gptlgWD4IgDCShmr
	 OzwwmHH2/rnlBxSwng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1wkXP63hTB-00ftvk; Tue, 17
 Nov 2026 10:36:13 +0100
Message-ID: <7026e0f7-5d7a-4756-8783-4d8558f420d1@web.de>
Date: Tue, 17 Nov 2026 10:36:12 +0100
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
Subject: Re: [PATCH v9 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
To: Junyi Zhao <junyi.zhao@amlogic.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
 <20261117-a9-i2c-v9-2-7b303c894fea@amlogic.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261117-a9-i2c-v9-2-7b303c894fea@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/J39E/kYdcq38YYmZ+UQIGSjVMVD0fJ5p/7J7CN6RoGMKAWuBkx
 0neGn//eYso/T5Nlp9jj+W8CjZKsqkEwPK7Rm/UMe5uPrTw3UvNRKJHwp9Z4dYuUjOkB9wl
 rCeyxi5YA+3DD+pT8lZ1UE+tGF99l3xLGXw1Ry/84ocxZfYQ39NBCjrKvrVMsoMdmKAIwso
 1OBGLxM1E2/FkVPCIPz+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wD/s8A1+KRs=;BMf0bprPYsRhLkw88vYqbbMK0y5
 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
 TFbQdBOn706vF0MVs8tXk9K34xR4aQuxBn++O1I=

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,429 @@
=E2=80=A6
> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
> +{
=E2=80=A6
> +	if (!(irq_state & A9_TRANS_DONE) ||
> +	    (i2c->state =3D=3D A9_STATE_READ && i2c->pos < i2c->msg->len)) {
> +		return IRQ_HANDLED;
> +	}
=E2=80=A6

How do you think about to omit curly brackets here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.4-rc3#n197


=E2=80=A6
> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, b=
ool last)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&i2c->lock, flags);
> +	i2c->state =3D (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRIT=
E;
> +	aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_FULL);
> +	reinit_completion(&i2c->done);
> +
> +	aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, (last ? 0 : BUS_NO_STO=
P));
> +
> +	/* Start the transfer */
> +	aml_i2c_do_start(i2c, msg);
> +	spin_unlock_irqrestore(&i2c->lock, flags);
> +
> +	time_left =3D msecs_to_jiffies(I2C_TIMEOUT_MS);
> +	time_left =3D wait_for_completion_timeout(&i2c->done, time_left);
> +
> +	/*
> +	 * Protect access to i2c struct and registers from interrupt
> +	 * handlers triggered by a transfer terminated after the
> +	 * timeout period
> +	 */
> +
> +	if (!time_left) {
> +		spin_lock_irqsave(&i2c->lock, flags);
> +		i2c->state =3D A9_STATE_IDLE;
> +		aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE,
> +				 A9_RX_THRESH_READ | A9_TX_THRESH_WRITE, 0);
> +		clear_irq_status(i2c, IRQ_ALL_MASK);
> +		reset_fifo_pos(i2c);
> +		spin_unlock_irqrestore(&i2c->lock, flags);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return i2c->error;
> +}
=E2=80=A6

What did hinder you to apply further lock guards for such a function imple=
mentation?
https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/spinlock.h#=
L642-L645


=E2=80=A6
> +module_platform_driver(aml_i2c_driver);
> +
> +MODULE_DESCRIPTION("Amlogic I2C Bus driver");
> +MODULE_AUTHOR("Junyi Zhao <junyi.zhao@amlogic.com>");=E2=80=A6

Would another macro call =E2=80=9CMODULE_AUTHOR=E2=80=9D become helpful he=
re?
https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/module.h#L2=
33-L236

Regards,
Markus
