Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2C47D936
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710218; cv=none; b=T+k6/wJ5d4sVuQOzWm0wqeil03sm6cLIGAOcc6/FsU4PcHTe5QMZ8GTw7HPWZExStWux0/n5ZGu0HndMt+TE3cFoybl1qJ+0YBByv/AkyzG22PKtPNFOsSkTMh0qRgSDVpjasNWir1gs++4zNhcQOmbFd1L4/Wj3a0fukRrsd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710218; c=relaxed/simple;
	bh=GPLlRbLJnYXKj41dySc/bLm2yeMD3rDpzLmM+aJJhxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1CrcVMknjExpjOzZ3kP+5Oen+awWl8riIodXVc71zBqG0JkzwB8UFMTF+z51Cc0VP3EZGqYeXSBRt/wxd0goP4gNDxuQ5Hl5ulomee5D5hczus2lsZYYLHWK5EU5Yom127PEU9nNUFAELoQNomORvw7NCGw4o0rOdo3dAPywcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Ts+Q3ZiK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Ts+Q3ZiK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce7d2adef4so126562015ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784710216; x=1785315016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qi+rYGhYoYrIT3wt7YVhvPEC/e1JWhXFM89SBw059ww=;
        b=Ts+Q3ZiKhtfTVNHmZlBlunZ8S8rlxUxknaDIZIOau2IyBDpGyyffPpyHUhH0D0TbS9
         wkuRHzwerlE+4r+JDJxg1tZ8EticZNwAz3NB9zOhlanJIiQuEIQmwCVW3ySSvGv39UwE
         VvrjJ5GfoTX7gs6T0qcJLyG9yBO3b40K3dKbk8RJKxuEJjXBD8ZSkX0mZayn5ZINUIEZ
         HBuZr3qvQp/DEzEgvkunHMOYAGulGDBh4XgAP1pj7iHMtwgCtLGI1KyfW9mlDzskEBgT
         3EiLqC3+qF/sVSA8rdEoprUys3mBUp8Rqo6n+rIXVbITSrucfCqeImyj+s8LBZwzhSoH
         bTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710216; x=1785315016;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qi+rYGhYoYrIT3wt7YVhvPEC/e1JWhXFM89SBw059ww=;
        b=Q6lEWdwDXLswzJWcKYzoTEBvkv4FXt+RkuotrnslD78VBbo9dsWNCnRVJZQTDok7gn
         IhOrtzs+ULEdPBlI5fzsMjoED7lRcIcbUHLBQtiAozEX6Yuu6OJ+X174MzLQT1iTo2Yx
         e8Y8ldDkuKyj5HtkmUbK5gc8Eap10Zvr8t+xcVKJkrQY8auWptlwpkB7Pm0BT+50QlF/
         QoKJSw1zPcmJR7Jxx8XCn5Ex/iwoGIAXDRJuXw0S0XdgF4Eu8N2S3sOiDCW1GstZzwLa
         1iYvVaeG7PWBUEJL6lkMqk5nKoWjKTSuDd1oPlJaabiJUV13pEFQWhNooo0wxl0FSwXK
         aXZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1HzAOvvaYQnipu+XTax7c9eRoZH+BKOiM/hwBAio/zEM+qRQYUglC/yK0BpTNTaEEmbnPCNav52s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4sDrzcg+8IgLVTRROypuyekq7GgCaArSUR5VhGjVd86oQZF2
	+Bqs5GdWH31on8q0nPBrqbJmMVL30OJDy6arlheI+R1n+46RcQ5T0WqyCs5B/tPWUGk=
