Return-Path: <SRS0=4qA4=7H=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE35C433E0
	for <linux-i2c@archiver.kernel.org>; Mon, 25 May 2020 09:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90137207CB
	for <linux-i2c@archiver.kernel.org>; Mon, 25 May 2020 09:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZhTiZQuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbgEYJ7s (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 25 May 2020 05:59:48 -0400
Received: from www.zeus03.de ([194.117.254.33]:59636 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389333AbgEYJ7s (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 25 May 2020 05:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=AqnwK2P7pWqRjwzPDgPEc0XSq9P
        LvTPXMEE+lFPRcuE=; b=ZhTiZQukvNWXbqaHb6Zbs/THGxSPrtrKXJUFavdH4jY
        GmVcvqCgYVHSI4nYRreKw7iLXsLyGhBs2pUyz7/ZGv+fLXXwm6yMeNI4B3WO+gnj
        gjZJvjgYEwMmJvrH/Q2cpOr+yMmZGWUjDJbLJNCD2xV+qc1qnJF8fJu80A7KauEk
        =
Received: (qmail 2284522 invoked from network); 25 May 2020 11:59:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2020 11:59:45 +0200
X-UD-Smtp-Session: l3s3148p1@0BDiCXamTOIgAwDPXwX9AARUgaNQd9RX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] i2c: slave-eeprom: skip useless initialization
Date:   Mon, 25 May 2020 11:59:33 +0200
Message-Id: <20200525095934.3058-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

We have a kzalloced struct, no need to init to 0.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 787fdb7f332f..6684852818ac 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -152,7 +152,6 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client, const struct i2c_de
 	if (!eeprom)
 		return -ENOMEM;
 
-	eeprom->idx_write_cnt = 0;
 	eeprom->num_address_bytes = flag_addr16 ? 2 : 1;
 	eeprom->address_mask = size - 1;
 	eeprom->read_only = FIELD_GET(I2C_SLAVE_FLAG_RO, id->driver_data);
-- 
2.20.1

