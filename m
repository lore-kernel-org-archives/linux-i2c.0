Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945936;
	b=VtimR7jzQ8e+uxKzMr2ROOwIaE4pACa7ALSM5iKUgNOP/4sQjv5hvY6B30CSNyfveEcX
	 mRrgPsh/EdODo1nwwoGHVjCDTxW6GxwneWQJWsSadqxqXW8nVm8EQn72hC1LkjJ27uaxL
	 9Q0iwe6RT097/TCUvLEtxjMPXou/BDa6MnHxRnwd0mwsciytN+lapxFvpl9w0LoqXHE7J
	 p7RsHkMTl80FfFUYfqao1Io6z0ELZiZeSl+zYPLBhPtE7nDXVJLmDSoifK6uyMy0C4e4w
	 LXveYc/S2jtAsKGuZx1aotm7ZPbYiY73yN95lrooUOiH8Era7UTr3CPBR2d8peiBdKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
	b=r+eqFiAQuD1+IJZNcXbEZyEGUVIq8+/2/T+FWWb5dw1t2Tf8/E80K+B5KhCVZVu6lzAR
	 GijVK/aElXx3WxVnpneDyNhlQBG/E20u+NoVCKcAPaFoMbjlWAxROPn0vLmEgxp9Vvfkz
	 8uot+T3hozh6nekIa8mraIY94/1k3vxOUCLtAxghYoXfevHXMRy8zYMTTjiGzdp9bBH4Z
	 e5FigFbW4qBawILdQGoLXzlT90/ek8Q3muczjJ0vpfR8rbZi7qCegJlNbFjYnyAQGAnFQ
	 66OhA2v8zXrW1NR3r/Bc0D60TSYG6W7L1pSvcI4fXL6sW3F4dTFmOIlrz+QvYbp/klQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52281606B476
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52281606B476
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so3385035e9.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945935; x=1795550735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=g82d6f8qYdcw1P3PeliLS1T5H9U0IcgDSvbHbmDNXHG0YNHiKA0wzAaPTw9Yh9l0xf
         7Uxfu4V7F5KzrLi/15wIWpNl08nASI9JBMPfRbI6o0edRbvvmS8HvC5AZ/hd05NwBVXH
         oKzj7FSQcG4BTI8GcUvUiqBSRNipAC2I0536YmAMRfZn41nIb6zEP6IHABUl8GqAUma1
         Oo6RA2mFZ025y2RZdQnNSpK6v8ZZVlwGjLDHCFuvCRcRpDT2A8L/6gh+E0/PtHoSSHww
         ND/W24jbWzgH48f0xZsH0RZ2MuiAhjFykGzY0s328KEEiKbIf3AlRRU8vYLDvLGKIzLa
         ELDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945935; x=1795550735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=wzkW/8lb7tyvQxFNdg88fDEDHM/VXmuJ09kiA9zwcqZiVxeRTo5x59r/YrUcjJLCb8
         9kfHS2p3jVH0APUaXOReQaRo1hVTRXDWy6mObL68J7mh1YKZgoNY5xBwn4K9xZjcsCzQ
         KXuZrRpUdDOVfXtLJ7ogqCiu73mIS/YOCnclPYQ1WbrOo/L79L5lBacPjEtU62VspJ2E
         3Za98WkpQXOv0BWXbqh8M2uVmdEaQbuMuJsGFpGcXsswRjHwaZiTIbqjJK/SBXvxwqCB
         1MLbdYnidJbLNaqWLyFQu+/w07VUpd6cJQLEoS606Rlc4LEbpuu91R/CB/u0ZYqaHWAb
         ccsQ==
X-Forwarded-Encrypted: i=1; AL+hErFzOZjNmQOdHnjVHmfO9a2rg5fPuw+7FItUN4bnQP8po715lpkjhXpKA7DffLHGqpBSkuupKzQKoIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fPRyFtIKRWGSKx+/C9Hi/MMwNmVSSPISdSrc8l78jqiw4Gl5M
	NaE5ZvouRNeFU7hT8sIgz4hzNC3b9sAN0Jb3LeN8kyPeUKlfeP7T5cQ3
X-Gm-Gg: AZFdTZfG/uUt6rfhMZNPSIfF2Xnb5oPguyykxzIy+mj337w9ApUHvDDTbbytaZFym+r
	utSTDG7YimYuaGU1qvMsqFgom5ggHqRBdg+HWT38sf39V4hjpv6GY6dfpUEywf0aPmR8mdZzLab
	3r2NPiSgB9Gj07oOPT0ztWikKPswEXsu972ab9ecU6sJcgcJzwTuK/bSxT7YX3h1oCbj7J975p1
	tDb0c27G4WsMRo4CTlQD0j96CACtOd/n4GE27WD7J17umZPSLq5U7Va06XjQwtrEkuImGuOvDHr
	tZmJ8Yv4KNnhhGHDzkf4KuOUFEXsJIHAKGsH5w/aXirmIBHpG75k7VLjCdNyscrCwlMwWmN4MYp
	9BhJ4Cy/DQY7rAsjHayfVq3o8kXVx+5Z9YhnnVsXOZjm1KNJ4y4Yjc+mifC+3/cI0PJWE+Nj2CH
	GodKu1uuOT/8j41GlZY1nBV+dG9oni2vKOZY5keQGn/aIcU7UyFJg1+93/EASJ9WfKrciwYk5dt
	nVo6PFPWRoup9Enp9NUJkYL7hZU9pZbMCeH8iGtQg3w1bynoRSHTB80+x8SRClQ/3CRKGCJk1w3
	ky/FyVsK7ElvTFnB/BY7i9fDRunqv8VuI9M=
X-Received: by 2002:a05:6000:24c9:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-4a633a652e2mr1441900f8f.1.1794945934473;
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
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
Subject: [PATCH v4 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Tue, 17 Nov 2026 22:04:20 +0200
Message-ID: <20261117200423.19561-15-michael.zaidman@gmail.com>
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

A sysfs store must return the number of bytes it consumed. kernfs
hands that value straight to write(2). i2c_reset_store() returns
whatever ft260_i2c_reset() returns, which is the length of the
feature report it sent, 2, not 0. The "return count" below it never
runs, so every write to i2c_reset returns 2 whatever its size.

A write of two bytes is right by coincidence, because the report is
two bytes long. A caller that leaves out the newline, as C and Python
code usually does, writes one byte and gets 2 back, which is more
than it asked for:

  echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
  printf 1  > i2c_reset   1 byte, dash reports an I/O error
  echo 1    > i2c_reset   2 bytes, correct by coincidence

Return 0 from ft260_i2c_reset() on success. The value is discarded by
its other callers, ft260_hid_output_report_check_status(),
ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
discard it as well.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d5250bf5da61..e89f8a2fc06e 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -615,7 +615,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

