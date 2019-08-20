From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: cht-wc: drop check because i2c_unregister_device() is NULL safe
Date: Tue, 20 Aug 2019 17:34:40 +0200
Message-ID: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/i2c/busses/i2c-cht-wc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 66af44bfa67d..3e2608a65c06 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -363,8 +363,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
 {
 	struct cht_wc_i2c_adap *adap = platform_get_drvdata(pdev);
 
-	if (adap->client)
-		i2c_unregister_device(adap->client);
+	i2c_unregister_device(adap->client);
 	i2c_del_adapter(&adap->adapter);
 	irq_domain_remove(adap->irq_domain);
 
-- 
2.20.1
