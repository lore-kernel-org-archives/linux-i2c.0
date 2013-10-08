From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/9] i2c: i2c-mxs: replace platform_driver_probe to support
 deferred probing
Date: Tue,  8 Oct 2013 22:35:35 +0200
Message-ID: <1381264542-29396-4-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/i2c/busses/i2c-mxs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index f4a0167..b7c8577 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -780,12 +780,13 @@ static struct platform_driver mxs_i2c_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = mxs_i2c_dt_ids,
 		   },
+	.probe = mxs_i2c_probe,
 	.remove = mxs_i2c_remove,
 };
 
 static int __init mxs_i2c_init(void)
 {
-	return platform_driver_probe(&mxs_i2c_driver, mxs_i2c_probe);
+	return platform_driver_register(&mxs_i2c_driver);
 }
 subsys_initcall(mxs_i2c_init);
 
-- 
1.8.4.rc3
