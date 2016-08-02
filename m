From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:52:46 +0800
Message-ID: <20160802105246.30008-1-baolex.ni@intel.com>
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
To: linus.walleij@linaro.org, wsa@the-dreams.de, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org, baolex.ni@intel.com, aduggan@synaptics.com, linux-i2c@vger.kernel.org, chuansheng.liu@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 460c134..8128e25 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -133,7 +133,7 @@ enum stu300_error {
 
 /* I2C clock speed, in Hz 0-400kHz*/
 static unsigned int scl_frequency = 100000;
-module_param(scl_frequency, uint,  0644);
+module_param(scl_frequency, uint,  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /**
  * struct stu300_dev - the stu300 driver state holder
-- 
2.9.2
