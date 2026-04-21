Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153E3D7D8A;
	Tue, 21 Apr 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780489; cv=none; b=QChikO2MgPJrfBx+LYJ+BvzOd7uzZSfpVz6kIQ9YzmEun8wp3Gie03wiJ2U1fFsHYBzk5YV+Cqm57UTBBaL2XTDkQLdDn5NJctkYABc+kmul8yNW6aY21sQ1Iywe5jUFRByFK8bdo/8Ul6zO5ql2VGC8M6IHw4zUuDBvQch39Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780489; c=relaxed/simple;
	bh=U3S/azcYtoK8lqyCMrjeJ/KYEZqdHpjzdHxJ59k4dfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTy2xQSItL8pwUlqY+fV2qaJkIXJcZu93yNvuvukwZxrz7Hps4o4A0PaaReCXg07oDczsnxdWS5qU0r02QBPYAytK+8zAycjIE6ddSz0nbCaddzb0msQShXGpP3VFfOiGKCAPPz50Dr+j99/xznFVD093BrGyEM6FFdkxcNgTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=SKXpzINo; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="SKXpzINo"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 855D61147FA;
	Tue, 21 Apr 2026 16:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776780478; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ONHip1GbFzvZ4cejM52KSuI+49tZZL0UydKXrafRDOQ=;
	b=SKXpzINoETov8u3ksehh8NnLGkKRkat+0/W/iCk6kpxpKqDThTVnyISyVYkZOvY3SBS8Pv
	3tyV/6VCbGZ2GKw5DC4TW1wPLX5N3OPVgIoWAhESfDaeC1fAunBSAK3Nde8vufCTbu7xLI
	/r8dF46xPERu2Cu6s/jU0JFCNYCUdMLXZHq0y5nq9th70APWZY52ZdEYUmhz/jq9aM3WBh
	+bKHpqXhCCsjI5wHuUq8MVlvxbFgup1CDI47hhBWr4T2Vvh8gmNLjbi/pc99vzX1hO7Gqh
	KIvYzBhDRA7CukSE1+hylC1wCtrTvYaPeolxWjh2v9wn0EHl9s7S2phgzmSOJg==
From: Marek Vasut <marex@nabladev.com>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both read-only and wp-gpios
Date: Tue, 21 Apr 2026 16:06:49 +0200
Message-ID: <20260421140755.54222-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Handle special-case of AT24 EEPROM described in DT, which contains both
"read-only" and "wp-gpios" properties. Interpret this configuration as
default read-only, but with the possibility of unlock via force_ro sysfs
attribute.

For this to work, the nvmem core must keep the "nvmem" sysfs bin attr as
read-write, any writes into the bin attr which occur while the device is
read-only are blocked in bin_attr_nvmem_write(). The AT24 EEPROM driver
must not mark the EEPROM as read-only if both "read-only" and "wp-gpios"
DT properties are present.

The updated behavior can be tested as follows:

Current content:
"
$ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
00000000  66 6f 6f 0a ff ff ff ff
"

Write into default-read-only device:
"
$ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
bash: echo: write error: Operation not permitted
$ cat /sys/bus/nvmem/devices/logging7/force_ro
1
"

Unlock and write into device:
"
$ echo 0 > /sys/bus/nvmem/devices/logging7/force_ro
$ cat /sys/bus/nvmem/devices/logging7/force_ro
0

$ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
$ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
00000000  62 61 72 0a ff ff ff ff
"

Relock and write into device, fails because device is read-only again:
"
$ echo 1 > /sys/bus/nvmem/devices/logging7/force_ro
$ echo baz > /sys/bus/nvmem/devices/logging7/nvmem
bash: echo: write error: Operation not permitted

$ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
00000000  62 61 72 0a ff ff ff ff
"

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/misc/eeprom/at24.c | 3 ++-
 drivers/nvmem/core.c       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0200288d3a7ab..9ef00b0ce83d2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -627,7 +627,8 @@ static int at24_probe(struct i2c_client *client)
 		page_size = 1;
 
 	flags = cdata->flags;
-	if (device_property_present(dev, "read-only"))
+	if (device_property_present(dev, "read-only") &&
+	    !device_property_present(dev, "wp-gpios"))
 		flags |= AT24_FLAG_READONLY;
 	if (device_property_present(dev, "no-read-rollover"))
 		flags |= AT24_FLAG_NO_RDROL;
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02..c0eedfe8d706c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -282,6 +282,9 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
 	if (!nvmem->root_only)
 		mode |= 0044;
 
+	if (nvmem->read_only && nvmem->reg_write)
+		mode |= 0200;
+
 	if (!nvmem->read_only)
 		mode |= 0200;
 
-- 
2.53.0

