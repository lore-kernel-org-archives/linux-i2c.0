Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862689;
	b=IgE0W5/M7JGM+9hrHkLv1EvRufx3a8qPNNGSICyPitafRrc0kFhzTvtU7bGSHNCGqgO2
	 ThgOz/gMpi1Ct87w3WpDLuhJBoTtMOb/VG3PMvXvsmqf0lc3S0cl3wJ8lsKjGI4GqBZgs
	 N0b64/Kddv1IMc9fXZCCMCwHO6j8AXu4zKvhjYdrpsYA3OffzQVdSFbj16JRQ2g4JrdZb
	 xMyGlSjarRZtjPMxMjs2cW+qDymoYQ9dDJwkJUbbu3RaBK2Cv8Ro1bQwXsLxDYWeEO7gw
	 37qM5u3pUZkaLC2YdCgw32cPz/GS1pNVkRR1KLV7cY1MCQKpdC1r5W2PlVNXvP9MUyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
	b=I/0KT9gX1vmCnzpgKV9zt6Uy29QzkJ3zqobmanpGcoMAfO5ls0y8q/PZZGmR6LhNP+9q
	 wU/5p8fMDA7dIikBbOUAPT7jnDM5ChpJsAuYurRiD8Zn+TmFDEHxgVgEDgchbZhcZ4taL
	 lCWRd64XWb9iTFG86tW5cLIK24rT49sQTpL67WI4Je5ZTBgzCPDQZpBNn/E4pW5oyYa6H
	 f+gurlVRGPu0b29gLfh1PQLICYestKj4qsFEdZoSaJr/xNOmRvYvWlcHEfHXUX4w7J8kp
	 vmdndw8S24WdIz0b6RaTp180Are6WXtg2zkHy5scFuxqk1aZAqcjoUQlLxO6U77lfCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xhfpB4p/";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BA606A32A
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 20:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1BA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhfpB4p/
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so15782795e9.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862688; x=1795467488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=xhfpB4p/FLz4tPvQ4XDyzPJZhYbKdby9eMFjsG4ed6t2AZa3F7CPzOfipZSOTimeWe
         BcDpq6gokbNTxIQ9l4fnGfjfFt29zj3RD0h6lHh+vJ1bX552MblcNRz+J8927R5ZmjeF
         iKpG54++B5Tp/HqvgFsBZU/VNWRkvyP+JLjtw/G/z314VyLXrSJcxdPsDrmr/1FXdlvg
         DIdw/tMELU7KsErDToyfosjf4meSG+J1RxQySHwdKjVeXk503qOmotvoqiMa9MiZS+ON
         XrDB4pfb8+ohnHUAfF24YjeIm1F8rDtjJQd8EA/+blfE98B4+XJy/aO9+RNJN9y3qjfU
         QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862688; x=1795467488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=Gj4U9OrDtpZRpijyDmm3H87CIOymTBWlPp7EWqhhKhDs/aWTbhg2s55SRNBgf6erMM
         4bH6B+0UBXEhlTUv90b8zhzW4kLnIHyVYI3GfXf7rkIYrPIzV4O2xE8c8frGYnOSU2b4
         Cz4v+Rlg/qtePtcB08SB8UxqK2UpauaRZ43mbi5zNSRGQczf866g+ysygDxYH8FbICM1
         bj2Lk0zwR+9P282wplcoTxYIHNxh3NLP37oJ2aRI3tdNGC+tYCJEFkdH2VpruoyFNIk3
         8y9VeUWX8ysRvGkun/VjQZo8NwjudXZznOS3rMbf41YgNio4H+O63svHAsDGYmHHD27b
         35Kw==
X-Forwarded-Encrypted: i=1; AL+hErEFgXS0Vw7dm2qlc4BV65OIWtGiQHc3SkMn7T+RxvQe31NtcrHftaJA/+JpAApeEtW2JUzz3/17hug=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZgQvnHCY1A/xhvAI6tBzLwDgvOHMBI5+/yz40KgKwlZuRk9k3
	+g/uuinvlNDe3Ie7hXmN0SfQd3yA1yJQ/gInOinJvELztpue3jQMR9VT
