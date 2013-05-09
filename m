From: Libo Chen <libo.chen@huawei.com>
Subject: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before it init successful
Date: Thu, 9 May 2013 16:27:23 +0800
Message-ID: <1368088044-20408-2-git-send-email-libo.chen@huawei.com>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonic.Zhang@analog.com, wsa@the-dreams.de
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lizefan@huawei.com, Libo Chen <libo.chen@huawei.com>
List-Id: linux-i2c@vger.kernel.org

down out_error_no_irq. When platform_get_irq fail, no need to free peripheral

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 05080c4..6617645 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -709,9 +709,9 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 out_error_add_adapter:
 	free_irq(iface->irq, iface);
 out_error_req_irq:
-out_error_no_irq:
 	peripheral_free_list((unsigned short *)pdev->dev.platform_data);
 out_error_pin_mux:
+out_error_no_irq:
 	iounmap(iface->regs_base);
 out_error_ioremap:
 out_error_get_res:
-- 
1.7.1
