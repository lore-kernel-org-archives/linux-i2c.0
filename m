From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 0/6] I2C: DWC3 USB: Add support for ACPI based AArch64 Laptops
Date: Wed, 12 Jun 2019 15:26:48 +0100
Message-ID: <20190612142654.9639-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

This patch-set ensures the kernel is bootable on the newly released
AArch64 based Laptops using ACPI configuration tables.  The Pinctrl
changes have been accepted, leaving only I2C (keyboard, touchpad,
touchscreen, fingerprint, etc, HID device) and USB (root filesystem,
camera, networking, etc) enablement.

v4:
 * Collecting Acks
 * Adding Andy Gross' new email
 * Removing applied Pinctrl patches
 
Lee Jones (6):
  i2c: i2c-qcom-geni: Provide support for ACPI
  i2c: i2c-qcom-geni: Signify successful driver probe
  soc: qcom: geni: Add support for ACPI
  usb: dwc3: qcom: Add support for booting with ACPI
  usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
  usb: dwc3: qcom: Improve error handling

 drivers/i2c/busses/i2c-qcom-geni.c |  17 ++-
 drivers/soc/qcom/qcom-geni-se.c    |  21 ++-
 drivers/usb/dwc3/Kconfig           |   2 +-
 drivers/usb/dwc3/dwc3-qcom.c       | 221 +++++++++++++++++++++++++----
 4 files changed, 225 insertions(+), 36 deletions(-)

-- 
2.17.1