X-Gm-Gg: AYBFou35Y+b55W4QDtQHYPt1dntJ6UKTvJ7bkoefJQs792iVyGiPDwLPqj3VMTukfXk
	OnPyUdFREhF3Doo2Gjr9SUCSZkbgfWHUKsVAy9WotKU/uBPGhFyr7+l4FdgW0k9hcIZgroa08pK
	SZNx0YSvmXThy/4NioAAaUTv8THuwmGCVhv5s+n/SpAYXPY1GQN/bbhZc4SmEJZAtV/JEnzw+DX
	m9PMsZwo9F0Y4hwjxoJaXytyVcX4ttgPj9fK7+O5NevV663fno24qhE6wWcPU1TF07cFwfS6Z3W
	ERq98yTSX2Rowz5RPYWwyp3TP34acGAPTq0zliYIkyG5SpvfN3mKKNrWhF2XwsMc9PAdH83cnqI
	gqUvbQ6OHkFFvepd+ts+Hf/5FixuqJkNAhS+61nUevZ202chn9VtwIWQQtMoGY2tkhlh91ec9ue
	D3X7TBidHn2wNuIEk0DDwNvDqcxGEv9uXFQrKRl7qA7rkfDu9LiwJcnz9AqXIEWcDyXq/uVToBX
	A2fLs1DTd6i1VMCN4n4pOhcFIqXaaVCet/cUwNmlVwZCP/48hDlcTgUWNlcJr4VrefG95EmMCIB
	Nf4ONpDRS3lxn44BXFWRTqEKtEE=
X-Received: by 2002:a05:600c:a00d:b0:4bb:693e:4c8e with SMTP id 5b1f17b1804b1-4bb693e4d5dmr149922355e9.21.1794862687584;
        Mon, 16 Nov 2026 12:58:07 -0800 (PST)
Received: from m2.. ([37.142.154.59])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm20499255e9.8.2026.11.16.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:58:06 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Mon, 16 Nov 2026 22:57:50 +0200
Message-ID: <20261116205752.18800-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maarten,

On Mon, 16 Nov 2026 11:47:46 +0000, Maarten Brock wrote:
> > TIOCMGET and TIOCMSET work only while the modem pins are GPIOs, and
> > return -EINVAL otherwise.
>
> Without checking if it is possible at all, I am wondering why it would be an
> invalid operation to TIOCMGET the modem pin states when they are not
> GPIOs.

Thanks for catching this. There is no good reason for TIOCMGET to
fail there. The -EINVAL came from the Sashiko review of v1. In v1
both ioctls returned 0 when the pins were not GPIOs, so TIOCMGET
reported every line as inactive. v2 changed that to -EINVAL, which
fixed the wrong answer but made TIOCMGET fail.

The chip does the RTS/CTS and DTR/DSR flow control in hardware, and
no HID report gives the level of these pins while they are in UART
function. Two things I checked on hardware:

- For a pin in UART function, the GPIO report (0xB0) reads 0. With
  RTS/CTS flow control, the CTS bit stayed 0 while the peer toggled
  RTS. With DTR/DSR flow control, the DSR bit did the same.
- With flow control on and no data, the chip drives RTS (or DTR)
  active. I read this on the peer.

For v4 I am changing TIOCMGET so that it does not fail. Lines whose
pins are GPIOs are read from the chip, as now. A line in UART
function is reported as the get_mctrl() comment in serial_core.h
asks: CTS, DSR and DCD active, RI not active. RTS (or DTR) under
flow control is reported active, as measured.

TIOCMSET does not return -EINVAL any more either. It ignores RTS
while RTS/CTS flow control owns the pin, and DTR while DTR/DSR flow
control owns it, and it sets the other line. So DTR can be used
together with CRTSCTS.

Thanks,
Michael
