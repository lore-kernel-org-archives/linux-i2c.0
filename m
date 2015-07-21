From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-v5 0/5] i2c: pxa: Add support for PXA910 family of device
Date: Tue, 21 Jul 2015 18:11:01 +0530
Message-ID: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: robert.jarzmik-GANU6spQydw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch-series is subset of the original patch-series, submitted
on 14 Jul 2015.
Link to Original Patch-series - https://lkml.org/lkml/2015/7/14/80

The first six patches have been already queued up for upstream. So this
patch-series is respin of remaining 5 patches.

Testing:
  - Basic testing on PMIC device on I2C-0 interface
  - Boot tested on platform based on PXA1928
  - Read few registers of PMIC (RTC, ID, etc...) during boot

V4 => V5
=======
Link to V3: https://lkml.org/lkml/2015/7/14/80
  - Dropped First 6 patches as they are already accepted, queued for upstream
  - Fixed a bug in PATCH [5/5], where for non PXA910 devices it as resulting into
    NULL pointer dereference.


For the record, pasting all the details from original patch-series -

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


Vaibhav Hiremath (4):
  Documentation: binding: add new property 'disable_after_xfer' to
    i2c-pxa
  i2c: pxa: Add support for pxa910/988 & new configuration features
  Documentation: binding: add sclk adjustment properties to i2c-pxa
  i2c: pxa: Add ILCR (tLow & tHigh) configuration support

Yi Zhang (1):
  i2c: pxa: enable/disable i2c module across msg xfer

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  18 +++
 drivers/i2c/busses/i2c-pxa.c                      | 154 ++++++++++++++++++++--
 2 files changed, 163 insertions(+), 9 deletions(-)

-- 
1.9.1
