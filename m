Return-Path: <SRS0=t01v=DH=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA7C2D0A8
	for <linux-i2c@archiver.kernel.org>; Wed, 30 Sep 2020 07:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E122075F
	for <linux-i2c@archiver.kernel.org>; Wed, 30 Sep 2020 07:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgI3HOx (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:14:53 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56347 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbgI3HOx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Sep 2020 03:14:53 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 08U7DuH7016068;
        Wed, 30 Sep 2020 10:13:56 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id D7798639D5; Wed, 30 Sep 2020 10:13:55 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     wsa@kernel.org, andriy.shevchenko@linux.intel.com, xqiu@google.com,
        kunyi@google.com, benjaminfair@google.com, avifishman70@gmail.com,
        joel@jms.id.au, tmaimon77@gmail.com
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v1] i2c: npcm7xx: Support changing bus speed using debugfs.
Date:   Wed, 30 Sep 2020 10:13:42 +0300
Message-Id: <20200930071342.98691-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Systems that can dinamically add and remove slave devices
often need to change the bus speed in runtime.
This patch exposes the bus frequency to the user.
This feature can also be used for test automation.

Fixes: 56a1485b102e (i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver)
Signed-off-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 2ad166355ec9..44e2340c1893 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2208,6 +2208,41 @@ static const struct i2c_algorithm npcm_i2c_algo = {
 /* i2c debugfs directory: used to keep health monitor of i2c devices */
 static struct dentry *npcm_i2c_debugfs_dir;
 
+static int i2c_speed_get(void *data, u64 *val)
+{
+	struct npcm_i2c *bus = data;
+
+	*val = (u64)bus->bus_freq;
+	return 0;
+}
+
+static int i2c_speed_set(void *data, u64 val)
+{
+	struct npcm_i2c *bus = data;
+	int ret;
+
+	if (val < (u64)I2C_FREQ_MIN_HZ || val > (u64)I2C_FREQ_MAX_HZ)
+		return -EINVAL;
+
+	if (val == (u64)bus->bus_freq)
+		return 0;
+
+	i2c_lock_bus(&bus->adap, I2C_LOCK_ROOT_ADAPTER);
+
+	npcm_i2c_int_enable(bus, false);
+
+	ret = npcm_i2c_init_module(bus, I2C_MASTER, (u32)val);
+
+	i2c_unlock_bus(&bus->adap, I2C_LOCK_ROOT_ADAPTER);
+
+	if (ret)
+		return -EAGAIN;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(i2c_clock_ops, i2c_speed_get, i2c_speed_set, "%lld\n");
+
 static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 				  struct npcm_i2c *bus)
 {
@@ -2223,6 +2258,7 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("rec_succ_cnt", 0444, d, &bus->rec_succ_cnt);
 	debugfs_create_u64("rec_fail_cnt", 0444, d, &bus->rec_fail_cnt);
 	debugfs_create_u64("timeout_cnt", 0444, d, &bus->timeout_cnt);
+	debugfs_create_file("i2c_speed", 0644, d, bus, &i2c_clock_ops);
 
 	bus->debugfs = d;
 }

base-commit: 06d56c38d7d411c162e4d406a9864bed32e30e61
-- 
2.22.0

