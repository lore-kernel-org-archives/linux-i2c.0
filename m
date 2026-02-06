Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19672EE5FC
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373691; cv=none; b=g31rIJwTiZQOTjZjcj4TE3W1KItDQJ91XqNVvZ4D0AE94fYa3Pdq9R3D0vdhu7GHTYhGUjStds+IPCqokuXAX4okaPnaIGnf9A7y5rAD6uo7SvaWy8x9lhPx5FCyEpN+8sfgq4umDP17dsRhUxW+TesgPtNfAvA1qT6FW4mmPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373691; c=relaxed/simple;
	bh=MGzU5XV9oidAi7TVfG3Lywdby56GcQhKhZjDkTR9Nnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puAIa+7mz1ZGyuijNPagDR4wsmpUWcDmzxMTFMCKVNgvmyhjDqeYph9XppLsdwFdCXVhfJsyNU8hdivBDYGoHrSaSQ1Oi1PPFVSRVyz86jNAI07pNESCh0r4eIn3yuiVpnpUtwnP6irP9Bsr+o7h7NDJIHIhziFqAeA7KBV7sB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRG/guzL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRG/guzL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so22282145e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 02:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770373689; x=1770978489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1znmvJRZinh0UjxXVnbV8XU237BL4In8MXKnqCzTiis=;
        b=cRG/guzLCvhrYnEdDGTwevhiQ/cwTE1LcIBoz71CtdDrX8xt3lEPRcjjL82M9Diwv0
         Bn7Wvr7R3OMYbrluamnJEmXm+g9kW7SC77cdAAJcATOZIJpY8X/mZ1bdF/XOIWKn7Buj
         xYRUrXaL8WIBWvoQZDqoVOAmsgpLtDRk6xrqoKORKZO6ywPeqjGBrvRiReLKJU2F22qC
         DNP/cq0dP5Mn3LFlFBrzcn+yDfLI3+diky+ISCY13gCa8x9zhL7+nUT8kG0uFISkTvEr
         3FzJAiZxI8PFiD+3D9R1VurO/UK/gddQQ2D5r5Us1KWt0CJq137mxT/gn85h1t4jEy8n
         znUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770373689; x=1770978489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1znmvJRZinh0UjxXVnbV8XU237BL4In8MXKnqCzTiis=;
        b=a6lA8njDiKFd5Usdu0jbSonmle6qikq8aFdcRELx8Gj9NXVbYX32zeBlvNeC23csD5
         T+n+hYYR3tXU2dK4iCGwYEVIa/rtdQLZc52jyfWaWjL/IPtFXve8CE+xz5XA9n6t7DFQ
         RvjrcWAhBT1BWYP0dac1/V8g5JPwv/BbAuPD/NSpqIMf2Eh3cqxpw6tRcyhWU9w3pmq0
         0q32ODxk5v5qWDUOElIs9/hpmIzMQfPSiDHcfDA5UJZHo1YxSywWpec9o3oZb8LWk8VA
         x/TUUd/YIMWlE1Xkwa7gyq79Y/aqz2w6JR9KGTcHiE6qxNRqEIIN+gdG8Jd/slp91NjL
         VTJg==
X-Forwarded-Encrypted: i=1; AJvYcCUFA1WcMNFrsDL/WOM5EXrchl5QvBL3w2xkFr9nnxhFes1rMgn3ybrYd0k7MIfZQoTZHR0sZz5+mbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO40qO/8IX4BNUeD98GS61K59fBmvllRxe5zW76CrskGIt+YJ
	4Hsfl6RWQTh4MB3fILva0EZpO7kCAJPgqA/FyEYoTmR2GVdSRR6Yvila
X-Gm-Gg: AZuq6aKEi6XQc2w3eqMQU2Bh5TNs/2BQGNOYiFLbF7dxYieMb4xaB0NhNjxHunBYFgn
	DpKqagREidseLmu5sdZyMsqZXZ1zT8WSUH9ZS/w2l8LHVvv8UBUVDRJ6BN8TOv+i6dJm8qy4Xbj
	XRHJ9FbhXhqiiIwQEp30Dw7YVDhd3uBv2gaqQ0NVTwn1QHa+CcOafUwwWOerYNuRCnUR3fEleb6
	KEfXWowLYJLQuxfLuxnGmzUqvyGEtKHewJ7R01r4tTVk8EK2Aisj71sreGy0J1kwBWXQrhT4aCx
	oJKwgHG/tJlkxQxpcfNvL/frPeTw2e4JqjjT5Qjk8T5G5VvBi7CaOputKkn0fr8Synn+GUdtzwd
	w6ddGQ1q050vyk94JnZAdFJBGhl70K2axbFDX1gJEqJJW/yhb+01K2xSLcnjiXGcOaSb4vN99Y2
	FUGUS+FgSJLW1GC+SFFo6drCqEoMsvFSCLxW6VSY4lUXVjPdc=
X-Received: by 2002:a05:600c:548d:b0:480:7162:fa48 with SMTP id 5b1f17b1804b1-483201ecd90mr35232785e9.13.1770373688883;
        Fri, 06 Feb 2026 02:28:08 -0800 (PST)
Received: from localhost.localdomain ([196.189.144.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm108677295e9.2.2026.02.06.02.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 02:28:08 -0800 (PST)
From: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Tinsae Tadesse <tinsaetadesse2015@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: spd5118: Fail probe if SPD writes are disabled
Date: Fri,  6 Feb 2026 13:26:59 +0300
Message-ID: <20260206102758.14626-1-tinsaetadesse2015@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPD5118 requires write access for page selection, configuration,
and cache synchronization during suspend/resume. If the host
controller does not allow SPD writes, the driver cannot function
properly.

Detect this state using adapter quirks and determine whether to
stop the probe.

Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
---
Changes in v2:
- Return the device probe error value

---
 drivers/hwmon/spd5118.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index 5da44571b6a0..9aa2b2aa6b39 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -525,6 +525,8 @@ static int spd5118_common_probe(struct device *dev, struct regmap *regmap,
 	unsigned int capability, revision, vendor, bank;
 	struct spd5118_data *data;
 	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct i2c_adapter_quirks *quirks;
 	int err;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -552,6 +554,19 @@ static int spd5118_common_probe(struct device *dev, struct regmap *regmap,
 	if (!spd5118_vendor_valid(bank, vendor))
 		return -ENODEV;
 
+	/*
+	 * SPD5118 requires write access for correct operation
+	 * (page selection, configuration, and suspend/resume cache sync).
+	 * If the SPD writes are blocked by the SMBus controller, the
+	 * probe fails.
+	 */
+	client = to_i2c_client(dev);
+	quirks = client->adapter->quirks;
+	if (quirks && (quirks->flags & I2C_AQ_SPD_WRITE_DISABLED)) {
+		return dev_err_probe(dev, -ENODEV,
+				"SPD Write Disable is set on adapter; refusing probe\n");
+	}
+
 	data->regmap = regmap;
 	mutex_init(&data->nvmem_lock);
 	dev_set_drvdata(dev, data);
-- 
2.52.0

