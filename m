Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE31C8714
	for <linux-i2c@vger.kernel.org>; Wed,  4 Sep 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440450; cv=none; b=h0UPfcLP8V+s/P4u17zqIqdGK2PAHvo1bOczsMSLQSMTvkg/YyHJHrVSXkQgycYYwtEelRA2kiCzNCuHLV9KKrMpbIiZKVlQaaFn6SxHtfzUw4570jcUuDkpuAhW0wtG1xy4rpm9sAvnc2rsKM+dRsS0va5F4I3qMJijEpqeTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440450; c=relaxed/simple;
	bh=/6+e29D1jTzHcDiEl7NM7CoTAoSOKhezsDzMCtm9gzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUHyunOEEnI8lSlMWAPtnSZHlgRHthZ27Fkmy4U6tYIzILwNUON4po5qGniPFlpsWFHY7BXO/1PyXXi37ilDjJAsJ1Rht2xaBcxzYyrOP6mYYlvdzLGxjq1RO+N9+iPvpSR0X0ctoBtUYkCTkxmE/sq3eKQ3Yqk8siMCSQIAJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nFGD00MS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFGD00MS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715cdc7a153so416125b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 04 Sep 2024 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725440448; x=1726045248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lx3yQsWkTb9x7LagKbuMm4vpMCf33yZ7BqsG5IeSJA=;
        b=nFGD00MS5rxhyjP+cGASjFLb6A1Pk1osknyZHSio5PPze02s4bhkL/qnQf9z8XihKY
         qEe3mVK8ZGeUC0YItRKmqTqXjkrrTXvT0EQeWvdYWKFmaw4Q525icTxKTa/CPY0iIBnu
         CPMUIf8P0IpikobI/WHx6kXPDdQytS38AcXUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440448; x=1726045248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lx3yQsWkTb9x7LagKbuMm4vpMCf33yZ7BqsG5IeSJA=;
        b=mKPeCaW5dQ28NsROyoIPdxLv+r+hzqudfzVEsEWMcA9eiUKFG5TGBg5sYqLlVgn7ne
         iVlS3OG1us8iv8/zBg4P748lmFaTzTgSlvmwDwV+PNoFKxOCWNfLBl39s7rvuw/F9+AE
         4pDF/seO6bsv7Xq4i8+hchKMeKBrJj+58fzBF3bIivY5709rUaF4zE6Rr2phCWEOLCme
         8Rb27lEYNGl8Vnoyc2t8a3bunsHlfXJCNo3Xs3DQMYlKPa2TyvT5TxnYKl4Rq9TeLWFg
         SPRFWatYuvLHaBm4l7E5SQMfhu/J9nwddZcat8lK7gO2/2YOhNOTa76R6m9+stYLt9p7
         guHw==
X-Forwarded-Encrypted: i=1; AJvYcCXuzEauzME/PviriOdExenZ/AmBoiFZutVtvu9+H7KRre8TcCPTchXXesHVmSLaX3z0ctfMy3UnuOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxoa2Gj0+YKxyq9GilLmQYB8MgkrsqL6i+RQu2DxUFOa40l9gl
	PUCZnGcfx12W5u8lrKNZvJRJcHfQayV3dSa+yk+g6BcYMbZ3Tls+R+6qcKmc6Q==
X-Google-Smtp-Source: AGHT+IFljw5CEOubKFgJs6Qw/4fe2qNKJQ/lUogumRK/GAi7DQzBwRnb7bCkK8F5ANHCSTOzSxDq3Q==
X-Received: by 2002:a05:6a00:2e08:b0:714:228d:e9f2 with SMTP id d2e1a72fcca58-7177a92187bmr2450461b3a.3.1725440448446;
        Wed, 04 Sep 2024 02:00:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:83fc:5c8e:13bd:d165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b5183sm1153279b3a.197.2024.09.04.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:00:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 07/12] i2c: core: Remove extra space in Makefile
Date: Wed,  4 Sep 2024 17:00:09 +0800
Message-ID: <20240904090016.2841572-8-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904090016.2841572-1-wenst@chromium.org>
References: <20240904090016.2841572-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some lines in the Makefile have a space before tabs. Remove those.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/all/ZsdE0PxKnGRjzChl@smile.fi.intel.com/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- new patch
---
 drivers/i2c/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 3f71ce4711e3..f12d6b10a85e 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -5,10 +5,10 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
-i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
+i2c-core-objs			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
-i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
-i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
+i2c-core-$(CONFIG_I2C_SLAVE)	+= i2c-core-slave.o
+i2c-core-$(CONFIG_OF)		+= i2c-core-of.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
-- 
2.46.0.469.g59c65b2a67-goog

