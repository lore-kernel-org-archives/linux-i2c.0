From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 8/8] usb: dwc3: qcom: Improve error handling
Date: Mon, 10 Jun 2019 09:42:13 +0100
Message-ID: <20190610084213.1052-8-lee.jones@linaro.org>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

dwc3_qcom_clk_init() is called with of_count_phandle_with_args() as an
argument.  If of_count_phandle_with_args() returns an error, the number
of clocks will be a negative value and will lead to undefined behaviour.

Ensure we check for an error before attempting to blindly use the value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 55ba04254e38..e4dac82abd7d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -409,6 +409,9 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	if (!np || !count)
 		return 0;
 
+	if (count < 0)
+		return count;
+
 	qcom->num_clocks = count;
 
 	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
-- 
2.17.1
