Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF9C433B4
	for <linux-i2c@archiver.kernel.org>; Tue,  4 May 2021 13:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38A76115C
	for <linux-i2c@archiver.kernel.org>; Tue,  4 May 2021 13:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEDNxL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 4 May 2021 09:53:11 -0400
Received: from smtp1.axis.com ([195.60.68.17]:46183 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhEDNxL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 May 2021 09:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1620136336;
  x=1651672336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1iENLt//KBfg17reazfrU60VwtlexWbd03KEL50ys7Q=;
  b=k6rjHqd16FOul5iqZNJzBbNvUty2p94jl/uiWb1gAPb3dDa8rR602ku6
   9hy07oXrgyecInAQeKbTqnnnnHAF/u8Gru70NgDKX77gC+p5ThVrA5Uia
   TZqU0ICP3uLDnidBn5R+8JVfXDEpSF2A3hYHlZ1WGI8u13uZXHqQ8gm98
   obeVG07mmGWZU3/YFLV7Z+glP/5gKtVFdQaoW8Cbc2wlP/GgAWZhj+0o4
   Sc5DEmJMLEb4N5q/kdTUNvfQkIHKyLI6FTMLdM02LvtFCyitNHCIsYhNu
   UnPzZE3L306NFp4ouu4oFKJfCzg9LzWUbLnQGGnWGJNNCgB4+DJ7Q3xUc
   Q==;
From:   =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>
To:     <wsa@kernel.org>
CC:     <linux-i2c@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>
Subject: [PATCH] i2c: slave-eeprom: add an of_match_table
Date:   Tue, 4 May 2021 15:52:09 +0200
Message-ID: <20210504135209.4757-1-bjorn.ardo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This is needed since commit af503716ac14 ("i2c: core: report OF style
module alias for devices registered via OF").

Signed-off-by: Björn Ardö <bjorn.ardo@axis.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 5c7ae421cacf..89274b72b369 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -204,9 +204,23 @@ static const struct i2c_device_id i2c_slave_eeprom_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
 
+static const struct of_device_id i2c_slave_eeprom_match[] = {
+	{ .compatible = "linux,slave-24c02", },
+	{ .compatible = "linux,slave-24c02ro", },
+	{ .compatible = "linux,slave-24c32", },
+	{ .compatible = "linux,slave-24c32ro", },
+	{ .compatible = "linux,slave-24c64", },
+	{ .compatible = "linux,slave-24c64ro", },
+	{ .compatible = "linux,slave-24c512", },
+	{ .compatible = "linux,slave-24c512ro", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2c_slave_eeprom_match);
+
 static struct i2c_driver i2c_slave_eeprom_driver = {
 	.driver = {
 		.name = "i2c-slave-eeprom",
+		.of_match_table = i2c_slave_eeprom_match,
 	},
 	.probe = i2c_slave_eeprom_probe,
 	.remove = i2c_slave_eeprom_remove,
-- 
2.20.1

