From: Radu Rendec <radu.rendec@gmail.com>
Subject: [PATCH 2/2] i2c: ismt: dump registers at the end of transactions
Date: Fri, 18 Aug 2017 17:01:28 +0100
Message-ID: <20170818160128.21228-3-radu.rendec@gmail.com>
References: <20170818160128.21228-1-radu.rendec@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRQBv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Aug 2017 12:01:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id q189so4701890wmd.0
        for <linux-i2c@vger.kernel.org>; Fri, 18 Aug 2017 09:01:51 -0700 (PDT)
In-Reply-To: <20170818160128.21228-1-radu.rendec@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Radu Rendec <radu.rendec@gmail.com>

This patch dumps general and master registers at the end of transactions
when debugging is enabled. Previously, registers were only dumped before
submitting new descriptors (at the beginning of transactions).

This helps debugging if some registers change as result of a failed
transaction (e.g. bits are set in the ERRSTS general register).

Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index ccce0ca..003ea53 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -324,6 +324,8 @@ static int ismt_process_desc(const struct ismt_desc *desc,
 
 	dev_dbg(&priv->pci_dev->dev, "Processing completed descriptor\n");
 	__ismt_desc_dump(&priv->pci_dev->dev, desc);
+	ismt_gen_reg_dump(priv);
+	ismt_mstr_reg_dump(priv);
 
 	if (desc->status & ISMT_DESC_SCS) {
 		if (read_write == I2C_SMBUS_WRITE &&
-- 
2.9.5
