Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C12126C02;
	Sun, 26 Apr 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777171519; cv=none; b=dRuxRWhOmOlxcqN+ftiQ4BBxehf0WlntQQON1EKQuTq6rN1vxahbWQGQ5YCkNRuvh0AhoHOK6cdmkVP9ns7m7GfOrmUjCZT0DXM/63AzeGwiJwNsJBX8LQyzR7lrfqEVwBO4DkgVbb9g+21VnvFtPSdDCqCCw4vUmquyE7UDlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777171519; c=relaxed/simple;
	bh=P6vg/u8mtaOqDTc++MuUp6HgFqxSPaUF8GiwXM2ZEw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kvoc7f+4/6CZsTTrtRFNO/75/oIKNR5v0SA2uCpz+8kCbhy++It0hc4tl7FIQFyfkyjQtxDkMeDIr4OCwQSRFMY95EZhVAQLXnXN+iLRxnc/0tj1XCeKS46m7mOl9xXl6vPkdN3gxk063lYB/iFvos9N9x4iosRE0OBUKFwmkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gJk3nKDC; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="gJk3nKDC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 655AA114D3D;
	Sun, 26 Apr 2026 04:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777171515; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=OCw1cmmN/s4IqyAwm6S/ENA1IUWW4c1JPYW+MdOnM6w=;
	b=gJk3nKDC0OQ5FIOvLERMM5dIY8XkXJSsCGm5gd0ljl36aByaPr4oo0mmHtDs43ym+00OIN
	Svqcjo7LF696g3B9CLdQucNrmMtmoT3vxK3h3c2tYQto/ib1muGj5MUM0zjWPFTwn/yhu7
	/o6GLXhvHZdLsgdRmy3ZXkgDFTjMPbjExmRDPO0EjxTTc8aYslugZNQieYED8kTLMnD/Ec
	J6LAh3T+cR7TsqMYm3SR6GraNJokNy1Yr0V/NXx3B9BA0VzqpB5WwugEUFQqCLxgQ9f1jT
	5FtvRn+GZ7IUMumLrI5kUPU9Jj1G3w5pue4bWWx+ePHp01bFEQoAA+auh1u4dQ==
From: Marek Vasut <marex@nabladev.com>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: core: Default to read-only if wp-gpios present
Date: Sun, 26 Apr 2026 04:44:32 +0200
Message-ID: <20260426024507.597480-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In case the nvmem DT node contains "wp-gpios" DT property, the device
currently defaults to read-write and the force_ro sysfs attribute reads
0. Switch to the default read-only, which is both safer, and aligned
with eMMC HW BOOT partition force_ro sysfs attribute behavior, which
also defaults to read-only.

The adjustment of nvmem->read_only value to read-only in case wp-gpios
DT property is present must be done only after the device_add() got
called because device_add() does internally call nvmem_bin_attr_get_umode(),
which configures the permissions of 'nvmem' bin attr based on the value
of nvmem->read_only that is only parsed from DT property 'read-only',
without any adjustment. This way, if DT property 'read-only' is present,
the 'nvmem' attribute is always read-only. Otherwise, if the device is
writeable, then 'nvmem' attribute is writeable, and nvmem->read_only
defaults to read-only, but can be switched to read-write at runtime via
the 'force_ro' attribute.

The updated behavior can be tested as follows:

Current content:
"
$ cat /sys/bus/nvmem/devices/logging7/force_ro
1

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
V2: Simplify the implementation, make devices with wp-gpios default
    to read-only and let users unlock those devices via force_ro
    sysfs attribute, just like eMMC HW BOOT partitions
---
 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02..0b1942e389113 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1019,6 +1019,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_dev;
 
+	/* If the device has WP GPIO, default to read-only */
+	if (nvmem->wp_gpio) {
+		nvmem->read_only = true;
+		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
+	}
+
 #ifdef CONFIG_NVMEM_SYSFS
 	rval = nvmem_populate_sysfs_cells(nvmem);
 	if (rval)
-- 
2.53.0

