Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945935;
	b=ptcmb7Imoh6hEObqAOxNGSJwpbh8l7eTok90V/+X+72jMPE6gmTsvb3XOR9ik7v0T5k9
	 hXUq7kU7C8LvawH/1Xff7FBFQR1D2R7ByKoSi2DMgaEMi557wpdh/RSfm0uPr2ko2RKbG
	 bjGqVpKLlp9NJtV0shudqw/+/e33ar48lh8bbbobkTEGGjjeckh0wIyXdHLUM8up4lC+Y
	 UaEVI9SXfNHMyFSPJMSi+RCIweWZi7PPJ2SSePyLVIXu3zEm0gqN3iIL+59YXSVzixBXh
	 0hGBtil7UPJQGiZyh1fbqemCh0fWciuy7Ndlxl2D/+g77yIDGmhMQHpeKehxNEn3uqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
	b=auS4cWz9yy4aTLO3THxAB984yqjhDCA4DI/kKLdOzrT3dlUUzaLlpS8O/FpnvnGqnjYW
	 rPAjflSHrFY7muIopSb3B7WT0jg+6+1n0z2TZyGB5qiUtDYMjtccjER1VWjyj4XtzSoGr
	 9M6McaaaA8JnF3rmmxd2p5nX50jEEk9vmj1GT4SV2/nug39N+XbIpw6HNSIAmfhUU8Yxb
	 UHlLmMFoOAIMUP8Jo2jdDHena7us1ujTbEh/eF0jAOR3qx+RVnbCCEy5ZMRzKkaB2GM58
	 GrK/uHopH3NOLAdFgu5ozmNF6dwstutZRS7AG0yqkV/UFNlg6cD7AjgoLLPmZxs+a/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZwqXXRp;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE37606B455
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE37606B455
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZwqXXRp
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so2056135e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945933; x=1795550733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
        b=eZwqXXRpXTnuGbr0zWQDv0SFW0VKdXA0Gkv36AC7DWNM3f2JCZwrmuhIMKey7QoecS
         H0OeoWbe+Ew3Y5HryOUemzfAIpmTBe0zbo+3cXFeAfcj5TWywnqqUS8KH6+4CNoe5dC5
         DMx9ohgtietqL6V0MOPcjjGV2mYOgHBvXeRTCkeoWJidXvmfcH93RiAwOYfBvFgnbEcQ
         Yt/I3bBD+ffnMoJdyn7goSVtCb5Yu/rXpQ+yp1E6UFTTqGi+Lk7m1Bitzp4Cc0tayru8
         RTzjWbjmRi3knhnx26b7goby3fUx6dhKt2ceH5LUH49XvpfH8Yidkh3HltTbN6YiPo4x
         8Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945933; x=1795550733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
        b=EK55JvCu+13YxO17X5zFsl4wWR1dZ8Hbw6kW4bW3hCuKqd/dAko6rDRteztD1RL7+j
         2xl5ny1xoL6++XToxIa58s3e1VFGLmry7fqPD8KAvU+IMS3ErJOYSr32TNfnk3I/CnJY
         7VjY+hycdHzl/ZiF/N9bE7UMRAo1kb3ds7cuZQf547jAdGFnkNIY777Kr3JmCzOXY1T3
         atpatSQEY6NMs09enXW+LN2mXi33K16lpbcaUMdZeIgo08mLsZKGL70EqahTOoiEozVq
         Gig3Ke1jJ1A2kHbnJgLken5imRwPpA+Aph5sMvKKcaWW6cAHzmISQByd3RhA4sLxvLDC
         l21Q==
X-Forwarded-Encrypted: i=1; AL+hErFvPUp0tJaKvzv8DzxHgrFLbxBXSgWHDAWNbE9wYEi9MqiMshQXGDY0bqvxRfSZh/zyKvY0a0memu4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HcsV3//frbaMhPUz9JqdmyHMccUplOA5rV4i9O9Nf6vMoafxf
	Z9kj0+gG9N3D1r6csQNafFEdfSQdPeZNhJagBvY1taIumxkPpIYVffNe
