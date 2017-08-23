From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c: nomadik: constify amba_id
Date: Wed, 23 Aug 2017 22:50:50 +0530
Message-ID: <8f8b0a93aa6838c4a33e273758e159ab264dec4e.1503508729.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35730 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbdHWRVN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Aug 2017 13:21:13 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: rubini@unipv.it, linus.walleij@linaro.org, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index da6609d..49c7c0c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1088,7 +1088,7 @@ static struct i2c_vendor_data vendor_db8500 = {
 	.fifodepth = 32, /* Guessed from TFTR/RFTR = 15 */
 };
 
-static struct amba_id nmk_i2c_ids[] = {
+static const struct amba_id nmk_i2c_ids[] = {
 	{
 		.id	= 0x00180024,
 		.mask	= 0x00ffffff,
-- 
2.7.4
