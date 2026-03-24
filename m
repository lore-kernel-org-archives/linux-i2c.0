Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A523B9D81
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333471; cv=none; b=Y+Gw00ehlXj9l/HyGNf42zXuNwQwwRZXE3edbAiqoSOJlnUWOhpZpd+2KM8VY8h1zqAWS7SxNA2IKk/iLQAXaJnpOaV6DLI4LdX7GuNVFoI346ZDGKOsIAER/n5+RniXxkZ+oQG6OBkekOCrVlte/H6D/nsy+6d5IZGpE1AS0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333471; c=relaxed/simple;
	bh=9qdKyp5agbbjYzTy+gAniLiLFuOM6OusSwuJ6o9b6KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXM+Me16a9OQ+5cRcnybYwOOa4nJ6kAJue33IZaIfRAFN7U6XzVrww4AilkBCEE+vh7PpbaGiEpDGlqvrihFmeXCTngE4eHB9yB0ATEAz/FMH2Vk8tNjLZWXKZyTNoF/uHfYOc/V4N+oTPDZ97m6TZwrh9dqbawZWxeWJJoQdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkLvzVpF; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkLvzVpF"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1658020e0c.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774333469; x=1774938269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=PkLvzVpFxhm35WZ+fz3WwT3US16pp2so4VCI/LC0jJQiCaYZbOL1mq3xHf34Ah6hQk
         cO8pDPQgqMUfiRWNXrCtRChmxkamYxv0FkmUykmiQ9uqDaLbhtE6MP46O65QJVUHh+tn
         h2XClT4434n8eXHNKLVf42cBDtKiSeRTx4hVVloUgiGJ6mReCI3yQpswWaXwYLetWn/U
         wk9gXaweZ7t6wSd8SoyuuykIhQNVjF1/C3AgjnIuvZFVYh66Tz/Pv+x62/DoHq8dESJZ
         D+XDquFrbEC+X0eRlpOyQMeKczbnjOLbwFgajeiVhHgGWcNfpKcvwb2K42WVo3r8I2Nk
         C1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774333469; x=1774938269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=OSTuARj1iP4R1on2q2iq2b2gngoeA6YRnBsnsof6UNbEddFpVMiG6InMX435hAI6Rd
         IUF0475CgNYTo2+A+Pvk7HgvdE718PqcBCgtiNihe5h/ZceDtze7ITIxKqS0hE2j7kXF
         WyMrp0cqO4vnVmi97bIcou2xWLhmUwQXdV95tzZk60UQPEiUSxZoyuoSs1w0vDoHLUur
         fONIYFiai9pNf/55u1fpZmavgy7lhZy9KHhcoYm6ZOaqxZTSXSbN2gHHs4rMOom3Em4m
         tscwEKMs2+7w6E5S7WR1rlhMFUEzje8bm94GXX5TMUZrRowroZ5hc7rP0T4s+fKozFDp
         fOpg==
X-Gm-Message-State: AOJu0YzO0K+eUzk7V/nP0U4pRL5C0PjbYxipme7+uZ6FgRlzTSrHwiQg
	7P58t+r29zqCFBqmMRLMe1yRsrOheSrX4+uTPlLMhpuXps4yqZYOUBJA
X-Gm-Gg: ATEYQzyhKuEsh6i/zqrWDhqJj/2BAQqWOXan750Faob7/KUGk4iRXIjduyLlovyHIYT
	j0Z8BOE1YBIWDK9k5F9QNnsvJWJ5YgpcAxzt4PG18TZj5HmOBL2o5FLv6QDnlqKWNwWEAB7032L
	9zLGPe+hUIJc4YwFnIqc1NEjT6R8xkclTJzeVuEttpd0Znbg5fy8exGJKK/m3/VC4mziHcmtGR+
	MYE+xuDOtyBfZwQ7I9eD//hah4y92UngAX9qzxaAS4g8gjRMyrYeVxQTC4iHkT4tpKEWi8huyvT
	ebdPV87Lyk+boOhyz2uqt31B1rRD34f0GwPUlubct6SioHsyUQ2I+RjKnSBMLu6JASpw2qUVoBA
	yJDA5zuvHgxGkMRkVjPlmjgSrWbCtKD0g6NEnOOlg3auo6xmPw028LeJk7CQlib3cexylA+vEBT
	l6i70PNWFMMNR98ydKMRZf9yS2nOc=
X-Received: by 2002:a05:6122:1798:b0:56b:960a:a4b7 with SMTP id 71dfb90a1353d-56cde343441mr6514088e0c.5.1774333468983;
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:7680:1048::11:161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcfc94dsm14996801e0c.18.2026.03.23.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: mcp2221: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 00:24:03 -0600
Message-ID: <20260324062403.341855-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_raw_event() accesses the data buffer at offsets up to 55
without validating the size parameter. Since __hid_input_report()
invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

The most critical access is the memcpy from data[50] into
mcp->adc_values (6 bytes) when CONFIG_IIO is reachable. Other
unchecked accesses include data[20] and a memcpy at data[22].
Additionally, a memcpy with device-controlled length (data[3],
up to 60 bytes) from data[4] does not verify that size is large
enough to cover the copy.

MCP2221 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..fcac37491 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -851,6 +851,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64)
+		return 0;
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.43.0

