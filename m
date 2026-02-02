Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE832366060
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038045; cv=none; b=ktYSNJzJ0vVa+3n7+yCeKD0eWKLazlb6a1Y0bbcwv+Bf0aa07W29uhV50EShxHLIFYYNKTqJfVGg+mIuUKqu6r/pIsjUSZE57Tzi9IrpeOoghRkJaNumajD4jJmu2ESAi33iOnRdqOMdJ3HI/SBhxmmvJ60GaQiK4YUF6tJVsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038045; c=relaxed/simple;
	bh=Rcdo9ENaYOJ+3ZJiS9OmciNZltG1NGBlbjBxN6Vj+Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0HtTWRZwt72L6x7OTgQIq4fz6G8iEps2DEq332KyVvcy80R+CYrH8rRKI9wTrfBPdHava3+U8uZXozbofmCLRReWrxSpneZ+jYEFocpAgnIZTmY3FQgkmGr4BKWjhlCmjTV2RtaqLtnpXnBkhEFHoWgWrGkNuhNANGtwP3E0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYT59gq3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYT59gq3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43596062728so3370593f8f.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770038042; x=1770642842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45Rqn1I5EPkojQBXJKcNvTktWh23bn1dhVj7rL19kvw=;
        b=FYT59gq3JY+DA7+eQWMEVurHxN0LQN0VTDdQzqfb+DQqMi9jfSEjyzBDnu2N++X5o9
         aPXiMu9Sj5RMlRo/vh4/3wVmS9zrDGIxjMhDsWgKMg9+6YGZO/P3CryOvmK/wPWPE7GA
         /1dkuNV7xLipywF8M2vjL2Cl2XdmgQex9HfKqIsV3llEPjhrWXgrpqclGYZQffTSWTHW
         oKfz3kyU+E9KX48WGIpRQZF0Zxjrnvi+HTS2EY+/TvvqrR9+eUUTUo/RfV8Grvc+mJKo
         oZZ3fOTLqIgWJD5t5Xok2C/fVomRu360Zvcwu45uLbxk/1Rhz8emIvPpIGdLtuurF/+N
         m62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038042; x=1770642842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45Rqn1I5EPkojQBXJKcNvTktWh23bn1dhVj7rL19kvw=;
        b=On62yb+cmXbIR3rNFbVJ/1KZIqZwNxVbmk0JBgWjxEhbovHFMciuL4tXz5J/hWo7Rj
         VbTmeqiOeneBPb7cY0FfSE6Q7CC4CxSIyB4PdRLUkJZBTsTVS9qh125aNMnXWK/heE2J
         8VTACDfTRX7yuVCCRIkPDnzcMgXfWip0Rk00tsFutX8feg3NYPmVhVIu5fkyhq1Cdosf
         SWew51uENOGsgPbk5nnbLjXesscVPKOiskbgHju/ocfHiJfkR+KwNOkPQL2Yk0HWw6zt
         sfTpd5aR1iMjJRsIoKSnn3Ekxh+OHe/F8zxY0VRib6D4Wl5VexH8rI69GYI09ViUud7G
         IhXw==
X-Gm-Message-State: AOJu0Yx9wvC6XxFr6gXDvkCTxl+XbpkOXu0xSSCvE6i8IpY7Wdv7aDyO
	HkDz6d7W1rgYX5lBSt0ANUw73q5Cu1QR61KRiZMD0PW2PIWYT+/zrCr+
X-Gm-Gg: AZuq6aKBjdwrTTUzkZA+9uIFxkqwUauRS5UbJHVsDvFJ8sfClS3BA6Jwyc1MTLkdCdT
	kXG7C5kEjjcvWhO2yfVZap2f3vm2mrszVZkVdNBZk1nGkmWcdkmxsOcRfuW+FGXRk2JL737PiTz
	Vt5BwEvZjKt4W81nWOg+LmlrCsJJZbsdT6OE/kTrqlKONId7sffa7SBfV653qshP37eIqvckjv2
	hE+FG2vJO5FsiB8Pwm7GffqHezPrdFxN/puIoocl+3pirwLmiLyehpUOZf1v81uTTWwvok22v0B
	VkL3OpvqUfLgguoEmuOOfH6yDw9JmqgZ8hhG/m7qx3ubHY6FnyCNQaiU4LdVqtJFsPb8aJq50Dp
	8kLz/pcJP3oB04DbLw5FXzYUfWFirx7xILExv8FYbdH+m4a/EnlNbClqN2pStn/ymAaHHZWCs87
	XRVP59Bq/ydwAP
X-Received: by 2002:a05:6000:288b:b0:432:b953:b02b with SMTP id ffacd0b85a97d-435ea0f2544mr25343486f8f.16.1770038041719;
        Mon, 02 Feb 2026 05:14:01 -0800 (PST)
Received: from fedora ([179.43.189.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee04csm44242415f8f.12.2026.02.02.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:14:01 -0800 (PST)
From: =?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
Subject: [PATCH 1/2] i2c: amd8111: Remove spaces in MODULE_* macros
Date: Mon,  2 Feb 2026 14:13:03 +0100
Message-ID: <20260202131304.8524-1-filippo.muschera@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove space between function name and open parenthesis in
MODULE_DEVICE_TABLE and MODULE_AUTHOR to comply with kernel
coding style.

Signed-off-by: Filippo Muscherà <filippo.muschera@gmail.com>
---
 drivers/i2c/busses/i2c-amd8111.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 42a9b1221065..51e3660e51c6 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR ("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AMD8111 SMBus 2.0 driver");
 
 struct amd_smbus {
@@ -417,7 +417,7 @@ static const struct pci_device_id amd8111_ids[] = {
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, amd8111_ids);
+MODULE_DEVICE_TABLE(pci, amd8111_ids);
 
 static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-- 
2.52.0

