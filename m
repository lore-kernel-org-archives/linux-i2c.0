From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 2/2] i2c: iproc: Add full name of devicetree node to adapter name
Date: Thu,  8 Aug 2019 09:07:53 +0530
Message-ID: <1565235473-28461-3-git-send-email-rayagonda.kokatanur@broadcom.com>
References: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Lori Hikichi <lori.hikichi@broadcom.com>

Add the full name of the devicetree node to the adapter name.
Without this change, all adapters have the same name making it difficult
to distinguish between multiple instances.
The most obvious way to see this is to use the utility i2c_detect.
e.g. "i2c-detect -l"

Before
i2c-1 i2c Broadcom iProc I2C adapter I2C adapter
i2c-0 i2c Broadcom iProc I2C adapter I2C adapter

After
i2c-1 i2c Broadcom iProc (i2c@e0000) I2C adapter
i2c-0 i2c Broadcom iProc (i2c@b0000) I2C adapter

Now it is easy to figure out which adapter maps to a which DT node.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 19ef2b0..183b220 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -922,7 +922,9 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	adap = &iproc_i2c->adapter;
 	i2c_set_adapdata(adap, iproc_i2c);
-	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
+	snprintf(adap->name, sizeof(adap->name),
+		"Broadcom iProc (%s)",
+		of_node_full_name(iproc_i2c->device->of_node));
 	adap->algo = &bcm_iproc_algo;
 	adap->quirks = &bcm_iproc_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
-- 
1.9.1
