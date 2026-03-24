Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C339EF28
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371974; cv=none; b=hQ0J/eFtGh60KVGopKX/wGBRYdudVD06QRcUr9u1AOobM61ND+ZnMwBwxx/FXzToOOm86VIcJ/+g5rhss7E3XP5HK6zRKUxSOuf88KcqGAU7wo7vg2sKpTClxkadF8a0EipZeqkAA+TUqnxEDOK4vyDFez2EBNrYLaSbnAi4zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371974; c=relaxed/simple;
	bh=HMPY83hDOtEh2uH8sesLzoJ/Zhf64/JSuRtvJ9f2po4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShxIZi5pl+Ofh9KZEFhPbTboKhC84dxxBBzAsEQ+8QS950hXLf7yL/iu3z+8f/4xm7dO9XOchjSCq9G4RofN06eSJ/oVmOuXvctG4JoFa6HrojbDlcw3Vy6SdagSDAyp7w5AseIlBC0majOnuMyDWXy0la640jTEiVxCbRUxm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPHrwHAH; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPHrwHAH"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so2427075e0c.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774371972; x=1774976772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=XPHrwHAHMGgq2OLAx+Mw7ht2m9acEdS03JXFuzHT+DPBZYrjKMddKfMUIA3QlnAyDN
         TlepGO5C+nngknTjOQTrBJv7ZWyot2RKSMb/GTtuIQFrPDmMNXpthVESHrZLBXG56S9f
         5lRE0Qn1tWj5jOkA12BDiJdAdvVAVLT3QHCQt+sVLucWhrJgnotYTT+BwwhQTMPa6Ljo
         rmmDzQI/rpV6RDFW+bPRewf4WY/Z0jiO2KbQA/e0aVzsHVdSITdYEPuwYYGkWevPiOTG
         mVYni14z8wW/JyzHk7RPtdX/z49RXfRb8ijlsh9Mlqaq6IvHTK/0GhTM5QnDdBB0EjWO
         518A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371972; x=1774976772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=NP1PfrGt510Dk9FEs0eue5YlBgTvPnjwFoPA4W/CPhTxOluP1xloMvw0bplBvkY3le
         7yE2qnOR9qLJsawwDteO80Sc28PFj1OwlFfrjIY4uXl4iGXD+rpM6ykow6AL77ldbrg1
         927LPPZT9DeRoRvwjnY5Bffje8eFmLlFmV1WuX0NOf1HBYTwrIyHrdpkwGgQF5PIu7qk
         4h+DMdGV3ktUx5whScVSQL1xuX8Y/2023UvqLF7BhsHCLpBVCQzDk1I2v5xjE5PKgYGV
         kdThE/LDuRasSB4r1ZCLlD0rOzbOU0SO3ihm2icmyRSh1zUtcV1q+yidQQu1vpQBdlW+
         VZCg==
X-Gm-Message-State: AOJu0Yyyclp5lUSjcgeXsJMRGZlutLktV3ygE+TEvAtVXhd8pB4A8OTw
	7hVyWsN4G1HXBVW3jRn4eRoRVJzcQcg0VykF6YfNLoXge2YtpwpRopdO
X-Gm-Gg: ATEYQzxskEuwIZZ85M6cfhhg6E9+MB+YOoD2zjBExp/30YlRgxwxx4gIUtBMakenpoa
	XWi9G31ywTARDDPHOMIQJCHnajEeoCp8zGQZ4X+eu7J+4CxForCp2DMlTKXPMm3i4AaioT+anne
	/Qb/6JmQ0phjrGAe2kGWY/J3kjZxe5ipqHtEyMQWskdaUrxSI69w2hesOASNG1vo/Ju9NZr3ItN
	mg6Ok+GkMpJ7NMhIiF6z3f0c3QZUGdrUxN9GebqjoNeOvgE+0efZ+aVETGu0nagucEtmVw8HWdN
	35DDsLoHBvh7W7fl7bTX997z7+VmrvfkGYBAGg3WJgjMRjVs8YoV0Xz/qx07ROD3dN+RI//dMZg
	wYPfEFE/XRZdlmrTJBB8YE+mdVemRLZZ6kNSfWPDVf+iwGz8qYZcdBRZvDxNrxD46TyWbNntFu3
	fovqT1BgIy6SJXqSblOAXLTyig7abnEpSgJQ==
X-Received: by 2002:a05:6122:6311:b0:56c:d81a:5863 with SMTP id 71dfb90a1353d-56d21f7af6emr321071e0c.8.1774371971751;
        Tue, 24 Mar 2026 10:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6de:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136b4ac1fsm12420024241.3.2026.03.24.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:06:11 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: mcp2221: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 11:06:06 -0600
Message-ID: <20260324170606.5407-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324062403.341855-1-sebasjosue84@gmail.com>
References: <20260324062403.341855-1-sebasjosue84@gmail.com>
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
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..770c305d8 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -850,6 +850,11 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 {
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
 
 	switch (data[0]) {
 
-- 
2.43.0

