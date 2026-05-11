Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904029AB07;
	Mon, 11 May 2026 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511665; cv=none; b=cAb48K7UtvaJkz8FhY3mMPmseNPS6BbQiWfvTzYLe4dOkS99sNgu2O3/ZC6dIcGelkqdCx6rmeyz+Vvp1d5zT7wnYoy3WHuaplpvWx15XPhf5yATuUcrnddAcbIT6sFszfihBbMg00nJ18k7YlxAJx7YKS3TRTT68Z97WDhIqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511665; c=relaxed/simple;
	bh=XkKTI5y+ErRTTlJCjLCsDhnILjoy/oU8LKa8FcuGEIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKJSb1mrh3BjRypSVXINz4xeXBlKFULDT/jI4T11YlgTShpo9ZOEkjQDcQkoMKN2yuwVgMKVwTNR1XFh9TfERHgWYDLvVCBOtcEuiiNQ0oavZOvBBzZCI3nBKsQFXx4xA1IjR3KXX58sIDgKNJ1rikONyK2bYVggL/tRnKSOWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ENF8E9vT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ENF8E9vT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xu
	X75jjpbK07LnmdUYxMCVO8xPen3wa8Y0/Iuzsa3D8=; b=ENF8E9vTvXQ8SZMkaY
	EKhhxpPkuU+Mz2nPAeRmDUFb6Zb3qmb6/Ch69W4Fzd6GYXJsad3hdwxsIkgXH2R2
	XDHbQmKpHwWuILIiGkP/KtXqyWgYQd2mpJu+7SEOcTOrtEN19gHdLN2CpVyq7vZ9
	SFjx6PXoBcRWkdN533TYdpCYs=
Received: from wmy.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn93P67gFqPkJoAw--.2366S2;
	Mon, 11 May 2026 23:00:28 +0800 (CST)
From: w15303746062@163.com
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] i2c: i801: Fix kernel stack buffer overflow in i801_block_transaction_byte_by_byte
Date: Mon, 11 May 2026 23:00:05 +0800
Message-Id: <20260511150005.305818-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn93P67gFqPkJoAw--.2366S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4Dtr47WF17AFWDGr4rXwb_yoW8tr1fpr
	ZI939Ik34DtFsrKr1DA3y7uryxXws7tFWUGa4Du3Z8ua13t34jk3W8KFyF93W0g39akFy7
	X34jv347CFWqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5kuxUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wzZvWoB7wyCXwAA3e

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A kernel stack buffer overflow exists in the
i801_block_transaction_byte_by_byte() function due to a missing bounds
check on the user-provided block length.

When userspace executes an ioctl(I2C_SMBUS) with the
I2C_SMBUS_I2C_BLOCK_DATA command, the user data is copied into a local
stack variable `union i2c_smbus_data temp` (which is approximately 34
bytes) in i2cdev_ioctl_smbus(). This data is then passed unmodified
through i2c_smbus_xfer() and i801_access() directly into
i801_block_transaction_byte_by_byte().

The length of the transaction is blindly extracted from
`data->block[0]`. If a malicious user provides a maliciously large
length (e.g., 255), the subsequent `for (i = 1; i <= len; i++)` loop
will drive `ioread8()` to continuously read from the hardware and
write out-of-bounds into the `data->block` array. This completely
overwrites the 34-byte `temp` stack variable in i2cdev_ioctl_smbus(),
clobbering the kernel stack's return address and leading to control
flow hijacking (e.g., jumping to NX-protected pages).

Fix this by strictly validating that the length does not exceed
I2C_SMBUS_BLOCK_MAX before entering the read/write loop.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/i2c/busses/i2c-i801.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..b85c3f029d7c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -683,6 +683,14 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		return -EOPNOTSUPP;
 
 	len = data->block[0];
+	/*
+	 * Prevent kernel stack buffer overflow.
+	 * The user-provided length must not exceed the maximum SMBus block size.
+	 * Without this check, a malicious I2C_SMBUS_I2C_BLOCK_DATA ioctl can
+	 * overwrite the stack variable allocated in i2cdev_ioctl_smbus().
+	 */
+	if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
+		return -EINVAL;
 
 	if (read_write == I2C_SMBUS_WRITE) {
 		iowrite8(len, SMBHSTDAT0(priv));
-- 
2.34.1