X-Gm-Gg: AR+sD12jchgy+u0G48jB1hVcTHd0vYuzYrypsO2tQZEcvpXhtmgqFmLDHQ1vwJia+v5
	Y09b155ZYmGcdNzBYebbO4QgBVEJREbLWDErQHBUb9u5ILXN86YnBRB0HLtpH77K4kslQd0CkEz
	J0tB/B/GRkaH7bbkKOBGyiovhDYOY5GnbO5GoiOlns6KohKQBMJfcR/CgS2oeHrZjYbpiIvSqVd
	RjKZDRLvb77ZW68shMH7kwpPXeaK92u7DN+ZnJ4f6QAgRm1n8tMTiPpKLonMJl/Hr6oVbbQDHcU
	Ws74SUz2NdxnBWvmfp6UihlmlQmlEq0K+VVlEDd8/byfOyh4REuLDkG1c5Hr5ndRYhT48KDXmFa
	D82wGv15MHuiO5TQr1kaBTkuOVxRF1mtWcwpjzDiMCxQkUCcNmr4/zMZIoS85mA7laf1lbB9vjd
	/qkRdWF+SFtgaYUxOhcNZsY1oGmaeaKOlO3fFgMIM+V+yw2SJhgvp3ghOUsA==
X-Received: by 2002:a17:903:3807:b0:2ce:9439:59a5 with SMTP id d9443c01a7336-2cf349a15c6mr224355315ad.36.1784710216191;
        Wed, 22 Jul 2026 01:50:16 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a6adsm6909614eec.6.2026.07.22.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:50:15 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v5 0/2] i2c-tools: Make tools accept bus path
Date: Wed, 22 Jul 2026 02:52:39 -0600
Message-Id: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBQFf4V0bU0ptIAr/8O4aC8XqOHRtJVoC
 P9uwYUb4nKSOXMW4tEZ9OSSLMThbLyZxgjilBDo1NgiNXVkwhmXTGSMKgC0gdbRBaRWhY6KrEp
 lDhWkdUPi0DpszGuP3u5f9k/9QAhbaTM648Pk3vvrnG3e34M5o4xyBizVZSMLLq/ambZTA6jBa
 uz7M0wD2a7m/BcrmDiM5TEGkoNSBStVhcexdV0/FQXgfB0BAAA=
X-Change-ID: 20260530-accept-device-path-539164c9c1df
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=GPLlRbLJnYXKj41dySc/bLm2yeMD3rDpzLmM+aJJhxI=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ1ZCy7MP6WfLU5Y6+u6e/0/m576HrpX7T7bm3vx9VGLx2
 eOn9q6Y1lHKwiDGxSArpsiicmuW+sXJ1o8ORvBPgJnDygQyhIGLUwAmwifByDA5dmfo5XvKbw5b
 bGSYuSTCPNbXL8uXP9n8ZJjg1irT3OsM/1Pdvds7o3Nu5/jya6iEvr78Zd5jjvvegZuupgWcUec
 M4wQA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

The purpose of this series is to make i2c-tools userspace utilities
accept an i2c bus character device file path as an argument. This is
useful, for example, if a sysadmin creates udev rules to create a
persistent symlink to an i2c bus and wishes to use that symlink with
i2c-tools.

Since v1:
 * Scrapped brittle checking against device major number 89 in favor of
   an i2c_bus_hint variant struct.
Since v2:
 * Scrapped i2c_bus_hint variant in favor of combining the lookup and
   open steps into one function. No more awkward variant.
Since v3:
 * Rebased onto `master` and fixed minor conflicts.
Since v4:
 * Inline much of the functionality of open_i2c_dev.
 * Where possible, make functions static.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
Brigham Campbell (2):
      i2c-tools: Allow passing device file paths
      i2c-tools: Document device paths as I2CBUS arg

 tools/i2cbusses.c   | 127 ++++++++++++++++++++++++++++++----------------------
 tools/i2cbusses.h   |   3 +-
 tools/i2cdetect.8   |   8 ++--
 tools/i2cdetect.c   |  14 +++---
 tools/i2cdump.8     |   7 +--
 tools/i2cdump.c     |  14 +++---
 tools/i2cget.8      |   9 ++--
 tools/i2cget.c      |  13 +++---
 tools/i2cset.8      |  12 ++---
 tools/i2cset.c      |  13 +++---
 tools/i2ctransfer.8 |   2 +-
 tools/i2ctransfer.c |  13 +++---
 12 files changed, 120 insertions(+), 115 deletions(-)
---
base-commit: 5852f5375eea6ca9dabf31f4772cb8b8ecc905d8
change-id: 20260530-accept-device-path-539164c9c1df

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

