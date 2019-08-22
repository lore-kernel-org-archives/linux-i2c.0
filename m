From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH] i2c: ocores: use request_any_context_irq() to register IRQ handler
Date: Thu, 22 Aug 2019 15:21:32 +0200
Message-ID: <20190822132132.16557-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Peter Korsgaard <peter@korsgaard.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@cern.ch>
List-Id: linux-i2c@vger.kernel.org

The i2c-ocores device is an HDL component that get instantiated in FPGA.
The software stack used to drive an FPGA can be very different, and the
i2c-ocore ip-core must work in different context. With respect to this
patch the IRQ controller behind this device, and its driver, can have
different implementations (nested threads). For this reason, it is safer
to use `request_any_context_irq()` to avoid errors at probe time.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 4117f1abc7c6..ca8b3ecfa93d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -703,8 +703,9 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (ocores_algorithm.master_xfer != ocores_xfer_polling) {
-		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
-				       pdev->name, i2c);
+		ret = devm_request_any_context_irq(&pdev->dev, irq,
+						   ocores_isr, 0,
+						   pdev->name, i2c);
 		if (ret) {
 			dev_err(&pdev->dev, "Cannot claim IRQ\n");
 			goto err_clk;
-- 
2.15.0