X-Gm-Gg: AYBFou0Im3x1colA/b8w8f2m4UjGttxoE1QwCpcd4mf7S4ymNpKG83Osela7FzLzdOe
	tGFhb0oYKBn5td1lZxHP4xpWyS5eEzr9ulKsCJnQ3xMKmIA9UorScIg23doqzfxmFzMMreentOj
	LPQ11ZYlD9OZwaKQVw8pTbwAjeR1pPkKxXg+jGmlCNDUGBqdoo5qk85eRZxqdgqQtv1Atn5J7jA
	+XK9sKnrYNaz8Wpx7irscplMU2Ax95bsEiZCZqBMDtex+4A85gCigwsjRyGWqNkixolhK9vp/71
	qynFMWqw37I42HHyFun5pIwADghFP/vORZSK/MckYJhbEBTQU3zzanyuAuwqe4/YtCxaRHffX4O
	A8Y4B56M0IcpsxRPJru3XQN4yqMIVxS4xh+JIyYn7smttOae5KplA2ZLG8qJavo8nvS73HYT5jo
	mGEPMty6DF9k9BLNsxAvv8L66OzMpeaIwTXvGqj43Cp9yLmASpwsb1uW8Mi2VdIWpnS0OzWAvQB
	9BvtPFLKbB+1qmC22+62f2DdD5ZpVhA/S940yv4wodML1GCfLR+53DaPEfOc8bRRYZmtoZs+ptA
	tWZbeSPtS1iNAxKnUtK1F6PrQ3+Y
X-Received: by 2002:a05:600c:348f:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4bb7d9fb07fmr4999995e9.11.1794945932399;
        Tue, 17 Nov 2026 12:05:32 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:31 -0800 (PST)
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
Subject: [PATCH v4 13/16] HID: ft260: i2c: reject an I2C clock outside the supported range
Date: Tue, 17 Nov 2026 22:04:19 +0200
Message-ID: <20261117200423.19561-14-michael.zaidman@gmail.com>
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

The clock sysfs attribute passes any 16-bit value to the chip. The chip
accepts it, reports it back in the I2C status report that clock_show
reads, and runs the bus at the 100 kHz default. A read of 2048 bytes
takes the same 0.298 s after writing 50, 3500 or 65535 as it does after
writing 100, while 60 and 3400 give 0.387 s and 0.058 s. Userspace has
no way to see that the value was not applied.

Refuse a value outside the 60-3400 kHz range named in the datasheet
section 4.4.16. ft260_uart_change_speed() checks the baud rate against
FT260_UART_CFG_BAUD_MIN and FT260_UART_CFG_BAUD_MAX, but termios has no
error return, so it falls back to 9600. A sysfs store can return an
error, so the clock store refuses the value.

FT260_WORD_ATTR_STORE() takes the parse function as a parameter now, so
a word attribute with no range of its own keeps passing kstrtou16.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cf745db8e3f1..d5250bf5da61 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -69,6 +69,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
+
+/* I2C bus clock range in kHz, see the FT260 datasheet section 4.4.16 */
+#define FT260_I2C_CLOCK_MIN 60
+#define FT260_I2C_CLOCK_MAX 3400
+
 #define FT260_GPIOCHIP "ft260_gpio"
 #define FT260_GPIO_0_5_COUNT 6
 #define FT260_GPIO_A_H_COUNT 8
@@ -1592,6 +1597,25 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 {
 }
 
+/*
+ * The chip takes any 16-bit value and reports it back in the I2C status
+ * report, but runs the bus at the 100 kHz default when the value is
+ * outside the documented range. The report gives no way to tell the two
+ * cases apart, so refuse the value here.
+ */
+static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
+{
+	int ret = kstrtou16(buf, base, clock);
+
+	if (ret)
+		return ret;
+
+	if (*clock < FT260_I2C_CLOCK_MIN || *clock > FT260_I2C_CLOCK_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -1649,9 +1673,9 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
 				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
-#define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
+#define FT260_WORD_ATTR_STORE(name, reptype, req, strtou, func)		       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u16, kstrtou16, func, cpu_to_le16)
+				 u16, strtou, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
@@ -1704,7 +1728,8 @@ static DEVICE_ATTR_RW(clock_ctl);
 
 FT260_I2CST_ATTR_SHOW(clock);
 FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
-		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
+		      FT260_SET_I2C_CLOCK_SPEED, ft260_i2c_clock_parse,
+		      ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock);
 
 static ssize_t i2c_reset_store(struct device *kdev,
-- 
2.43.0

