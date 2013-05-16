From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Thu, 16 May 2013 10:50:07 +0800
Message-ID: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: Barry Song <Baohua.Song@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Xiaomeng Hou <Xiaomeng.Hou@csr.com>
List-Id: linux-i2c@vger.kernel.org

From: Xiaomeng Hou <Xiaomeng.Hou@csr.com>

if we initilize i2c bus by module_init, there are some devices which want
initialization earlier than i2c and could not do that in time, so move i2c
driver initilization to subsys_initcall and make i2c ready before devices
init.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/i2c/busses/i2c-sirf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5a7ad24..e438f48 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -454,7 +454,19 @@ static struct platform_driver i2c_sirfsoc_driver = {
 	.probe = i2c_sirfsoc_probe,
 	.remove = i2c_sirfsoc_remove,
 };
-module_platform_driver(i2c_sirfsoc_driver);
+
+static __init int i2c_sirfsoc_init(void)
+{
+	return platform_driver_register(&i2c_sirfsoc_driver);
+}
+
+static void __exit i2c_sirfsoc_exit(void)
+{
+	platform_driver_unregister(&i2c_sirfsoc_driver);
+}
+
+subsys_initcall(i2c_sirfsoc_init);
+module_exit(i2c_sirfsoc_exit);
 
 MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
 MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
