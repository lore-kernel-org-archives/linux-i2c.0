Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697718;
	b=rsawaTunLZOObiXkbIQrhlzP2+Zh2Ygy15+ZUOnSYJbAcX7drkwe+HjPj/NvBXYFYaYh
	 QchyUaMcbibU4o7hdONiyWxLLQ1KQhYD0tPulmG8WwHC7NdeKMjAXCqpUkWEB09NRoqRU
	 OFino/YouluG6dLKID3jz4aXZEpI7MWNWp4SLxNeXl7palXZD1N5tanJdfiQPlzBI3kpV
	 BtzcVgHkwS5c3JQk+UqbxC7HNlhvlmMjhmsoAKMXOh9uvsCUuxdzDIH1Fruv0zK4okN4z
	 SYiF16BRGJGoXIe6dzgPr9U8bzxoATnUYAJjqUCUfFT+mA6YHQ+RFBY5IrQCLM1zp1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
	b=KBqUoQd8koQSNKA3Ud+82ue34TVUujEtXgBKHFRrW40NciFn4S6Bl/z0dQUYOGOS/UT/
	 fFt/tC+OTbrz1795zpMS33h+OAy/FHN7zdj4jWUTxf1YHyEItng4MUV7RKGtoBLS4abGs
	 BCBdOnU++It5zyM8vck/OaYDrmjsNj2LsV6Jh2QXoBTRR5jnjuxwdgiKmk8r0zV4M9wcF
	 4yX5OXQOOplPTB8X1xLK0GKexYpyoldMHrFr2b49sQAPWsrBMRzV9YhJ1d7FuW6t1DfCj
	 ZZfPcAVbYMYxtUS3fOScr0xZy/SNjNNtatd6sLp7OblOkUXTICYAGwck/whhWYolpaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvU31w+9;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112E60A2624
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1112E60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvU31w+9
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49d64a88222so738639f8f.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697716; x=1795302516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
        b=KvU31w+94nb1cErfYmbg1u4f99C7TlkBLz0aJN4/pQnN4ydmCM0hbfUvGIEsSnv97C
         mavbbWgp5H4XpxoEk2ZPPS1a/Oqsga2vScdlpGbPrM7l0WE7KLQAA+IMKEFgw1qq06hR
         tsSqZCPo6czlwGudGlHQUV09pfSVujYATrFEugdgAViqQ8gJYbDHM6CxvoXVLV0qGLiy
         CXSRa0d5mn0s8pHZhLYNFAt/chWeTbWWhc1UNVOn7QW1z8RiXt78FZ7Bw2yCYmhUjm+I
         ayBJ4hnVGJbcYFLVJvrD61xaTA599XAA195iASuvR/KlYCbXmMBGR8ejUaZtZF+fhMK6
         MKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697716; x=1795302516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
        b=RCq7/JrdKra9XolXzlif1izHxiuw7EuTtzpjfyBnuzE/evQcUn4CuVfMtelHr5n056
         wOO1bxQAaL2GRnLOT2/0d/BZnAOL3KdIDoEvyk2yOMN43oA9tCOL7EY8760UPcArKZzK
         Nqarj7VzI135XsdTmoJWF0bnn7JJT1w0pDoAUkmH6VX9P/ow8IgRZoR8cSkPs+XrrZ6b
         74pva61yyzRwIUS7jSFTbe84ws4W9VnH//DQERdOmhhVHwdcum7sMK++rCon9APP28vk
         EMEaVGz35M2lyCpi43OXTha2nOa7qwGAGiKuMV9vX8LBFBytxBznQmERrZGBIiNg8UW4
         RkeA==
X-Forwarded-Encrypted: i=1; AL+hErEJbpjVFZM1UDqD9z+GbOuf+x2MLWrZcZCBc/LlwRhlQ9vzM5Vd+8zxW73SdmB8FQQUyBaEGFS9Qu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BmifbmGgVu/l69UiHlYWkH1+SzF0Mr/Pcl+BaaO+zkDz0pbcw
	8fRaBMioi73uQx7ycnIsP6PK7sJGaUwHfnGjRRr3vrW7OC2AA/kvuZDk
