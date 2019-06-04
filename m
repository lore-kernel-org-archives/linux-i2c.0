From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
Date: Tue,  4 Jun 2019 11:44:54 +0100
Message-ID: <20190604104455.8877-7-lee.jones@linaro.org>
References: <20190604104455.8877-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604104455.8877-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, kramasub@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

When booting with Device Tree, the current default boot configuration
table option, the request to boot via 'host mode' comes from the
"dr_mode" property.  A property of the same name can be used inside
ACPI tables too.  However it is missing from the SDM845's ACPI tables
so we have to supply this information using Platform Device Properites
instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 349bf549ee44..f21fdd6cdd1a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -468,6 +468,11 @@ static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
 
+static const struct property_entry dwc3_qcom_acpi_properties[] = {
+	PROPERTY_ENTRY_STRING("dr_mode", "host"),
+	{}
+};
+
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct device_node	*np = pdev->dev.of_node, *dwc3_np;
@@ -603,6 +608,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			goto platform_unalloc;
 		}
 
+		ret = platform_device_add_properties(qcom->dwc3,
+						     dwc3_qcom_acpi_properties);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to add properties\n");
+			goto platform_unalloc;
+		}
+
 		ret = platform_device_add(qcom->dwc3);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add device\n");
-- 
2.17.1
