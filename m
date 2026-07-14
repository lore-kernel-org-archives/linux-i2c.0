Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44C48A2DB
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041718; cv=none; b=G/YIIofXefuw+DwZ97d9IcNAWWEmzCmamLqp1XNFARp2iegVrfAouuP00PLTtY4yWWokgRuCt1ckb+CuwJq8p9Ri1v5558rpZNYSddHW+DPurHZxxavreueqS2r5tWn6SAcW7Di1tfFoQXhRZOtR819f9AaKBmDteCDqumGtYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041718; c=relaxed/simple;
	bh=HO2eSWdkSOcxh0xpZKMRY/Brla/UzFVT7CAQPMnVJqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDOnW6E9C9Nm13tm/Po8AlwT5F34zQN0J/6iEVLc66iEp2B1I/jQrtSlvQNfCF/kXt64wZaXoeb2Rm+2CddZXLoG5axWgVaqF05pSozosIkAjcjr7AlxlcLKc8tCkR+ZqlDUztNgZMIt+aRpuk/wn1iBjDZ9fQbSmj6/yupen+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmkF0f5D; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmkF0f5D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784041703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iwBSSYmCQ/6M6ihxE0JkAS/dkFMi1+DJS55iwfDdquI=;
	b=wmkF0f5DXTXTdxe40U0JvOgsc8vOJaNtnPFPwT0b0XMfZJ+kzylbIr9HXtZ6jPvifdo7IV
	k3EP7HillFPUHw0idMZo/kzXoOCT6UqcX4MKDFJYHXhc9iAhbuGRpAN7bOZH3Zz0ItAbn+
	jxMMmDWZrvxKr6OprtCXwt7G/zInyr8=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org
Cc: kblaiech@nvidia.com,
	asmaa@nvidia.com,
	vadimp@mellanox.com,
	wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: mlxbf: Fix use-after-free in mlxbf_i2c_init_resource()
Date: Tue, 14 Jul 2026 23:08:08 +0800
Message-ID: <20260714150808.85045-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

If devm_platform_get_and_ioremap_resource() returns an error,
mlxbf_i2c_init_resource() frees tmp_res before reading tmp_res->io to
get the error code. This results in a use-after-free.

Save the error code before freeing tmp_res.

Fixes: b5b5b32081cd ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/i2c/busses/i2c-mlxbf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 6c1cfe9ec8ac..e33512b25353 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -1051,8 +1051,10 @@ static int mlxbf_i2c_init_resource(struct platform_device *pdev,
 
 	tmp_res->io = devm_platform_get_and_ioremap_resource(pdev, type, &tmp_res->params);
 	if (IS_ERR(tmp_res->io)) {
+		int ret = PTR_ERR(tmp_res->io);
+
 		devm_kfree(dev, tmp_res);
-		return PTR_ERR(tmp_res->io);
+		return ret;
 	}
 
 	tmp_res->type = type;
-- 
2.51.0

