Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212332570D;
	Wed, 24 Jun 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280361; cv=none; b=uf+16dQhVL9JHftTIpGzB23PlvDMOIXLpjQnrHxkW9TrSWwiYsDFPKQXIof9J7Z6I+tMQyW0HqG2O/X7AQVaiJLTS+fTrZalkfTnDdmbGJqF1HcQXsYHoeNxvgqyt8CGIr+n3JBfUcTqiVd3mHxQB7NDx4P5/zFRmjlAEso5qdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280361; c=relaxed/simple;
	bh=aqCr87PbvOfUNX1U/miymM0D48YKzHJTuEOVMHkBJ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBITMhYrI/ZxOXbyM75SWVu7gF0n5aVE7IWR4vkf8YhOil/+m4mcGFuDedOqingnu49V5eug71W3THhjnB734Z6HahM5dBQk7LnOys2h2lmjHSniczSYPvPp6nmT3/qwJYv2z6DsGZQFjkmM+2lvGj78w79iWDUxLW/5yk+px8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAA3E5qlcDtqgBOtFQ--.13630S2;
	Wed, 24 Jun 2026 13:52:37 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] i2c: qup: Propagate clock enable failures
Date: Wed, 24 Jun 2026 13:52:37 +0800
Message-ID: <20260624055237.29977-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3E5qlcDtqgBOtFQ--.13630S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fKrW3tF4UCFWxJw4ruFg_yoW8KFWrpa
	1UJr4Fkr48Xwn2gw4avr1UZr98K395Ka4xJrZrG3Z293Z8Z342yF48JFyY9a10vryDAa1a
	qFWvyFWfCF4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v38UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The QUP I2C driver treats the core and iface clocks as required
resources, but qup_i2c_enable_clocks() ignores clk_prepare_enable()
failures.  Probe can then continue to register the I2C adapter, and
runtime/system resume can return success, even when a required clock
transition failed.

Make the helper return an error, unwind a partially enabled clock, and
propagate failures from probe and resume paths.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-qup.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index a0e076fc5f36..ee7915ee2ba2 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1657,10 +1657,21 @@ static const struct i2c_adapter_quirks qup_i2c_quirks_v2 = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 };
 
-static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
+static int qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
-	clk_prepare_enable(qup->clk);
-	clk_prepare_enable(qup->pclk);
+	int ret;
+
+	ret = clk_prepare_enable(qup->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(qup->pclk);
+	if (ret) {
+		clk_disable_unprepare(qup->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
@@ -1823,7 +1834,9 @@ static int qup_i2c_probe(struct platform_device *pdev)
 			ret = PTR_ERR(qup->pclk);
 			goto fail_dma;
 		}
-		qup_i2c_enable_clocks(qup);
+		ret = qup_i2c_enable_clocks(qup);
+		if (ret)
+			goto fail_dma;
 		src_clk_freq = clk_get_rate(qup->clk);
 	}
 	qup->src_clk_freq = src_clk_freq;
@@ -1975,8 +1988,7 @@ static int qup_i2c_pm_resume_runtime(struct device *device)
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
-	qup_i2c_enable_clocks(qup);
-	return 0;
+	return qup_i2c_enable_clocks(qup);
 }
 
 static int qup_i2c_suspend(struct device *device)
@@ -1988,7 +2000,12 @@ static int qup_i2c_suspend(struct device *device)
 
 static int qup_i2c_resume(struct device *device)
 {
-	qup_i2c_pm_resume_runtime(device);
+	int ret;
+
+	ret = qup_i2c_pm_resume_runtime(device);
+	if (ret)
+		return ret;
+
 	pm_request_autosuspend(device);
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

