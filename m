From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: fix & reorder remove & probe error handling
Date: Fri, 25 Oct 2019 16:04:24 +0200
Message-ID: <1572012264-31996-1-git-send-email-alain.volmat@st.com>
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
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, alain.volmat@st.com, linux-i2c@vger.kernel.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Add missing dma channels free calls in case of error during probe
and reorder the remove function so that dma channels are freed after
the i2c adapter is deleted.
Overall, reorder the remove function so that probe error handling order
and remove function order are same.

Fixes: 7ecc8cfde553 ("i2c: i2c-stm32f7: Add DMA support")

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d36cf08461f7..f8ef203dabfc 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1980,6 +1980,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(i2c_dev->dev);
 	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
 
+	if (i2c_dev->dma) {
+		stm32_i2c_dma_free(i2c_dev->dma);
+		i2c_dev->dma = NULL;
+	}
+
 clk_free:
 	clk_disable_unprepare(i2c_dev->clk);
 
@@ -1990,21 +1995,21 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
 {
 	struct stm32f7_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
-	if (i2c_dev->dma) {
-		stm32_i2c_dma_free(i2c_dev->dma);
-		i2c_dev->dma = NULL;
-	}
-
 	i2c_del_adapter(&i2c_dev->adap);
 	pm_runtime_get_sync(i2c_dev->dev);
 
-	clk_disable_unprepare(i2c_dev->clk);
-
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
 	pm_runtime_set_suspended(i2c_dev->dev);
 	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
 
+	if (i2c_dev->dma) {
+		stm32_i2c_dma_free(i2c_dev->dma);
+		i2c_dev->dma = NULL;
+	}
+
+	clk_disable_unprepare(i2c_dev->clk);
+
 	return 0;
 }
 
-- 
2.7.4
