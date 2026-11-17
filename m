Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945919;
	b=w9soafM4JnxZuT/fR/htAqHv85DDD7tXzXoZVtBHGuiG/wUOxbVJsqvJHNgeLisVGAt7
	 JQH6+GSFZnsq/KAySHYebpFLIso1L4kntS2ZYx3WOe+iHuNplo3Q9qFLTf9aumJOqrCvs
	 DqniMJmCgzTJWIzRRDg8XkwIbdGbQwjUSe7CqecV1Ikzw/a2qHKHxCjK8yUoI8iQslan1
	 2SqSSKyVHYVqDk6XFAu+IXsE9MDy45jAqQLc1via/IWFow3GLdjceETb/rA2KMisr4ZdR
	 hu4XVQxbkeH18M0YC+aqCS79Xak8Tph/VS7mgohbiowlwGrV717w/72dKrJm9M9X9Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
	b=qE/Mb5a3QnMTiiMrHp9GJMSqtXHu1Rs3aPt/A3P2oJOE+SbcSHdb/ZCicDvQ2+McjLus
	 zta7LK0vvyVoVszOHykazu0RrOqbVmO17TtnWmovzL57kzg8gLP9iWjI1TTwk5FiXHYyQ
	 bqCYsZzCzw89gqOEoGy7sORxZRa1MyT7JfAR1at3R+lbj8XARuwrudFpTnbuWWwlwFLsw
	 YJPSgosawifBN71eAhKZR5TTMZygRjvqoKX5Tn631u1TQXzXbeV04n2R5TTkRehibbErJ
	 Jm+dzJ3wbR2PWJa391J0oRR/jyizNKw9Ipa5YYQk15HocbYEkj0OtLY7gMSbx9FJqsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFEC606BDD3
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFEC606BDD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so87981f8f.3
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945917; x=1795550717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=MhjW25tIfRYDFt6msKWXKEZvsJV6FE5BXzi3zLiQABXwwGUAb5mjJJggmlAam4lj3b
         vhPPsArgE4/SYAa+JMmZDpvUr0om/K7XKG8DCsfpZyelmr+S485w1DRAzID/YEqZb3EY
         X7wb4bvJ2dFOfgMqvjavHoFFFYpW0wmrtm02fCdi8AOWM98wqAdRKgVgQLdTzJDL9H/O
         z/H3LFCPflALGVzOGNyE1TDhtcN0oOX/qVni+8nM3ne1xcUh3JxY1QDDMoWLAH6eHpIy
         mDCS2tIKmDeeGidOh7Nb10Y3iVTXYhq2Yg5yb1m4ZCuxEWn22XO8ELQS1Undomc/aKEh
         DOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945917; x=1795550717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=vRCeQRHTc3yFIpwP4xR1k+yNTnQ/ZLtTRCCL7xArBwTXSwrmKaqp6cPVsyQ7UVHv2D
         BAiWbpN6n92beL1cAPKA+OKm6xDdwY+6yXZCFTlliJKznpcy/HjBXmGNREH513LqAP1m
         MN31Ddglv3e9YdoPDUhEJ4O/OoD3Q8f+eyIY/Qx6FoAbNSmt2ScyLriyRmSIL6R/P05G
         IcllwbMd6jrJIQ+HTz1GpZOT7e/BB9BNq1VIwe877iGEJfGzMv0XVYLe5EoUQHrpHYIv
         u2waCAAgSUkQAvJIx3tMCwOnkQggcBK8DgSGaWuEyHxKLqHdbSBalNoi6+Gutl+W3aUe
         tgWA==
X-Forwarded-Encrypted: i=1; AL+hErGb+DQBjMmxPV9gaGGNZjn0I+NCoAFdmmtKDZP+N0op943hbxWKPHZyPUw8zk5OgXlKg0pQk6UHzwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nABuu0IEU6D2PWAytA9K8oqU0WGHjmNliSfsjDRy/FwAexjFg
	zG4lCuheLlvk3aayWlyTg/uifgurPVHx1g344yFHFRoK3oWy1gr3O0o91H1PWZ7D
X-Gm-Gg: AZFdTZd2FxNX/BGHMBmgsEbA+omvPGa9K4uPw30PdNlI4UZ11oSfnyNE7MidDOeG3MG
	BxLf/H04oqu3CdiVqLRFgYEV4VCZx0AFajxmbx6KMclahwk6Er4JSAbECzGXfyRJhy0nUPutyE5
	I4etfTzs68sjPpTO7ezhJoDyyv39KFRNFpo32hLdlcKhqtqCMZ81vQkU9pq/zqOcuBY3lT8qPXt
	P+VrvhCjavQNw2OzR8XOdoDMqZLRCAOJ2aSzmQspGBABaoYXNcWCQgRND2kBOk+XKJFNKrNqP/Y
	SiE8aNsz3OBTjkSyS5eeDlHikAyyngxul6GZXe1n4OzyrWek2WzGEr32fLvrJaw7PwNNBxp1iKL
	ksHx+IY2bNKCVlpq2/jwt091QCVE2hKHX2KxwWDCAErdt/lhrkmiAPyyfewFgee8+J0ECNM0I4x
	x8pXr6VGUPA8WCGL/svojQB/u5cPPwX+2W+Pgk/hHqj3UkCPM9MkcKNkoPqtYkTgv4Rugc0kGmb
	C/o0ZOMClhwdiVw0/7UzxbH0XqTyN0wiGwHrmpnPGrtMumMNBuykMc+yiTtjb6VtXvq6ijBpqKN
	RGFUHJbscMPJMwFnu72EHGJSmn77
X-Received: by 2002:adf:e002:0:20b0:4a1:a2ed:bc1d with SMTP id ffacd0b85a97d-4a63b6fbe61mr885459f8f.43.1794945917177;
        Tue, 17 Nov 2026 12:05:17 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:16 -0800 (PST)
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
Subject: [PATCH v4 07/16] HID: ft260: uart: enable flow control
Date: Tue, 17 Nov 2026 22:04:13 +0200
Message-ID: <20261117200423.19561-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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
index f722ef0ddf06..21789e97fd18 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1945,8 +1945,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1954,9 +1958,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
 		hid_err(hdev, "failed to change termios: %d\n", ret);
-- 
2.43.0

