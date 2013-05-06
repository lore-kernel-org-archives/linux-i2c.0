From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH 1/2] i2c: i2c-bfin-twi: don`t free peripheral before it`s
 init successful
Date: Mon, 6 May 2013 21:11:18 +0800
Message-ID: <5187ABF6.4000907@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>
List-Id: linux-i2c@vger.kernel.org


down out_error_no_irq. When platform_get_irq fail, no need to free peripheral

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 05080c4..d38e05a 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -709,8 +709,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 out_error_add_adapter:
 	free_irq(iface->irq, iface);
 out_error_req_irq:
-out_error_no_irq:
 	peripheral_free_list((unsigned short *)pdev->dev.platform_data);
+out_error_no_irq:
 out_error_pin_mux:
 	iounmap(iface->regs_base);
 out_error_ioremap:
-- 
1.7.1
