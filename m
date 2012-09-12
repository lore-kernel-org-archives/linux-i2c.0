From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/1] i2c:clk: preparation for switch to common clock framework
Date: Wed, 12 Sep 2012 16:00:49 -0400
Message-ID: <1347480049-12165-2-git-send-email-m-karicheri2@ti.com>
References: <1347480049-12165-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1347480049-12165-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

As a first step towards migrating davinci platforms to use common clock
framework, replace all instances of clk_enable() with clk_prepare_enable()
and clk_disable() with clk_disable_unprepare(). Until the platform is
switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
adds a might_sleep() call and would work without any issues.

This will make it easy later to switch to common clk based implementation
of clk driver from DaVinci specific driver.

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index b6185dc..85ce548 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -704,7 +704,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		r = -ENODEV;
 		goto err_free_mem;
 	}
-	clk_enable(dev->clk);
+	clk_prepare_enable(dev->clk);
 
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (!dev->base) {
@@ -751,7 +751,7 @@ err_free_irq:
 err_unuse_clocks:
 	iounmap(dev->base);
 err_mem_ioremap:
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
 err_free_mem:
@@ -775,7 +775,7 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
 
@@ -797,7 +797,7 @@ static int davinci_i2c_suspend(struct device *dev)
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(i2c_dev, 0);
-	clk_disable(i2c_dev->clk);
+	clk_disable_unprepare(i2c_dev->clk);
 
 	return 0;
 }
@@ -807,7 +807,7 @@ static int davinci_i2c_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
-	clk_enable(i2c_dev->clk);
+	clk_prepare_enable(i2c_dev->clk);
 	/* take I2C out of reset */
 	davinci_i2c_reset_ctrl(i2c_dev, 1);
 
-- 
1.7.9.5
