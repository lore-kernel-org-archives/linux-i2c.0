Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399837;
	b=QUXwLem96WBzqgF05/QVQf7bFS0TJTxxDZgAeUA6wGvkE6m5KjCxOWGnJwaniCtx1rQs
	 JjJPBJ5bADRtg/UVo3LeYmTaj7FzswgA+FvVoWFu2GWcTLIeeodVTakgiRsO/i1T4YgWF
	 BqKL8dt+KZByx5UJdNQQhlHnUHCCW6JaUQvQ+8ef2OaftUNI64jl0qwsEImkYwCQyqoL9
	 EdNzxezlCsnc67NAlsu7ccFiGh/jkkR7n5S1Wu7o/AU1Qk4YQIPXOkN5aLNLTjleHm+ra
	 tBkskO7ob9ZGbT66v2UT4mIRVOX7Oh5WUnS+xDN8oncX9MTMs+ORtQ7V1v+DLx/pwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
	b=D5DwqUIBI8V7iVEgXhLsr46dJwQc5/7WTejC7KycmDwIxzniarQMmHW1vEDVohZeNm4g
	 Q8Da5V7eptiP8zhQoVgx0j3wPtXHzS0ip9WczNFYWevLY2SqhTvucLGQNXUHl3LefaTUQ
	 2dNZwkesYAgvGPGpLMbtIitv7qZobojFOvizracucv7bn9QEQGlHpcIFyNync0D81mGns
	 Q2FS/C49EhqP7yniobUC6e9zuihPpyGZNMdqEr98DnKyL+rOxSXuan8bEDCcIxO5sjpJE
	 F9drfXSTp742U0znA0kYOF1hTbI7zAoaQ/s7ryEULPCsu2Fasss08AgFlfK0Tnw7U4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E660A2600
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187E660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8598795e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399832; x=1794004632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=OYiSZd5e/v9Qof0ZiLjCYYymHax/1QU48N2uX9dn4m1M4qccuhF1G7wPnKY4H9k4q5
         PtpzB3sAcrowhyCGu5SnRwnulcJ7mN5TYRubKPzHnWxekRYqBKKcn6vcPvG58wvpXJFT
         /5Dy7btFOddSdWxm31iuemYh/f+k0YgEHMlL9VebsDp0vzJl0OgB7BPRP+6RfiNU6nBI
         yjiLDMgcpLVx3nD6nstKc/BKRdRWRjaTXUJjTgQVhyQm01+g6C9edPm9evr2s2YlQpWr
         HUk0Y7meX1O0+a7b+k7Y2aSF/JhI48htx6On+lmTbAlfeFl1JuUNy7WdfgUMCJQneyHe
         cvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399832; x=1794004632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=PusE7vzbXkHaZV4Hh0eaMQF1XLiz3jPvkIXqQ6lXx6aUhfJzSwy+BYmcZX3ks3Esyd
         /WpZN9iTaY1jlSpX4AvxORXu746AVoydgfMQlPi3kZZvSBWGhj2GygmCEmWh+fs2kGSd
         rzTNsBZdkH2FeH9D8PIEHo/DQ0Vqv8yrq7eKC4Eb5uB5DLhG5AO6tO8ovPkaLaGCBX9+
         VZKM/Q9Kxof5oovoMTb7R2c3W82TEAxXYueD7XtYJhIome3BivOElsuQ3f0NOs+Aex1O
         rFSvlnR/c3zl5AfDc7GMWVgYX5xuTMsRXBdH5kvMTRD/bXNIZrRs8PiR6cbc0MOKWmAl
         ZwUA==
X-Forwarded-Encrypted: i=1; AKwUvBzr04GoOMlp3WXx5P/KGFof2AmQynixXKChnTr9gekT/kFIXTSDBedyASxkBKayzF7H0kw0UE1nc4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBkE+YZrMqGQgYy3HhEV+Bfz1nmhM7fy3q9AeuuxlYZXQiZJBJ
	uUaR1WZaveHkvhARfS54KAmLprw3mt/o0YdRQwxqHcVcVPcSxVeuOEXU
X-Gm-Gg: AYBFou3QG0rGdHjt2juDgABYAjmXpkajwFKiqwmroLM8MIhy1nrPV6qM6cZzCHdyFbG
	IzQ/5eHCLTZA9JTblD49wGScXkn9i3uA56jBRtn5xL+XYn6Yu5boP8uKrgOMCsQZu9Wmv/b8+/Q
	/1iWfQ2NPHs6r1ut5woJ6u02Cpdfc/nnl8Uvc0VAZ4jcUx3ZQ+WraMgFcalpcfpZHjmPGRL4O7R
	znZvFcmCn9POW1+Or284Jz0RHbMYULr0myiRYHQ58VeFnPUhL/EgkrbqF4z77vgibLVEKXvlpYU
	7SvBqXXOAhJdNzCbyCJZ3qQCPH/QUI4T8n5BSY2DVBXE5FgQtHY1z861mbgG3Iy5yGxUWQa6yNK
	zgueOdP1dEsblTi7iPrhKfoxN1MqeTs5IHZORnyM0uXOzyJMy79heMucyboKj9uvru1fKoto24F
	k0EDN6fD4a1lnLnLc7G7U1F7lYu6/56A46u5g/1xHU+Ghu8/l01s8nU2eX4HTf7PI83Pari6+7a
	XgnbO4ZAw8DsMK8V0q0+Yw976pV9EiMemzZ8he563Lpf8fuhCVPtjZdvN04KhSN6yigqeKIqlWr
	r1cLkJ7sOgx2ECoyZNOSpQUQjZtk
X-Received: by 2002:a05:600c:3554:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4ac18c7461emr88275265e9.35.1793399832545;
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
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
Subject: [PATCH v2 07/15] HID: ft260: uart: enable flow control
Date: Sat, 31 Oct 2026 00:36:29 +0200
Message-ID: <20261030223637.86907-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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
index 6f8d72938702..4b0b55c98f90 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1897,8 +1897,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1906,9 +1910,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

