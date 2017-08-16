From: Colin King <colin.king@canonical.com>
Subject: [PATCH][i2c-next] i2c-cht-wc: make cht_wc_i2c_adap_driver static
Date: Wed, 16 Aug 2017 10:16:59 +0100
Message-ID: <20170816091659.10738-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58698 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdHPJRB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Aug 2017 05:17:01 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure cht_wc_i2c_adap_driver is local to the source
and does not need to be in global scope, so make it static.

Cleans up sparse warning:
symbol 'cht_wc_i2c_adap_driver' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index fe5caf70c7fe..01c94c918d4c 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -322,7 +322,7 @@ static struct platform_device_id cht_wc_i2c_adap_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, cht_wc_i2c_adap_id_table);
 
-struct platform_driver cht_wc_i2c_adap_driver = {
+static struct platform_driver cht_wc_i2c_adap_driver = {
 	.probe = cht_wc_i2c_adap_i2c_probe,
 	.remove = cht_wc_i2c_adap_i2c_remove,
 	.driver = {
-- 
2.11.0
