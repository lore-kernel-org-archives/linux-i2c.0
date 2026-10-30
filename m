Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399832;
	b=xBBaOa7UJN9AK2n2yPicxhK6lxpoUcy7XK6sHXo5DgSgj52k8tIhoixoEl91To4iuqWm
	 uU+2XVQC4xj1gM82ZVEeF5z2ul0N6h52QQxL9m28emGQnCBqZibpH/FrHmNM4b5d3Li6k
	 snOAKAHFa18irA3jVumuoOhtPOm+SEPAXMYn5ljGIBrle8/YQAZ6cD1YD8dEardB0VH7b
	 Mp8GG/yC0tokN40nzroN0cfuI+WpTzqBaMShUDLo297pu7H7msuJlxVg43QuMnW64xCaO
	 oNZWO/fre05+yrxhIhRxA0pLCReYG7K2nRr4ZLsdZAIU8rVk5bOY6vY40v6M4QuR1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
	b=2a95JjK+z/G27jLqNGbJBzLjesU90J0i85QqvfyOxvvazsqjY5SrkpHcn7ocad0eVVnv
	 8A6jrxLxuGcTKfnAEA2nHvbzlxVzl0d4wZiVEpwaLQ1OHwFBLVrufedPkzfOdem1AGmvw
	 0DMBjAkVTEJuWhN+3qFQazqHLOGKvv0uinU4HvS2R448MdVtUMhjnM2doypAA2vh0auhS
	 1IcaQdoXC/eBSaU4DY0Njt6qLqrb9dkkSdf8kcUkngDF2nSv7CW0M40bmO7w+1+ifhhsr
	 nwauDTHWdCi9ubcwIcxdTKwcK709B0LXtnwMxb+IKp6gLnubuBbG6g0P+BdLxmLvpIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PBKZ/jnW";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B560A261C
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413B560A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBKZ/jnW
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso712319f8f.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399831; x=1794004631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
        b=PBKZ/jnWa7mmm0tS9g1kfixlHrM8IMYxEIHY2MEbheruyGor+NpYfhGtHuBAVe4OEn
         Rlhq1kUQhAokfvYgRY8u4jkmegL4T4AcB1oEplG9FIz61gKmJYcVUPIaCv8boO1zaYcA
         o6R46deS0v1dTBsiCHpNe5rB+V/TxVK1tP4uy53Vm69DxvvkRJR3YKaLfUQ/hnEgJaKM
         bJ1CdjOSK+dr+iKAbRthch670fYqnBO9M0VVg7NdGVHqQwregA6vSLYbIzjr52XRWQdS
         xOXa0TOG+UIeeRHYnCCzrhLpdp9aqxXWJFwjyvLXwsBdMksu3/zAm4Ziw7MctucOEoJo
         n1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399831; x=1794004631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
        b=bB6zJ5wg4mc4g1Uah0jpnC7rznAxeFZ21diE9oznp129gOpKg2CQpV4VP6VHo/4RKq
         hPp0/pzcrCjcZ7VoNVN9Cgw7sdSyjMIiDGSB459YhFJKCCu7p4Dm+DJ6/wG2cJiTidwe
         LIWmqUsva1qjWA2qTo8FGxujUJTxHtax5+/A+QkoqPdpNgZTjT3PnjC3OVkZaB4e1pVB
         nXRBfQU0LLeDZy8Thg+YA3smOZs5dBiZisJVfY3KACg0cY7YrwgudvBKC1abDgIqVRqQ
         OWtnhOjQuQGQd3TbVftZT0+OBNomkmkVvIPnDg1j3MT3KnTlesbPyHr425gKHv0eGduH
         QYmw==
X-Forwarded-Encrypted: i=1; AKwUvBxAT6iW7mORqNZvZntKockym+bsvxaYimSoL/GNa5jBNgzt+jza62NH9OA7HGcuy8TdPUqeNwWslEc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0raZmQfcLqKnBlN4RqFiyNLWsFz2qrxpIIZTBWC6PmNeUeeFq
	G82QxU87070+sjfxyLk43zr0jaVOVgsMVi4PvYFrtFg46CS8/UhrvvKj
X-Gm-Gg: AYBFou0twtg1abSl8NFzHsnHBlHHt6Yd/zyNPGd7T6CWX7RKduIpfSd3VdBD4f3C/b/
	SPdN0l+yXuR9pOPVQINKzAn26UmkPSKEX8kxh8tCSwyDMzKCk8vRzo5wDKGk2L3FMop8+/2TQRR
	xb9IPGKhmmVPhdZppNauG7jicKVayl+mI4aY1l//SJFhwpXzpUiucra9bsGvDURqixHshyNICvD
	ZwGU5p1/Kgjk8eGhhPxoxZfYXttNgWgLwZUhHRMCWC4GS+q0Zyi1Ve7YSqj8/4nqShILMgDzbuV
	ngrDk1I5H5DlIUOwIX8vn+vYK5yo48SM8cf5qWYGA0FxYKaQ07wXC1jcdHhrld6GJz0KPJ6ouWO
	8fSS0GnO3eecVkN4iMxcQVKOLMNWYO61DCfy32pHIcGaJYxe7R6Ri5Nl5JgVRc3gVFzV5FORe0m
	u+4rbmIWb4fkmy1bEl4LYTar4oMNdtbzLpiM4LuK9my7P+zONnru/k0SFtWUOjiPyKK/hRrzAR8
	RK754Y0aFZd7TD/sgywBWp/NEAzzym/duZITyMsLS8NMTXdQlIng+anObSfadh98KjiSqeUsmXi
	2OOt8wIaK514THoLJf6VSXzwdWrt
X-Received: by 2002:a05:6000:310c:b0:48e:2a6c:153b with SMTP id ffacd0b85a97d-48e6e2fb0e6mr8615074f8f.35.1793399830633;
        Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
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
Subject: [PATCH v2 06/15] HID: ft260: i2c: reduce bus-error message severity
Date: Sat, 31 Oct 2026 00:36:28 +0200
Message-ID: <20261030223637.86907-7-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or when
ft260_i2c_write / ft260_smbus_write failed after such a status. That was
meant to flag unexpected failures, but bus scans (i2cdetect, HWMON
discovery, transceiver monitoring, and similar) hit missing devices
routinely and should not spam dmesg with either:

  i2c bus error: %#02x
  ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Drop the extra __func__ from the write-path ft260_dbg calls; the helper
already prints the function name (reported by Sashiko).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: do not print __func__ twice through ft260_dbg (reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d2c5c9ed7927..6f8d72938702 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -575,7 +575,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -609,6 +609,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -648,7 +649,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -679,7 +679,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -695,7 +695,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -720,7 +720,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

