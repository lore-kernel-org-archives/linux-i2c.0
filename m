Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395552F26A;
	Tue, 29 Sep 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700314; cv=none; b=dw5tWJS0huqhpau5C1LWl7MXJ88yEaV+VtPMA81mESKsg3nh1/L7h1DJ4+hOLZk5JTDFMeHfBfWGTzie1Qtttbb6futxOqfLYFSXgzo4h++Bi1cMek0LVYRHkk26kgBylS6tf/0kFqx8VvD+rI2ObRyr21rLWW3LxDyV5KiL78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700314; c=relaxed/simple;
	bh=3jqrM9EGYP8FnJ+uVUl8StogGkbJ+YwRcrYDm56BpyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSO+NskMJulcCTMB3uVP/8wenwzk5ig14IWlnxdnHh9YDoMF7CuiR4IMkTWIL5KxKCvbNRD478wyvSpZS3GL3mDjVnZSOGMCWDZkt4SN+KH1Tx4dXbDUzCf6utQcZZ+xX6ONoKAv7c24L/WJlwhDZaDZ5iLJqwP+0zwainGnjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpip3t1790700227t56fcb664
X-QQ-Originating-IP: ruwgAguqXXmvgGsRabDLzZIOFYP2ovGEJlAQXfOKK2E=
Received: from kylin-ThinkBook-14-G5-ABP.. ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Sep 2026 00:43:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14446974795521971140
EX-QQ-RecipientCnt: 10
From: Hongjian Dai <daihongjian@kylinsec.com.cn>
To: codrin.ciubotariu@microchip.com,
	andi.shyti@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	me@cherr.cc,
	Hongjian Dai <daihongjian@kylinsec.com.cn>
Subject: [PATCH] i2c: at91: release DMA channels when probe defers
Date: Wed, 30 Sep 2026 00:43:40 +0800
Message-ID: <7D85C6CB6BF0A82E+20260929164340.41628-1-daihongjian@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MCg5+ArSTX6cnkbLBDuw/XLMOxMvJYQ986eHpEYKeTgNw3VzLOoRpNnc
	QboNz7xor0Zays01hvGKgQchVQxWp2LwUcdsNId3dxWGAVjIIOK8oZxq8UfsixkW9nHjMrz
	7dfJgw7JK8ey49p4bjPZZlLTTtoPC9Ou/LbmgiNqiJPoIN3gSs1QFmQd9DGs4CnEPCxkAmY
	aYiiYGen60VU0IPTVtVM+e7Ot0O2YhL77zX/ulfpvc1heH2BDqrnNpRDh/qwRUxbQqqia6+
	6fGEmcTlWgpV+jUFy9iWdwRWlZ8BTbLWzJYfIFOOJG6IqXLYerfw3wP2zua5C4SAq2OiYGf
	SWlXGSWxdO7SAmj3Fj6qtaO0cxh//41xxzFwa4CA3H/lf5vCnHGVptzfeRzPjqboCEQLu7N
	kpqM1r+e/uI2SrE312P3MgC2EDYETB4iQ/eq+URo3aV+1P6yi5Ye2+OEZLLPtFhpRS/jV0U
	yK3m9CrhTdPVCf7v2MxiMuS6dD3PZbs8rIvThvv52dusrLMWe4DQjDsRrmc9k2XraMS19rS
	397RpSdk4/jGylHY0UMHMzLUBjvQuAbPfXCeRBLlKoozaw4rZKicCWpxJYijTa0mcnYBeqm
	urQo0eUQ6T393q9HEv5+4Jf1uMEl8+/bLAXPkPMvL97BJig6V97hKGzditAVIP/H4wk3q9c
	gUz1A8Fh0EFcNe84AXu5OQ/hPebDKiQLHwLXAQ2TXYvh4V+0TTf3sQnY3+NM3omssszycpQ
	AG7JlR9WWKzwPqYYo8e/gbWy5fQSMj4S6kfczfKVyzognJZIxyVicqqFUh/xxFxsITCKdVO
	cQVE1phBvaXCUw8MDL93LdB7LH5GtDuuf2Ncr+2B632OphCHYzSTl9/Nq7E/6yMGJY89KRN
	DNjkg/sjZF/iO1PblGZTB8/BDdC5avOmdh1lgZsKjIYeVRZY0hIeUXEckJCdOV8jh+WRFbj
	kqoz2XEGtA6TZzrVLDnCnO/XdgVYpd//T52TeoI80Bu0nPg1sQu2PCw7IGqOTlj3CGoFUeQ
	Awk5OklWdYDEFq6INTGTQizxC7RiBtvt4FaU+1QQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

at91_twi_probe_master() can return -EPROBE_DEFER from
at91_init_twi_recovery_info() after at91_twi_configure_dma() has already
claimed the tx/rx DMA channels. at91_twi_probe() then returns without
releasing them, and since dma_request_chan() is not devres-managed the
channels leak on every deferred probe attempt.

Release the channels before deferring the probe.

Fixes: f7eeb1af8537 ("i2c: at91: release DMA channels on remove and probe error")
Assisted-by: LLM
Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>
---
 drivers/i2c/busses/i2c-at91-master.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 68238cc8aee0..e0c3de5e8203 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -921,8 +921,14 @@ int at91_twi_probe_master(struct platform_device *pdev,
 	at91_calc_twi_clock(dev);
 
 	rc = at91_init_twi_recovery_info(pdev, dev);
-	if (rc == -EPROBE_DEFER)
+	if (rc == -EPROBE_DEFER) {
+		/*
+		 * The DMA channels were already set up above, release them
+		 * before deferring the probe so they are not leaked.
+		 */
+		at91_twi_dma_release(dev);
 		return rc;
+	}
 
 	dev->adapter.algo = &at91_twi_algorithm;
 	dev->adapter.quirks = &at91_twi_quirks;
-- 
2.43.0

