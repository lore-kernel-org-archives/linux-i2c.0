Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947B30E84B;
	Tue, 12 May 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562204; cv=none; b=XJ1d3Y7Nry0My+bVNuEFEDV6neGdUEsahnpPgdnpWyFLTpLJQTSV982em0hN3Kaf7sJU6AF5idqRISSh26DXqqXPyslS3CLv9usFn7IAEHARDxk5+hAraGSbmqwB+wLefbYouzaV/ZV1AnU++vF8p6XFAJAJ9R63r+ReT/qf9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562204; c=relaxed/simple;
	bh=7+FFgnpOt3jNy3r0aXcq52cj7T6afalXBzi6Cboo0wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dosMb/Szcct4x3B/C+Wm/7ejqhHxk1SrvAm34dW0y4jxENLaLxFWOFjYTvJWgUSlshSrtafOHKPY6VmpGMezaoWHueoBlcg9VhIvt8HJbj/pEXlPptXtp0JjVTxkMrdLU2lFqbGa0DMLsi8O/j7gjsVQwb+3ukrw5ktjov+Ap60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RDtFRyvk; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RDtFRyvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lU
	JiW1yZT6Aa0Hf0r1vf/SGuaFBBHudzxuphwzlz0GY=; b=RDtFRyvkgnGfaNAkw8
	1QO/MfxrJJupYk6aClSOfsGlpf+vblqrS40bhC2if+P2LE7sp/3p62hWTqyLAHeU
	ez/iKlIi3aTdlrYX4lZSD29JVQDXadZZwb19yvGURnWbpFdaeva3pLg1HFIpi/rg
	g/Y36CTJVXIL9iUOAt4rDDwuU=
Received: from wmy.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBX1xBitAJqk9HhAw--.21411S2;
	Tue, 12 May 2026 13:02:35 +0800 (CST)
From: <w15303746062@163.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] i2c: i801: Fix kernel stack buffer overflow in i801_block_transaction_byte_by_byte
Date: Tue, 12 May 2026 13:02:24 +0800
Message-Id: <20260512050224.347734-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX1xBitAJqk9HhAw--.21411S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw48Kw4kZry3Jw1UZr1kXwb_yoW5Jw1rpr
	Wak39Ik34DJFsF9rnrAayxuF97Zan7trWUGFyqgrn8uay3t34Ik3WrKryS9a1v939akF17
	Xw1jv34xCFyqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7GYLUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wtiRmoCtGtl3wAA3d

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
I2C_SMBUS_BLOCK_MAX before entering the read/write loop, while
exempting the special SMBUS_LEN_SENTINEL value used by the driver.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Added an exemption for SMBUS_LEN_SENTINEL to prevent breaking
   legitimate SMBus Block Read transactions where the length is
   initially unknown.
 - Removed duplicated paragraph in the commit message.

 drivers/i2c/busses/i2c-i801.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..4dd3ae5f49af 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -684,6 +684,15 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 
 	len = data->block[0];
 
+	/*
+	 * Prevent kernel stack buffer overflow.
+	 * The user-provided length must not exceed the maximum SMBus block size.
+	 * We must allow SMBUS_LEN_SENTINEL, which is used by the driver to
+	 * indicate an unknown length for SMBus Block Read.
+	 */
+	if (len < 1 || (len > I2C_SMBUS_BLOCK_MAX && len != SMBUS_LEN_SENTINEL))
+		return -EINVAL;
+
 	if (read_write == I2C_SMBUS_WRITE) {
 		iowrite8(len, SMBHSTDAT0(priv));
 		iowrite8(data->block[1], SMBBLKDAT(priv));
-- 
2.34.1

