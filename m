Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF133E351
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814091; cv=none; b=f6QkRNCK55QrkGY3geE3Q6jElMqeZ3ns4CtSFdY0+UWHVE2nz4QJK0v0Ze95By/yPMb4UGrbXcTLQdaMqQl8OzZO5J3vEUq8hpAe466msncU5sFvvNd3gbe539qleQsnZL2kqzKdJmxhQpyZxWPRJcLA//9eJU7HuCdGhxNIgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814091; c=relaxed/simple;
	bh=eJX1yP3ycMOp+GPfJFr/Kg0BrgivZYOEuF4zUzf1F8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4yVQOfv9qNvfUYF6SgufOchY2QttOEpOM8FUeTTZBxItLelw4kEw7WlfKqMWKMPOo3x4q7X4txge+ks/yffF4gZTetAX7pSAgsOPgWliKcubF9R8GOeV7FEbMpRulKKvhz8Mqb8ewtQYoyC/F8QL9AMCpsthG4cyu6jBvqT/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKismof+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKismof+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so17944555e9.3
        for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775814089; x=1776418889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMDf5kG47sSh3LquTWW3lJq958x7ZFKaEtVYrO12TpQ=;
        b=aKismof+eqTr2porbxa1qlFO/qfy6vxpyckEJTsZBHd2xo3GlfaoLm0Owjo5hhmhAA
         0Ki7SDvPX3VL9FyXLRkEbxRrD73HkuZY31Tib1BuHrlBm1gcooHeDFtIj19+R/JrNuh+
         VfUSMhDD1xZxSA+LUwn5PHjIxi9Om/3iUlx11dtO3YgJ0DhkpPLDAWkkQDyh2M+eWLMw
         1FPc66ZYpEfhZ76kILn3360no+rfTgHukCnmH2wCj3zDKMSFMxDM1/4ewiZR7rMct2Cw
         ZXBC/qjax54a5+gdlES/51UOAmwQcNLyrSGb3ea6ac2e5x6v1wL/khGyx8trEDYYGdLF
         BlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775814089; x=1776418889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMDf5kG47sSh3LquTWW3lJq958x7ZFKaEtVYrO12TpQ=;
        b=aBanb6wr/0Cy39c4h5JFjAX3J0aKdfA/aCG9WuuxOdB17fhGuRdjpL2x48JZrfu6cP
         UuFS0Yd9NNBQh8yuKv6PAbzNKtWlI6FxZniLTk0wgwWfm+r2nUB14e2cpveGdXrwl1t/
         k6X/29FGo9EXbR+1TGXhRkPRY5WfKn64AM2L9sJnUK2/pwK2iDZ3noKgzFi8U1FIjEq9
         RPabBg2nazK0Q96uiOyTtiKa5MzgMOpdECPf03dYLhwAMMZqZI878U2o225V6hV80d/O
         8y6NTGw9BVRZ2iFJz8eLe9DY+jTGVRxpwuvdxNKic4R9UIdsimaXiRR7n+jM7mgVf29t
         fwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsbbEPKMiBPI2kDIy+CkN9gFKhUZsUPuQASqh8wiH3T+kT4IgAVUqVrwYGGdKcjaVlGUl+AcDHAQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3S9edIZKGPBkvDupGus/fdmTsI7vr7zVGVqDAc3rP+9Uchw1
	PZeG1DFN7Soayac3GkwZxvCh/b7nbLfVi3NoCs+oMapqepAP7HH1Ic1Yx+BajS7R
X-Gm-Gg: AeBDietHG+jZCy5FobboJFkoATkDLnLvfkuwWeXyR4A1N14YpohH/g7ohlj31Z7ocFt
	C5WMvsIjOFSQ6RVAiSEApXW4BeeAF9wvUJwWG0Qk4jpJBLywNwoBpzb5fR4gytyFihUfx3y1kvC
	/fPrjKR2/ynLLu6HX26EztKbB1B6hdlBXGrauPW1wAy/rsR3PNrQFFCS+72lIbtAV+T0bW/Wyfj
	qpqej2C4TyAcrzQQ3YXJ9+v7PesbWjdScIrqeTTIkxulfABRux2fS+p3kC6gGcOilmpPeQIKhmV
	XtJ/BlgC77yPYOJWQ0t5RKza44FRjWRGPyAMB/XXoTe5bRURaRD3rR9CavX3m5MDC9cTk81Wsmt
	m9ndrMU2XVkjL2HmTAETlysEarloIbZU9q48xIJcd5lrnOC1RamZ3v6aQ6s43iqUUmzfMgyiI8V
	3iz6cuERFVsn5CN067MeLB/NPE/5K4k9GFnxILFSmRmRbYt/0mccsFu7eCmsqcq55+Zr6m
X-Received: by 2002:a05:600c:8b6b:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488d67ce792mr29808725e9.8.1775814088482;
        Fri, 10 Apr 2026 02:41:28 -0700 (PDT)
Received: from x2-evb57.xsight.ent (genie03-172-158.inter.net.il. [213.8.172.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5df2062sm18102255e9.12.2026.04.10.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:41:28 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH] HID: ft260: validate i2c input report length
Date: Fri, 10 Apr 2026 12:41:15 +0300
Message-Id: <20260410094115.229188-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
References: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate xfer->length against the actual HID report size in
ft260_raw_event() before using it as the memcpy length. A malicious
or malfunctioning device could send a report with xfer->length
exceeding the data actually present in the HID report, causing an
out-of-bounds read.

Each I2C data report ID (0xD0 through 0xDE) defines a different
report size in the HID descriptor, so the available payload varies
per report. Validate against the actual received report size rather
than a fixed maximum to avoid breaking valid short transfers.

Reported-by: Sebastián Josué Alba Vives <sebasjosue84@gmail.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
Tested on FT260 with I2C-attached EEPROM (24c02) behind PCA9548
mux switches. Verified short reads (1-4 bytes, report ID 0xD0)
and multi-report reads with debug tracing enabled, confirming
xfer->length is correctly validated against the HID report size
for each report ID.
---
 drivers/hid/hid-ft260.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..b31c43353249 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1070,8 +1070,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
+		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
+			  xfer->report, xfer->length, size);
+
+		if (xfer->length > size -
+		    offsetof(struct ft260_i2c_input_report, data)) {
+			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
 
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
-- 
2.25.1

