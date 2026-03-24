Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082013EF670
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373736; cv=none; b=Kke5mkDwwUiLKn6PM9qSAmQ7mJR662Vn8AwUTlg+KpFLNnhIQPTdKxd+r4BtnDyEBuWVYi+0Rx/YM/igzO6QMh512svJJngLUwna5at6UESt8qjgq+XIUGlXBaPTMsIhXUMs1nLDVlksH6Lk5F4aOzQa9XKxVODh5lYQSW1wTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373736; c=relaxed/simple;
	bh=ovVs3AWOZjlyKru7AE1DWVSZIN+/WI9oHTLy46VoejQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omBzrnP+1yIYyW2EuAZGJze/+cO1n/8Q6OW7bKg6DgGhNFIJqplE8Dj7+bQ0vS+L8P5Q6qgtaul7hA4mix9MX2uxWjm16pMVcgP71/7q61cCRTPxFJczWyvPs/Gutu1Am9eyUgoLpKxqYNiyyUaePWCuWSM9jtoQ3GV44Cs0UaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxkX9Zi9; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxkX9Zi9"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56ce07a54e8so985272e0c.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774373733; x=1774978533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=oxkX9Zi9HxEiKfCtqdjJhPdCph1anegLeatQSlYHx4pTYvB1m+aTJqxB0kCZsOtEVY
         cFIGDEluvoklptcI1FMS2TaeMDPevGpxYDAToj7UjA0czz4jcLkyJ23ZfJNgJQNvo0wc
         D/Glaeg4XDyXu75Vl/y3tzVqQC6QiVuShvS6bTaKD3P/Yq6r1p8XUAFQmyLe+Ndf3yYX
         jeT5R2F7Zu0ZrrTQC6u1/jb6vuUUmnZqyWU52sFiJNtHC32DHdE7UhQHeg27RN+E7M3h
         5dBMwaJtrhiUALSstvMF6ifbC/wb/nINIK6PHHjts2Martw7e1bRhjq5jQOsKqq6E7N1
         ifgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373733; x=1774978533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=M2OkXXQU7LSipPAzBUTHNryaWQvNlQtck/wPr0lxz/ppJBCna2QFNRP/u/yp8nWtuv
         pJjg6LADjICp++WL1xoYgZkAcEW0BFXI6aymJCiu4w9gUiswZ7cdaEcEIP+esIiRnMID
         v3TUcEk//E6bAD3m2qi3h2OH8inMBwon1CIiC1bZPLfdXRzzwKsRmkZPngMJam67g4Rf
         dQMzzc/FYrRFBkXMsHWjcLmlKR16LA/ad+dzlzUE0U/dgdzn2rQ7iN8iSoe9QaMnc4zj
         bkqOJFBMHjryH26NAUMKCL19p6x9D1XyQi8hLSxWRg93seCkKeTS/qFOPPHSMBi35QE6
         t5NA==
X-Gm-Message-State: AOJu0Yz0E3juWHyQgB0/PGdcsb+4OqtbOg/kvg68Ns4q4/9Yrpxd/+Ax
	fzcQLeZ+xBUYcwdCYjqZlTKek2iYvwF1IiZ7GTRz1r7M9JQM814ludRX
X-Gm-Gg: ATEYQzxTTHMuoSHBEUmL4kmi4pPCcdPqxN+CC5kA5j7gPFEi+oBJfNkRI9dSZEAQJ+U
	d0WRcfR8BrRNLvNSqXCl9Z7G8+UGh+lMdlY99LTFds/x7SNKUxgF23FLqofC48nG6Q9443lXsSn
	PwyCV0KcmpRhepUcRh7MPfw4764xQ4E5aMxDclp5cezt0USjoW35YDES7GZEgd6xvOWskShS1Rs
	fnRPw+GQJy/fa/rRoQHZ84lveUn4SAJb6/VjxLerOFHSCC50CqZvnpaY6oviubPRTxBZNvWyh2C
	aU+YTXSyuMhjk14SfHfy5dgrCotU+vaVXsLPH/rlQI7TI0ehfbQa0rWMIlFMbIw1pZiO2EhIZ1W
	oXV+B+ueKGDCJMt65KTB74NnVmyWXq1r0kdepxDGK1LemxLkqnr+SotJlK3q4l6eYlzYhwdPPC/
	yWBWDypCDmU5Y390/FXcq0wbRn
X-Received: by 2002:a05:6122:e1ae:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-56d2207aecamr479688e0c.12.1774373733002;
        Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cdd9f7c6fsm16844594e0c.0.2026.03.24.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:35:32 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: ft260: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 11:35:27 -0600
Message-ID: <20260324173527.11321-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads in the
kernel.

In the I2C response path, xfer->length (data[1]) is used as the
length for a memcpy into dev->read_buf. While xfer->length is
checked against dev->read_len, there is no check that size is large
enough to actually contain xfer->length bytes of data starting at
offset 2. A malicious USB device could therefore cause an OOB read
from the kernel heap, with the result accessible from userspace via
the I2C read interface.

FT260 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..7ca323992 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	/* FT260 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0

