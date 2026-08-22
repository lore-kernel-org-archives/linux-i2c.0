Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094A38F64E
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434849; cv=none; b=P7V8aXaJiTChb0WR9Mz37BMRosKfmFgp5Gd2QfmWXQtB+YGCk8l/EEo0JN+aI6sRcs05gubpRFFGl5lUkhkKAjUbDQchb5gMuOjBLpGgnGP+iUuACceyPDBSUxgE7DjHzdUZqe4XLJuvRRmUjnKh6mti3Jor+rwi3TBJXDJnofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434849; c=relaxed/simple;
	bh=KJT81DzlFzree0N2sQdZCS66jmiyMjzLoVvJJAuquTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkDeO23uOHxpgmu5MTSz4dUAdRw/O2ULeaH7S5fqCywdyfadmCWN1cAACt/FWvPTAy+7KOqbad9NlqKFCXSXXBSelTyKGmo7wHQ9aKuKb9EUKBzc9eaWEkOlH1Li8m23zchdBpb3O86lYnssRd2hYaV4+VRLffe0EGJNWXmBkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2zZUjGz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2zZUjGz"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1670dad7a8so388877766b.3
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434840; x=1788039640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xIFPtL0bXPCQ9Wv1lusuTgPka354Csl8JdgcZxBeVs=;
        b=s2zZUjGzASqYCl7eYhoarDStryZT2nxU2QAGicis0Ajt5adlzBMz/6+19AHu3Qz+ef
         9JMCA+3oO0tN87vRjKjIJjZcUbxeojSXIezk3MaVaEdUeMS9v5SyvYPmXgD2gCyqZK8C
         9IiV/Zwhglz+8RVa67dNhO3DrUFK4CE1IN3et0oJPAg6LebGRih/ebxeifv4Wc/UElDF
         lOp6fsv8sfAbaSjF7awSlENOLCnJre0bB6JI92VDIZ+gs0G2MeT3eEA4vnZJlAsXcVOW
         i+pV37dgMXriNAdfbYiR68xdEWjaMupEFdA8OBuICFv3rpvfkO4NQBMMtzoG7V8FXLB2
         j/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434840; x=1788039640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xIFPtL0bXPCQ9Wv1lusuTgPka354Csl8JdgcZxBeVs=;
        b=QLPTXY7BaSizopgrTvpr0jWZKoS0zGJI8Ced/laTL6tbd8zY/dU+he+1/DaOHYjYSl
         J6l/eRDmRJkZd7sp+3VHU1WTxcNIv0BOOmfm3x/DiOT4wT6RJQOoY9QQnzsQXL0NpI2D
         EfGNYJEzAJcZm3goX51rq0y1+/426bBQhIhpJCBp+2euXgLrqwEOHGkuKX3BNTmisHzO
         a1dyD7fKogHuWNmtpvTMGi79LwkfYEMScbPp5duR/48LKLnkaDJtCdFvjV/j59F9N8YI
         pZcT9ycaobz+nrwD7SROSv4QezKzRHYG3lbJYt+6oHXrd1sG4EcINqo1EIFy4AHfvx0N
         8Pzw==
X-Forwarded-Encrypted: i=1; AHgh+RpzX9yUhpc8OUvLskW9iJJHelp3HLhbn00fKXS0K2KZe3o1ZJT3TbUS78NQR+VqeUR18V7e+45vnro=@vger.kernel.org
X-Gm-Message-State: AFuF++mJjHxSZqCWQwITM/DMycC3EKfau9bs3iIUpjKYFBWBgfikD+Wo
	J/aK09Jovrb6Fu9yP5iSRjFWxpdDVCfsIf0RdIBmPOvLp2zqOCscFIIf
X-Gm-Gg: AR+sD12l1bYZSRm/XB0SFoHMJNrHAhxRu0jFR/FbT23JBk283ZV0O+22mm5OU6WWn3l
	6rlKbLjE43fAXt0WDN0mbQNxjOBw+vHmpFbxp3KjarnJvbvJRkCGNkQSG8um851lFANhjXapP05
	RUIKSvBjyhyztFqQKp1gWI6Ci7mEVmKNe0XfsuoXT1+lX5SezicSSyw3zX0Tm+wDIEIckNs8aQ/
	jKiRKLa1tnOueZnJMmelBghk+n95MXPRocigxJ16lvAr9O5s/nwB/vt3ZYOiZ2WTcQ9fXMq5eI3
	zGc7ULKq979mnjr5q8LaMGVszfN4eyA1+YWlxchoutUzFxjCwE4ICGwKljlkgPNDk1BMHiDyI3B
	qIDBiLDMqZ46OAkBN37DF6nZt92SOUfzbgVCK9YMNZTEtxhJD7mYn//t59xAauRCct95r2/0oPE
	F9E3QLXgGoBIHTpgRoJIORFwWs/jh7zirX3+RI58WDoznOG+cLm+6mrMjczUs=
X-Received: by 2002:a17:907:3cc2:b0:c21:180c:d82d with SMTP id a640c23a62f3a-c246a725749mr1773091566b.20.1787434840266;
        Sat, 22 Aug 2026 14:40:40 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:39 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 07/13] HID: ft260: uart: enable flow control
Date: Sun, 23 Aug 2026 00:39:35 +0300
Message-ID: <20260822213941.98882-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
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
index 1ed3701eaaf7..1da42b8756d8 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1868,8 +1868,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1877,9 +1881,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