X-Gm-Gg: AYBFou3IpxvUwQBWw/sQ/9l2V3QNqGJfb057LEhQXKECGQopy1j8+V1TIMCK1Xrz7Vn
	kajkMBQ3ghG2/DDYlubMxdQILFNIz6pPWZmyDMbkhgqj8+z+ab22hj9zlaCeHfReqZQAUcuVqXI
	MKLqFm5z1X+l9XN3zuHV4jHMNkjDwEmmagWpFBQcqN/V8fdGLZZQiwuYcv/Fa85zeSOC2ayb9fL
	RwyODxzI6OghBBEQ4Icab3sPiW4Vu3n/glBBNlw9aMK5sUTKim+EIc73RVfpyr85toZMbrS9gA0
	eUS25UiNVVWCZufXV3q63TC9JrsPziMaEpGY4dajknnWJxZoH/g4xkXNBmHdE1kn0CNB7yWfQMo
	8Cgft97z/Un2bDPt/5yQWtooY0ctdd2KI56FUjVimCNVhiTERV6UE1Ds6vC9MsAebxsiBxk5WcE
	KbpfPSPbuCbA2e/IGOHcVL1OYCTSC8fo6xmmhfyeiXKK2Xyf4+8LhAWGX56HuwEBMh9o6BCfGUK
	/WDBw2LEbIvqknysizAS+ddzYHCvJAXUacTQI4Lr6fcehX0eaoOtkRVwZtTqOpdYT20DtUe8Yya
	aE4WUxmCNfDHdp1uTC6z4FAt7LLv
X-Received: by 2002:a5d:5f05:0:b0:48e:76ab:78f3 with SMTP id ffacd0b85a97d-49c7026072fmr13647580f8f.15.1794697716378;
        Sat, 14 Nov 2026 15:08:36 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:35 -0800 (PST)
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
Subject: [PATCH v3 05/16] HID: ft260: fix sysfs store failure notice for big numbers
Date: Sun, 15 Nov 2026 01:07:49 +0200
Message-ID: <20261114230800.1344401-6-michael.zaidman@gmail.com>
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

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count when the feature report succeeds, so the full write is
consumed, and the error when it fails.

Parse a 16-bit attribute, such as clock, into a u16 and convert it with
cpu_to_le16(), because the report field is little endian. Before, the
value was parsed straight into the __le16 field, which is wrong on a
big-endian CPU.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- A failed feature report is not reported as success.
- A 16-bit attribute is converted with cpu_to_le16(), so it is correct
  on a big-endian CPU.

v3:
Subject reworded after the original out-of-tree commit, "Get rid of
sysfs store big numbers failure notice". The v2 subject read as if the
patch hid big values. No i2c: prefix, because FT260_ATTR_STORE serves
all store attributes, not only the I2C ones.
---
 drivers/hid/hid-ft260.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 50389b3e79d8..13dbff661fab 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1484,56 +1484,60 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 	}
 
 #define FT260_SSTAT_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_system_status_report,	       \
 				FT260_SYSTEM_SETTINGS, u8, ft260_byte_show)
 
 #define FT260_I2CST_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,	       \
 				FT260_I2C_STATUS, __le16, ft260_word_show)
 
-#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, strtou, func)    \
+#define FT260_STORE_NATIVE(v) (v)
+
+#define FT260_ATTR_STORE(name, reptype, id, req, type, strtou, func, conv)     \
 	static ssize_t name##_store(struct device *kdev,		       \
 				    struct device_attribute *attr,	       \
 				    const char *buf, size_t count)	       \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
 		struct ft260_device *dev = hid_get_drvdata(hdev);	       \
 		type name;						       \
 		int ret;						       \
 									       \
-		if (!strtou(buf, 10, (ctype *)&name)) {			       \
-			rep.name = name;				       \
+		if (!strtou(buf, 10, &name)) {				       \
+			rep.name = conv(name);				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
 			mutex_lock(&dev->lock);				       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
 			if (ret < 0)					       \
 				hid_err(hdev, "%s: failed!\n", __func__);      \
-			else						       \
+			else {						       \
 				func(hdev, req, name);			       \
+				ret = count;				       \
+			}						       \
 			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
 		return ret;						       \
 	}
 
 #define FT260_BYTE_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u8, u8, kstrtou8, func)
+				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
 #define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 __le16, u16, kstrtou16, func)
+				 u16, kstrtou16, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
 
 FT260_SSTAT_ATTR_SHOW(pwren_status);
 static DEVICE_ATTR_RO(pwren_status);
 
 FT260_SSTAT_ATTR_SHOW(suspend_status);
 static DEVICE_ATTR_RO(suspend_status);
 
-- 
2.43.0

