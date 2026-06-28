Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0B23F417
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639468; cv=none; b=j/XMhFtBvff6p0qecbDGoVh64tk/WFFS33J0nDnGjd5N/h32K9FcCNPloPLkYADY5eOURN7Uje5WgRTUtZzz8P9KdHfjPybRWf/w3GpfaTNm68Xzb5jJa8k9N3uhIR+WJdhZ2twRoaPk3fJpLKJ7QO/3BL0EyBgb1JXd6Ip7spM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639468; c=relaxed/simple;
	bh=KUxc5s+Ozy/mh8LcygImhFbcgR+t8ibAmyTyILx/d9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt8DVm35HKZUg9wzgJ/zc0OVYnhym9HwZYZQ/u58joEh9N9/jiOqeApYb8d4E5QZPaYiLmWDY6OXeAAe4c1aQYqllJoyYevnvAHGnoxwtk3juE6hdnSbXpTpMYTiDQYmn7IQyd9weR0dBf8M4ZqMCCWYg8lphaCrmyZs5mkDPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX4F6utV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX4F6utV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4938d60c035so7857345e9.0
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639466; x=1783244266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FQzT0Pfxjs6kdPKaUfr6F0wexDd7Xo9qWKJhKghTGM=;
        b=lX4F6utViTkAkMfBZWiugZaSidMyROeH2ORe4flDMRrXPEq03BFE8YqO48noC7ORgJ
         KS/Djl5Jtzy17C+BWenVMkQwLcEAdm6418RhwTzY9JsmVeMuBOnsDohcHeIA23w3tSBb
         VvkY2Xr5wY7GYNc32dBJR2JH8rTWWPAFcyxV5SkxAQJ5IS1qvcuUAkAkvU8iIklv9lFG
         oNIlNlBuFfiuf3Hk0XLfITZwaEc61CZWlV4IlF643fFK3tV+NiMwOiH8f7VZh75NtFFc
         KDvfnY925GCE7N7wR1+lSRsv68SwpjNL+ltfc273yfoYlHR33HLbDj9MDiNLyt/Dag0s
         gYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639466; x=1783244266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FQzT0Pfxjs6kdPKaUfr6F0wexDd7Xo9qWKJhKghTGM=;
        b=nCJx5AbF7y9AfluoOgQo0z3B6JbU744Z4hLm/cYX4WKSkcGIRLUbbOcb5VUejVJcTu
         2kf18ojTcfgY/3EV2bt9DpukC7lZVcVQxVlhCiKQzbyllMxgYr/iAwwRGeJdreRuj7zo
         b+MD6ev2oYsOaIyFWDxVNKW0U3v3SmUlVhoFEYses0GEJl9yhf5ykWsMFcVH92haqYU8
         CXeOaQIYHChlXg8gBJvm69Ra0LRqEidWtex6NmaD3SSnkjfLG1HMCl9zzHKuCAezmuy1
         IYDm/+8d4iSUBFChA01p12VTw7y4V8VdkJU3AD/DWyWUtOVu5PyaSmOGC7kkI9xx2w+n
         Iffw==
X-Gm-Message-State: AOJu0Yz973dI0rINej6xnFUrSfrhUigyIm4DvTBy0AbXLuG5bt6/LJZN
	ojZi20VeDpzu7Rb2yPH615ZrQptZFiPK9q/Ht1ilJb74D5Zg542DtTnz
X-Gm-Gg: AfdE7ckbivep0w3XIPgIMHZEAdc0IdF29rQ0W/gaLXqy0CBF1SjH1scBHxq+vwUc1uy
	PYi43v4hlySjCxquMcc14qMz/Hwv6mq/YZTo8RLIAygMmWt6iJuto8eha2fXq887RgdRxQ2e1/Q
	i8O1cjWjeoFXqA8B/VXUuR4sOw6cVyInQhImXjIXkhc3bSMmqn2x6LKz08teBy/eEoHk2KqdKwv
	4d2sjYJHm7KTrMvp+RYtdXy79lE7H1DkS3Smsa5wRX5wS+VUCzO8vdvHPl2qoKR9btX1PfinLr6
	ODBCDttAqLYf8iJWgF4p9anMRI/wQTFC1Q4O0TbERMMIuxjQ1kyBMsfWO6TJcFKuDr3Axd75bks
	F+dE+sVqo/j48LsvzHWF1LmKc916fRvxMPtGlMed3UVKYqJRUQxy3OiOMuxYJmffI6lq5CdPHw1
	PWLWAYCsynCqaANGN5fsnbznp9cw==
X-Received: by 2002:a05:600c:1c17:b0:492:7019:caca with SMTP id 5b1f17b1804b1-4927019cb17mr131689195e9.26.1782639465516;
        Sun, 28 Jun 2026 02:37:45 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm246657585e9.14.2026.06.28.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:37:45 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: mcp2221: reject short input reports
Date: Sun, 28 Jun 2026 11:36:58 +0200
Message-ID: <20260628093658.43445-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCP2221 raw-event callback reads fixed offsets from the 64-byte input
report, including data[50] and a variable payload beginning at data[4].
Raw-event callbacks run before HID core extends short reports to their
declared size, so a malformed USB device can make these accesses run past
the received buffer.

Reject reports whose size does not match the protocol and complete the
pending command with -EMSGSIZE so its caller does not wait for a timeout.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Reported-by: syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..311b51c17b4e 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -861,6 +861,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	if (size != sizeof(mcp->txbuf)) {
+		mcp->status = -EMSGSIZE;
+		complete(&mcp->wait_in_report);
+		return 1;
+	}
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.54.0

