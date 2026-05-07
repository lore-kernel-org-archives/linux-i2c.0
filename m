Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFC306B3B;
	Thu,  7 May 2026 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154275; cv=none; b=DgfArKxATnJwlhGxNCpHUPSwg8RbWuHInxfoXTfKLTrDyPLkslvrDLtPgvLRRlwIKgJL19jZJGZveDfy0QuIVMQ4A8q6bCQirxLT11fnnLJyVnYKuqbMta0tRDQGnC4AcF1qUNii2kxdw9ug1f4xXBGpEuOmPhobJUN/m89/GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154275; c=relaxed/simple;
	bh=BsLfyVKiXZWs+0cP61T3ZcSRufjoAGgnxI6JbJKm+Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aChU3d8IfjXcXg8XxCD6KPK79GNlaM+ELuE+mkQVJqKLjN5WPLfDUy4MVyx2Gt97l8w8uA+8CgSusqwP6SmtUaYlWcVOd+TO8p1A0IJ8C/ApcC3VRYQRolqs6uK8e35Zx6iofF1iL9EzA+zHvbA+MHYwzp7zOmuNT809I2vsMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LrZiShSw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LrZiShSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cI
	OxVggy/oGtIdJWD5TzWsr9gfJewY+4jEEYfMvLs3s=; b=LrZiShSwNmolVlh/WC
	TNhm1lqvLkPE3BT5tNWmWb1xeyK1T/UTnBD6wOmK1Z4bjQUd1xf7q9vZN9Yx7X1N
	AxdxQoeV9N+iIqFPm/8VkE7itphPW24UgXfG3WxcFZsYOQtyoNcCxIkaOLg9nJpX
	qz2jh3oK/fXM5qnPisgMJ/rYg=
Received: from wmy.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC3VeUAe_xpiCAKAA--.4229S2;
	Thu, 07 May 2026 19:44:11 +0800 (CST)
From: w15303746062@163.com
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] i2c: i801: fix hardware state machine corruption in error path
Date: Thu,  7 May 2026 19:43:56 +0800
Message-Id: <20260507114356.247525-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VeUAe_xpiCAKAA--.4229S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW8Jry8uryDWFWrtw1UWrg_yoW8KFWDpa
	17KrZ0yryDt3Wj9Fn8Ar47uFyrua1fGFWakFykK3Wjva13J3W8ZryftFyYvFykA3s3Z3ya
	qFyvqasruF4q9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7GYLUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wt6Xmn8ewsHUAAA3+

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A severe livelock and subsequent Hung Task panic were observed in the
i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
unconditional hardware register cleanup in the error handling path of
i801_access().

When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
controller is actively used by BIOS/ACPI or another thread), the kernel
does not actually acquire the hardware ownership. However, the code jumps
to the 'out' label and executes:

    iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));

This forcefully clears the INUSE_STS lock and resets the hardware status
flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
transactions and totally corrupts the SMBus hardware state machine.

Consequently, all subsequent i801_access() calls fail at the pre-check
stage, triggering an endless stream of "SMBus is busy, can't use it!"
error logs. Over a slow serial console, this printk flood monopolizes
the CPU (Console Livelock), starving other processes trying to acquire
the mmap_lock down_read semaphore, ultimately triggering the hung task
watchdog.

Fix this by introducing an 'out_err' label. If i801_check_pre() fails,
we safely bypass the hardware register cleanup and only release the
software locks (pm_runtime and mutex), strictly adhering to the rule of
not releasing resources that were never acquired.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/i2c/busses/i2c-i801.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..068b9ffb234f 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -905,7 +905,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	ret = i801_check_pre(priv);
 	if (ret)
-		goto out;
+		goto out_err;
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -938,6 +938,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out_err:
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;
-- 
2.34.1

