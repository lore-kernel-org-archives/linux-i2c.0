From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] i2c: qup: skip qup_i2c_suspend if the device is already runtime suspended
Date: Thu, 25 Aug 2016 12:23:39 +0100
Message-ID: <1472124219-1627-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

If the i2c device is already runtime suspended, if qup_i2c_suspend is
executed during suspend-to-idle or suspend-to-ram it will result in the
following splat:

WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x80/0x90
Modules linked in:

CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
PC is at clk_core_unprepare+0x80/0x90
LR is at clk_unprepare+0x28/0x40
pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145
Call trace:
 clk_core_unprepare+0x80/0x90
 qup_i2c_disable_clocks+0x2c/0x68
 qup_i2c_suspend+0x10/0x20
 platform_pm_suspend+0x24/0x68
 dpm_run_callback.isra.7+0x1c/0x70
 __device_suspend+0xf4/0x298
 dpm_suspend+0x10c/0x228
 dpm_suspend_start+0x68/0x78
 suspend_devices_and_enter+0xb8/0x460
 pm_suspend+0x1ec/0x240
 state_store+0x84/0xf8
 kobj_attr_store+0x14/0x28
 sysfs_kf_write+0x48/0x58
 kernfs_fop_write+0x15c/0x1f8
 __vfs_write+0x1c/0x100
 vfs_write+0x9c/0x1b8
 SyS_write+0x44/0xa0
 el0_svc_naked+0x24/0x28

This patch fixes the issue by executing qup_i2c_pm_suspend_runtime
conditionally in qup_i2c_suspend.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/i2c/busses/i2c-qup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 501bd15cb78e..a8497cfdae6f 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1599,7 +1599,8 @@ static int qup_i2c_pm_resume_runtime(struct device *device)
 #ifdef CONFIG_PM_SLEEP
 static int qup_i2c_suspend(struct device *device)
 {
-	qup_i2c_pm_suspend_runtime(device);
+	if (!pm_runtime_suspended(device))
+		return qup_i2c_pm_suspend_runtime(device);
 	return 0;
 }

--
2.7.4
