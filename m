From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910 family
Date: Tue, 14 Jul 2015 13:06:39 +0530
Message-ID: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch series fixes bugs/warnings, cleans up the code and adds
support for PXA910 family of devices to PXA I2C bus driver.

There has been one attempt made sometime back in 2012 to upstream
some of the patches from below list, but did not get follow up later.
I have consolidated all the patches, cleaned them up, splited into
logical changes, added new patches and submitting it now.

I tried to maintain authorship & Signoff except where I did some
significant changes to the code/logic.


Link to previous post:
http://permalink.gmane.org/gmane.linux.drivers.i2c/13557

Testing:
  - Basic testing on PMIC device on I2C-0 interface
  - Boot tested on platform based on PXA1928
  - Probe is successfully passing
  - Read few registers of PMIC (RTC, ID, etc...) during boot

V3 => V4
=======
Link to V3: http://www.spinics.net/lists/devicetree/msg85904.html

  - [PATCH 06/11] Removed unnecessary dev_err on devm_kzalloc() check
  - [PATCH 06/11] Removed return check on platform_get_resource(), as 
    devm_ioremap_resource() does it for us.
    Also, brought up the devm_ioremap_resource() function call in the execution
    sequence, as no point in delaying it if we do not have resource.
    It make sense, after this change.
  - [PATCH 04/11] Typecast changed to 'enum pxa_i2c_types'
    Also updated the subject line "Removed ==> Fix"

V2 => V3
=======
Link to V2: http://www.spinics.net/lists/linux-i2c/msg20059.html

  - Removed PATCH [4/12] related to reset of I2C module.
    Suggested by "Robert Jarzmik"
  - Updated commit description for,
      PATCH [11/12]: Mentioned reasoning about moment of clk_get code.
      PATCH [12/12]: for DT property node.
  - Added Acked by "Robert Jarzmik" to patched which he acked.

V1 => V2:
========
Link to V1 - http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347012.html

  - Fixed all comments from "Robert Jarzmik" and "Wolfram Sang"
  - Dropped Patch
	05/12: using core bus reset implementation - under work.
               Will submit shortly.
       	08/12: NAKed and dropped
  - Separated DT binding patch from driver changes, for easy merge


Leilei Shang (1):
  i2c: pxa: keep i2c irq ON in suspend

Shouming Wang (1):
  i2c: pxa: Return I2C_RETRY when timeout in pio mode

Vaibhav Hiremath (7):
  i2c: pxa: No need to set slave addr for i2c master mode reset
  i2c: pxa: Update debug function to dump more info on error
  i2c:pxa: Use devm_ variants in probe function
  Documentation: binding: add new property 'disable_after_xfer' to
    i2c-pxa
  i2c: pxa: Add support for pxa910/988 & new configuration features
  i2c: pxa: Add ILCR (tLow & tHigh) configuration support
  Documentation: binding: add sclk adjustment properties to i2c-pxa

Yi Zhang (1):
  i2c: pxa: enable/disable i2c module across msg xfer

Yipeng Yao (1):
  i2c: pxa: Fix compile warning in 64bit mode

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  18 ++
 drivers/i2c/busses/i2c-pxa.c                      | 261 ++++++++++++++++------
 2 files changed, 211 insertions(+), 68 deletions(-)

-- 
1.9.1
