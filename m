Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E7423A61;
	Fri,  8 May 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259642; cv=none; b=fpKRD5Qyu68NmryGu2Y6Lt1UohIinH2aR3NAzf4gll79xySUQi2ZW/yTXKUdLjDB2yQjmZ/9ZBOSMO7nXOeKeCswZDois21fKrLznY9jb0NNGi8XqRtUmR+6wthemx+rMEro0sqI8jNkSl97Y5vvTWHfi3ma4mwkwJVmcjeq814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259642; c=relaxed/simple;
	bh=6GWnrhPtCt8z+xja1vhQtIKnmHl+KDzASgdjiNRokls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3CX6WAomv7Q2Hsp8mwR5UjMt6A7vHwVg0aMwmXln4k0EsAXOjXG55Ui7eHOeUOMBTSy8HydnfYt/PWIWq2BdwEM0RwaL/JmD9a4dkPaHHz3+bxqF0cB/Y/zQxIhxiwV4Jwh+EajptzReaTu95m37nqF8bUQQtzihuHVOKag1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=h5toUFH5; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="h5toUFH5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1D4D11246D;
	Fri,  8 May 2026 19:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778259636; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=liaZ+ZDZEG4iFeXBJPKtXIAuHGGnhSNYt+fPUomNifE=;
	b=h5toUFH54koOrtaVvDI3YdPOMz+X/PdrETp+jdUI+kuukzTyRQvg7yXazolARljycw6/TR
	8rQ5XtL9y31LeEqSEtqyaJ20ui7xOEHser4a1fhlhC7pX2waq6GFWJNu3Po5Kc3zNYHP/w
	S+OoYisBggFbLqS1/9NhRdRkvSGf7FnVAVhAxkw7bn6CswBZcF7TtxyKzAL4o63H+4LP62
	USH7Idlyn4MaAM0ZTgKIiJaDiV7yUzQ5SQKIF4F1QK1vy6SLUDk9k3ZdU9YWw28DiArdca
	XoHVlXK406fV6i9lfklARSRWLa0wGd33L86PPb0L6q9962PqQOcWHS7DC5sLgw==
From: Marek Vasut <marex@nabladev.com>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvmem: core: Default to read-only if wp-gpios present
Date: Fri,  8 May 2026 19:00:20 +0200
Message-ID: <20260508170032.560650-1-marex@nabladev.com>
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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
V3: Drop unnecessary gpiod_set_value_cansleep()
V4: Add RB from Bartosz
---
 drivers/nvmem/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02..be28a366f6031 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1019,6 +1019,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_dev;
 
+	/* If the device has WP GPIO, default to read-only */
+	if (nvmem->wp_gpio)
+		nvmem->read_only = true;
+
 #ifdef CONFIG_NVMEM_SYSFS
 	rval = nvmem_populate_sysfs_cells(nvmem);
 	if (rval)
-- 
2.53.0

