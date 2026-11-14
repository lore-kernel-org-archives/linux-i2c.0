Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697737;
	b=TPO3p/nyYavPRkeJUteYHJ8ovrNrdFEyDi0oqSsgRqj7ChKC3dKJqEZishXF5UQuVFT6
	 OT53K9pg6mjjL1z3HnlUKB7RghD+0OgXiPaqK8QrtXcToNt87lwqWjqXO6hzt8fPOUOrj
	 V9la1yf4Evm0GVMbMFivEDWkakeN9cpx2C0TXbV1TfCM7Jwj3ISEQzYOVk6qOPVw9P6lk
	 ogxu93VVJT1uRQwVTWmTA8aLbJ+E/Be8a5TG9YLMcyRYt8SHZvL+3oD9UdlCTQ3pUY//N
	 AyZwK+wFZVuESX99WYs5yeDTTuQk04E6M4iLEn+ThgsN4/0su8BNEDzHdCbMAbMgIwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
	b=AHIeJssLnv92wEtg/iSyzYASq7pmcoyFT1uemqDAwNpiGwyuy8jqDbK9YnXOUZ9df522
	 WiDEbHFpqxAPGe3ene5M3YahR+4H50LlsPk+ZjVrTh7WSp0B6t3lOMfJQySK6ROFGLKCu
	 GxCsUHKYqm0wWr5ONzYN2sR1JwReahUEo0K7mbKVjHqv5qhsvkc4g+oQpj1aM/zIrJmLB
	 ZERcM0aq4loHwg3khEN8vk1YxheMYVEIwMhQbL4reYTME1L+t2LrZBt9khUbBmH8DLyYc
	 6uUz+C0JRVpHix+oPUQG+VhAfjE4i8dFtZMaU590oLEoO9K0+J+9cUfRh7SJhuFQ1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201C60A6F7C
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0201C60A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4910b863b84so1830384f8f.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697735; x=1795302535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=mxtJ4nYcD3JlhG7YDutpAQpj7FaeOIgaBQzUDovzeWv4MAbcvmdvn2lQ+aKk7Po3G5
         /BxoS2VZ5fgpggK0Y7jhBNdDAe7Mp3WIhZJBn3jEM7F0CF32A3TZECkAbaqkNN0YQxCa
         y7iEpKP8aZfa4yI6ARG2t+cxi9s1NH9exiq//CyjY7wOzyRf858LQ+O053LkjfNDTJUD
         MRPpI1t/ncVOfmBFHi9jrOnogVHDbEktNrmpigNSQ6vTxNdleitT73gxskCzjzPwcKe5
         8D4EpfcJhzlJ9HdtVyXqWq0cggrGPV+0bR2Vmz0SCDBQKYOJSNMufDQi+HE2JvrZbSK+
         AFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697735; x=1795302535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=pvSHR4dYKnL6vV+gSvj47SOlUA9LGtbtQ6VLORUkSGPK1vJrTQTrNcmWJ5sFIC9Kqe
         sCW180p6XFH+yhqXXVABTdP9mOIBp2noIoNrPTJXxIsURr34DljksCRnDkd70DXvhfS2
         SjEPfD9V43v3A/tRGJbJpYTJZv0GYoGFtKvK809HEh9GiQp5NpvgbDPqpce29TYbyIFo
         bgnsXFLfdDd4zjgboP+/pvKO3yhy0uG4en8QrA72sKs88JPhrn2bF9XyU6Q/KwYJCCYr
         fjFQHKaWC6uBiLHqKttSnXe/Tfc4Y4FgJL8oFzgiBg3wuAncFhe7rb318yfMSo3T2oSU
         IHWw==
X-Forwarded-Encrypted: i=1; AL+hErGCQQOv9n3Yn09TZie8zNxYPR4YeVlxKivFQQ4mjgOEFvY9Nh4q/nwnUmiOva+qCdxQF1XnWZpXO+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7jQO1jYrVPMfsBLQ7DmuoOBXvnkCFjfKRLAKmYYg5hI7Xsw7t
	1hP0pS11FuBNFztebLxCo9DNMt5dKk40SlNu0O2QjUuhM0rhjnmNpkZH
X-Gm-Gg: AYBFou0cfNDcWhc4cwXXs7BCZswma5ylJLkTuQmlcphhZJObT/nf+g7HnheJDZOALTm
	XCLifxDRGdlrVCAE5OPhZExDYN58ZkM8qox5gyVJspdDpRxTo4fz3oodG5psOn0GWrlQRx8ltAa
	ckSTs+QOrHlPi3IVJGJr6A9xj2POEQbZFLXHCGeE1aqsjyaoCx+9SzVde0zdPMbbHQTFx25Wbfi
	mf2tNZFhfHygkoATz3e0KbXgAwFqeTI1SbnVxmWnDucRyk7dQcr4dXUlNZ0W3NXnrCdznL7o8mG
	+rKDF334dfAs8WrDDl589KyPj2ZkRDkUWrBVDOUgAnA9/spJOKJpj+vWBMSJ/Q24rBhRygz4UHv
	g51tC3cORzR1qKmRDRFi3Q/7WI6tjD0nzF75zloWOXWhwWoLfUm3REKpPShUptjCuVlpKiLss7p
	+hCivXz1nhCowiFXrBb8SRzxmDBQkhWcLenDTN4nSFFvJt6vnqjTcLIuWXp9VJXu8yQd8IjM0+m
	hr/8le5sm9lbFFGTKs8ZlZMl4Du/6KeOcAHYHlYe6dhg7pYSzKYkFtw3vKfbVkgPtE6R6bvgqCm
	TTwjY+97pvYWy8sOU6AuBfYANMZotNjxgj/uumkfNvDHTm9kig==
X-Received: by 2002:a5d:6f0e:0:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-49b01734a32mr21424865f8f.6.1794697735316;
        Sat, 14 Nov 2026 15:08:55 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:54 -0800 (PST)
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
Subject: [PATCH v3 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sun, 15 Nov 2026 01:07:58 +0200
Message-ID: <20261114230800.1344401-15-michael.zaidman@gmail.com>
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
index 391128e4bb35..80b300893658 100644
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

