Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399830;
	b=p+eAB90nBAikR6179JToOVGuiwHwDcZgotrRlHcAIfOZLSChln4CiYTNs38ooubnjc3c
	 aWfjiIi9IU6XBK9ndDxgaq5ZYOzw0EpAFBJmTXd1xgxfcDqVwtHWPbnNTE6FkLvGrpzeo
	 FK5eBq7dd75+9GT4jJ8ExTRQaGfeVYCIPclqkh3oC6B8vCcOqO6POHrTy3QRsUwTVcn+i
	 lbudSYr/DcDMpW1DL1LRL44i3WU7gGM3KRAJYcQekJYKwCGX6qkaz4/iyMuc2j6plr8am
	 309CejI9SP9tPHCTyx6BOhfzh/qHUp4wWxlfBpFvH7aHeY+vU4TRuDAihgATLb2PfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
	b=lREs87bM+FlMCnRxraiHEC0xqP77zBZ0yKWaFdQCYTAvwinPmnb2+GM6rMunweG7NFly
	 hyDmUFvPixEzM1PKUWYNHjcfMGQLzQjayNJx9z05YgeBMliAX4uZR+b5HxWaycUVrMX9L
	 eMgTS4Qp9DUF58gGd8v/kqm6D8fyrE3L3UexHGhph1GlrVB5kBKVnC1rIjf6EWvh2uJ1m
	 kFbC79bPVUlEdeJx9OuVnCrzQKjqsDm/AL7CVPbwv38j5ajfRICwaQT0fnJdPMT8dv4mQ
	 q8NwHS5RZ64aGPWVB2kYdN7ehrjjZgwB2henbEvjbmwqqcoiIo8IWwTF09ND3Uj9TLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oqx+qjv0;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5560A260B
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC5560A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oqx+qjv0
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so1378787f8f.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399829; x=1794004629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
        b=Oqx+qjv0B9aYmzbqrMp6NkPYsKGGi6CEdI3ZwK5m4ZvQIgJD6evJAB+UldKvLqSTEZ
         BAc6YFrfJTQotqsXG3LNY7s1VE6RFYAvVn5Y+RrW0v4mrNot6K9R0Qn3SRqRmGOZtXLd
         4v4W33vfDbb2KWtX5p013ch1eFE0tQV6yIrlPH6p6zPgsLcDDH3lXQUHPfT5C12peinI
         4tA/lzTaOYjrqJYJQNTwSRjHQ8M34PdIKWhV/Nuw/+oAM3Z0851VMw4i3G75SG92CE79
         s37ATMZ76M/Mp6O8VmDLgE4BdSSP2Ya09b4eJbZB/VdP0BEDz8OjRatycIkRhNKS3MFU
         N3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399829; x=1794004629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
        b=cGfZvLGnw7PBJfEKaON+jmGBaUl7Ax3hjHeEAHjrrA9znGXCAwyMboEBAF+qOx+ADI
         c2IQ1IWtYHNCCbJxjGzFn++oPbq87XT3JriznAPnj/FT+FJxYiz+X5HsJjCqeaQ5WKpD
         8H7BnvaSe90IgKlPjFZW6N6hWUQgXNXTTKtnMf0/tsf/my6q50KyHOklYYY/YB9V3uDN
         cHYVE0ffNJK/G1lXjxYV8t318Mbqrd2Mjuc9AzfIS4aBQcFSthP406i4L5ra9hDxFROi
         GZZRlpCDXrb9sYXIFEbevCErJJtDDMalYNQY3RGvuvN4klC96VxFCdQDKb0RGMl2XcDg
         baLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6POQ08yJEeHbcesm0OjLiCD19gfAchsmfVmSoCzbkbFfy7KS2tzq9OxQlwSar2HWctW4BFx1PhtQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU07wRsjCNgFFIcF3vPjmDg1QBeNSt6VzMBm6CPD291WgkN5Ax
	TlLgiP8bUYJCAlUrESGNerCaAzig3MqBh8Kpu3inCZR1j+2vWHIURp6IaUgy77LkU+E=
X-Gm-Gg: AYBFou3YmxIOZ9gPfIMu5YFUXeHTU0Xbhux1xDe9qgOARKRpuy7u1Sww72Qg2jaRpxW
	xPXGH5gCzW50afKyqPoLyBE/ZYR8+b1WNTJb14J82KtLuzB06vThhTR47TAVyMtXb/+gHDTZ59c
	JaqB1XW7bG0daJaD0PCbU+YeBPxhvjAZZbdeloUS0XyHCJGMY2KHLxbHXEBs8cNYFFlFP1OLNVH
	W9hsj8fLKF91MTijVpvCASZx4eBA4Eq5emyld7rOMaq44MCDggzsSv0O88joK2CD7NC2XyqdAkq
	g8qS2QD1uR/X5xk0jlEyilL/05ODIyk4Xo2kwZmBeRoJ9N7bV6NEOqhFaJcf1ktmyTjOFVhKZ5e
	zW8t1Rsohf3oI+v/uOv9VHMgRg5RgaBMjp4Wn8OcVbo6k5/pFMBSydOj47FG7VFVnJW7lZDAtMt
	FebY20zHhj3GmyWserte2R1K1SnB3U7qq0tuyUXSn7Xj9x6wGPKLTyrJfmNmTofe9Idjs1eNQGp
	fyXkGbxyEIZRPSPRjMV+Dk1jDrbNawfDQEQ5UTemqJtd/fMhAVMpFuW2+03KTKSWwTYzPnMPy5a
	7Q/COJH+X4NZ5cp5kGjZO443stP+
X-Received: by 2002:a05:6000:4910:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48e6494c24fmr18207678f8f.3.1793399828561;
        Fri, 30 Oct 2026 15:37:08 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:08 -0700 (PDT)
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
Subject: [PATCH v2 05/15] HID: ft260: i2c: silence sysfs store big-numbers
Date: Sat, 31 Oct 2026 00:36:27 +0200
Message-ID: <20261030223637.86907-6-michael.zaidman@gmail.com>
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

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count after a successful parse so the full write is consumed.

Do not report success when the feature report fails. Store 16-bit
attributes in little endian (reported by Sashiko).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: do not mask a failed feature report; cpu_to_le16 on word store
(reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f134fab08285..d2c5c9ed7927 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1471,63 +1471,67 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 {
 }
 
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
 		type *field = &rep.name;				       \
 		int len = sizeof(rep);					       \
 									       \
 		return func(hdev, id, (u8 *)&rep, len, field, buf);	       \
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
-- 
2.43.0

