From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date: Mon, 10 Jun 2019 09:42:07 +0100
Message-ID: <20190610084213.1052-2-lee.jones@linaro.org>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

The Qualcomm Geni I2C driver currently probes silently which can be
confusing when debugging potential issues.  Add a low level (INFO)
print when each I2C controller is successfully initially set-up.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9e3b8a98688d..a89bfce5388e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -596,6 +596,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
+
 	return 0;
 }
 
-- 
2.17.1
