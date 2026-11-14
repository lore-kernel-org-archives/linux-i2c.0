Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697723;
	b=Yibl4u5iB5cXoFMBTdCVBo4epz6OxLVWXx5/wNNsKCNlC9EV1HWp2NfSaMtjehL5c3fo
	 DLQG9yYZrG+STYmy5vuuDlNWtx6LZ10iba+vngUfR1Rn7elwijJ1byu4g2HUxmmHSY95j
	 ritGP6AxaEF3UycvJiq18TMEWt2OHM69nO2CsSzekQGr2ST3WSv2clQsZmxOPT/pYZi9d
	 NiIfGHr+5U2fxolQLXUplASnRAa6RNSSC1Xfol5l9rQaeQKFq5qaDs+dHMu8dpzahyGR4
	 EqlhO2NWrbn1x85GeAlC+XYS9o11elcj/vG+gWpzqMWCk4wj3s+y4tDyyWhe0LPLxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
	b=1CS7NedevnrueysxcUonttAx7lpwK5XXb7BRaLUs1sxVnL7VK1F3Ej5noQquo8rqa+Kr
	 XaRqxMerUfGaXVEoumMKa0wUIhC7Rb8HKSW/d7TESMyhmy7+DCTd9H1SMF4BJ0my8wl2Q
	 bGUHECXfb2RPr2iBS7XgVM/qhRMDSCwgP6IPLV1ZbAFl2BdFFbKaYZJRodc+O98vtFhdD
	 aA7Fl0zWL9qnTXPalTcJO6tcmZrIgPRbN9k415WsqDu/yO7ACM8ZPyBJYYTIG71yobsKa
	 KwhDMzWKCzcAHg14WnFSG047QGhU++6YOy+VHHEXv7/p6NmdomRmhR4gUjBYgHv9nHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304660A3810
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3304660A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491846221ffso2063264f8f.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697721; x=1795302521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=j2x4AYJG6n6Db9GW977oMzXHN7UsiOwbhnKGYzeeISR1q9eapPvmbYFZYhSzsWSPuW
         p1CKAdFyMmXR+i3GSjxLKah+pfHWNHAS9AVTE4YwlG6Micg5x5ZVyN4gbg6Kp3PAKKZv
         RzkhOdlAZm/ViIGOuyuRIBKJtuqDkTeiNG3UOPwme14HPlkPi8XkATuf/Jg+Vp/9lui8
         As6cgonNIYPmg7jk291hVSLs53wjow5UAgAsiCtE0R3w9ZrzBQOfV2D3ODiru6nL92AI
         9+bfz8dH04ZlrE6UNSmasbmJTfoPeWfRVD89xFcz/X9xZc5CAtzZQIX+mGVLKmCGu6uJ
         qXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697721; x=1795302521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=knT1BO5NvBP3OswYBvW65F532jYljN5BoMakHr1qNC5pA6uOGiKqO+HbNUBFTLE9Pm
         ONaomQKYaM132MyyQ3v87mp9wwEwDmYgBvBC2BuLuN/CQOQ/nlT/5boEnPjxS5nYtkM5
         swGHpLxpiXIfcq+z3jTWLiEYQZoAZA1Hg9fT0+QFjW/MHyiAGsjZ8ZWrui2l40wvQwFP
         jcMYNoJQBvXGlqrjrIfg7ZW/j18ABVep5YN972XbYO3L4Gdb9acOsrNFpQBn4yeMybaM
         9Xzpu4r7dcYbIJdK69WujaF1Ee/OZ1QZm1PGhvzMPBwCc3sijYVuDGBMhFGLXd7iIh6b
         lMQQ==
X-Forwarded-Encrypted: i=1; AL+hErG7xoTYnGFkKNxBKWSNOKz7xkj4vYNHQlzRh6PgW7mZSyA/mf660icDZDJGkqbyVAYM4ieVxBJMnOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U3VrH+E2ivXrRiqybyv6uzjiDr66vyofGQS4FhOXNyfn6igN+
	95jPfxKnF7aTRMBkiPPrRtwq4okCfW6x6EDXECIAKtD25wufC+jrpI/w
X-Gm-Gg: AYBFou2BpcRD4IbAwbioDSRI1tmOtfNZihEkJJSdV/3+nIBaJCkPB71jokvAJL0IkYv
	8D5EIT4O395Nlu93USNPXloZeV7NPih9kF3AeXkHB9HqPqCR9Y3zDBCl0ON8Y0pBarBLwQNpGTQ
	heNSaxatQxJDUtyx++NSSIYWq9fv2Qoc5e6JpAzdLfUK/BnLgesJBCK1C8oaT5o2uRr+H4vc8Z8
	BmVxVQzq+C21OCQ2jHKZHShQqPKN6S1L/OPnzygkTek1T8v824hJDaD5mGauBgEf6GusYZ0qggm
	+E5JWr1wZdyMZaWjAcqXfy7ISNNE4MIkuvQLo8nK5Y0g2NZml+KD6VYinyfGyVBPapQIYxjuTZA
	Mxj+DXDxQtJiM3UoPgrL2y1p39XguEOcrDbB9s2CwyumFGzCohijLaApKsIXOhfoHtH+iwNQNUe
	m4g8iQSbpIZpjLAEecro7a5/MIEokwJQh+vauP6zT21OfeySYVTgKWXQkApolmS+hm2f5hQg8R1
	rqSnwnpWKOexodRdftJvgkYg2dWbsBBKp1pRhUJ7soKIsQqAd0+nGTggPpDV5XA+i6ZznNHjuqE
	1rBBsdPyJH+8NrdQaotgAAIWfvaX
X-Received: by 2002:a05:6000:2586:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-49c72c9c8b4mr15192826f8f.50.1794697720582;
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v3 07/16] HID: ft260: uart: enable flow control
Date: Sun, 15 Nov 2026 01:07:51 +0200
Message-ID: <20261114230800.1344401-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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

The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
with a 64-byte max packet size, so the theoretical UART payload ceiling
is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
above 1M and small transfers can work there, but large transfers are not
reliable above 460800 baud without flow control.

Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.

Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
and with RTS/CTS (~2.9 MB transfers, no data corruption).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 270481766e2c..75ba68e2e8fc 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1903,8 +1903,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	if (termios->c_cflag & CRTSCTS)
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
+	else if (termios->c_iflag & (IXON | IXOFF))
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_XON_XOFF;
 	else
-		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
 
 	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
@@ -1912,9 +1916,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

