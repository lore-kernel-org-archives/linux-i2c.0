Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C030C632
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925708; cv=none; b=Wm2xb7Q3v118tmMFiAAQdkDTBWP5sZWNUrhnh/OC7BcGGZf+AfmGljw0gHK8tY2PYWYl94AZfAgGg4f+OyFB1SMXI0j7wXd03fetSGIf2mOc1X4t8udZZaNyYFAWAoxO/VUkUL/sizGuNqWmHtdedpzVAXZ9EcwssZHl9b9m3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925708; c=relaxed/simple;
	bh=twTy3Z39Eii5mOIKwozraCeEPveBMj4OXX+2gjaPX1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gikMZQB9gg2lPCSdCu15pYre7M4agYyBvQmZckqljKyFEJi8lIPCpsuA9QEREoRP8f088T2kaNEZ7kL9oINncSKmUHmrOrmIkMmauSOhItAXVgnJAY/q5X1MNOec0SRF14tMFFuv8zfbThgVIb4BRAL1ira7h2E2vAq8hE6rCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=IhR2m8QY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="IhR2m8QY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso3068854a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777925706; x=1778530506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1f02yCe7sdAz1E7htjPX2ipyZwaVXBlkzTP5kvxCiT0=;
        b=IhR2m8QYp2Dfjcr4fm6fo4o5umeem3uBiKqHrGgmUHvnFqJXoOl1IsdERT0lUG1Wpb
         Qmsw0e9Xgj2eF+Bof7b2Wb0kvLWr7XFNcbgo/kIRvp0yNIslmyslXubuXEzQ4rO7wazH
         XvmLZU3vW6Lz1OKzJVG93u3Sg2v8P9lPrcFbj8EZYrEV7C6pjWCiR78Be/jvDTUX/rFU
         j/gV4Ofz0do2uic6hKtRmN/sQh3TckH9CPsoAfl2SRoDlOCGX8I9LvqwCE3oChqQRRlP
         HRCXOjQiN09MIdyEBeGLUyZjY02lijqOkDIJjH20m6merrEX/VLc8iRe23ZU4KlExvr7
         ZDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925706; x=1778530506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1f02yCe7sdAz1E7htjPX2ipyZwaVXBlkzTP5kvxCiT0=;
        b=A4QELv494vLpRpYApHL2NW68juSQOx3VCcWBQfQaZkL9aGNmVhJEspab+TDtPUq3O4
         6ZJ/HWZqNgA3Axwm6U2JQd8mY1FVO1gTpyfm6ljQKQ3bb5yDpJr14YIyQYnNrf2VCtRO
         gj++9Q5pa/U+R51h2NOmQ51txUw9wL5VudSe0R+FZ2Qg5njXOAwhuCLfPTk9TKtcDukA
         EsIjkaRvvlgIQ8ZCLcKLHmZLQnYEWHNnYrIyGZOBFW04r/6iaDvi75J26le8LwMWwT8J
         flqCU0a8NH6iY88Veiy1erDugs5tx31cdXXUBZlzNBsoyVNJTqpbEW12ZLAtsa1nap3u
         g3HQ==
X-Gm-Message-State: AOJu0YzXEwweFpz4BAA4/2yCER76UpdtFmjlWx/w9poxAKV5PL8tywHZ
	EvwGiEd0GMK3RMtq94hrIfLII8FpJrcEGWFSI/0C/wb5Vuq/DQ1H0WoeFPSmYYfjPZA=
X-Gm-Gg: AeBDieuct0JCPVjusH/9WuZmn9LEKqLQRGk9OWFzBzWb3Db4kRVKOMJeRiISj/TbkYH
	7l3FrabRFu9mjqJZ1egPn09I/51JcwBSfISxoBVb6g5GGzUb7qyeNJ2joK+xbMSMb22N6eX29si
	3pzzbYWUNmigOU6R6MXWPRysTIUpw54Sgv1qZdnm2pkyms2Hp1XvGrPKTIEpmVDeriEtufr2z50
	kQup+ReBvZjFNbR8CYfR1T1sfw49aDZ+vSIb9ThEuNNP0GUbPdALyKxF/N/WagdPvMKYg9qCg6+
	B9NpzXW6ja9tKEmTDBIqN7kTqe0yaOULnFt96A3UUolHnwBNq5wRJFLexKFEPNu6u7HPugRJIx0
	MuoQumi+I76Lmv7W1C6UdG9FA/QzJqmjpicJRg3NW3uF974eo38XscJf3awBPWyfOy/Arbis5vO
	TuY64Q8wp8NVpTvQ9J1bOZfr2DkUQ0Rm+x1BXW4JW776WUm84c2Y7+Hak+AZHGOOd/coWzUiKRQ
	6a6ffY+O/4lPEkVIuAH8qGj8X4B72pgSxaB
X-Received: by 2002:a17:90a:d64b:b0:362:ded3:bbcb with SMTP id 98e67ed59e1d1-3650cef79cdmr11065724a91.25.1777925706320;
        Mon, 04 May 2026 13:15:06 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20568593a91.4.2026.05.04.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:15:05 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 04 May 2026 20:15:04 +0000
Subject: [PATCH v3 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dw-i2c-v3-3-57e56135d602@wkennington.com>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
In-Reply-To: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the platform driver to use the new i2c_dw_shutdown() hook,
allowing the controller to gracefully NACK master requests during
system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..7ff7c1631e64 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -289,9 +289,22 @@ static const struct platform_device_id dw_i2c_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
+static void dw_i2c_plat_shutdown(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
 	.remove = dw_i2c_plat_remove,
+	.shutdown = dw_i2c_plat_shutdown,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = dw_i2c_of_match,

-- 
2.54.0.545.g6539524ca2-goog

