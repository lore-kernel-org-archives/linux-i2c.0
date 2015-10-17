From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] i2c: pnx: fix warnings caused by enabling unprepared clock
Date: Sat, 17 Oct 2015 21:52:27 +0300
Message-ID: <1445107947-2888-1-git-send-email-vz@mleia.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:57941 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbJQSwa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 17 Oct 2015 14:52:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

If common clock framework is configured, the driver generates a warning,
which is fixed by this change:

    WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:727 clk_core_enable+0x2c/0xa4()
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper Not tainted 4.3.0-rc2+ #171
    Hardware name: LPC32XX SoC (Flattened Device Tree)
    Backtrace:
    [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
    [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
    [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
    [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
    [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
    [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
    [<>] (clk_enable) from [<>] (i2c_pnx_probe+0x108/0x2a8)
    [<>] (i2c_pnx_probe) from [<>] (platform_drv_probe+0x50/0xa0)
    [<>] (platform_drv_probe) from [<>] (driver_probe_device+0x18c/0x408)
    [<>] (driver_probe_device) from [<>] (__driver_attach+0x70/0x94)
    [<>] (__driver_attach) from [<>] (bus_for_each_dev+0x74/0x98)
    [<>] (bus_for_each_dev) from [<>] (driver_attach+0x20/0x28)
    [<>] (driver_attach) from [<>] (bus_add_driver+0x11c/0x248)
    [<>] (bus_add_driver) from [<>] (driver_register+0xa4/0xe8)
    [<>] (driver_register) from [<>] (__platform_driver_register+0x50/0x64)
    [<>] (__platform_driver_register) from [<>] (i2c_adap_pnx_init+0x18/0x20)
    [<>] (i2c_adap_pnx_init) from [<>] (do_one_initcall+0x11c/0x1dc)
    [<>] (do_one_initcall) from [<>] (kernel_init_freeable+0x10c/0x1d4)
    [<>] (kernel_init_freeable) from [<>] (kernel_init+0x10/0xec)
    [<>] (kernel_init) from [<>] (ret_from_fork+0x14/0x24)

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/i2c/busses/i2c-pnx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index e814a36..6f8b446 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -600,7 +600,7 @@ static int i2c_pnx_controller_suspend(struct device *dev)
 {
 	struct i2c_pnx_algo_data *alg_data = dev_get_drvdata(dev);
 
-	clk_disable(alg_data->clk);
+	clk_disable_unprepare(alg_data->clk);
 
 	return 0;
 }
@@ -609,7 +609,7 @@ static int i2c_pnx_controller_resume(struct device *dev)
 {
 	struct i2c_pnx_algo_data *alg_data = dev_get_drvdata(dev);
 
-	return clk_enable(alg_data->clk);
+	return clk_prepare_enable(alg_data->clk);
 }
 
 static SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
@@ -672,7 +672,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (IS_ERR(alg_data->ioaddr))
 		return PTR_ERR(alg_data->ioaddr);
 
-	ret = clk_enable(alg_data->clk);
+	ret = clk_prepare_enable(alg_data->clk);
 	if (ret)
 		return ret;
 
@@ -726,7 +726,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	return 0;
 
 out_clock:
-	clk_disable(alg_data->clk);
+	clk_disable_unprepare(alg_data->clk);
 	return ret;
 }
 
@@ -735,7 +735,7 @@ static int i2c_pnx_remove(struct platform_device *pdev)
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&alg_data->adapter);
-	clk_disable(alg_data->clk);
+	clk_disable_unprepare(alg_data->clk);
 
 	return 0;
 }
-- 
2.1.4
