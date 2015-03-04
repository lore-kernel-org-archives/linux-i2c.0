From: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/2] i2c: Support for Netlogic XLP9XX/5XX I2C controller.
Date: Wed, 4 Mar 2015 12:25:31 +0530
Message-ID: <1425452133-7489-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Subhendu Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here is an updated version of the i2c controller driver on Broadcom
XLP9xx MIPS SoC.

We have taken care of the review comments for v1, and have made some
additional fixes while going thru the process. The Changelog is below.

Please let me know if there are any comments or suggestions.

Thanks,
JC.

Changes v1->v2:
* Implement changes from Ray Jui's review
  - Support for 0 length transfers
  - remove .owner assignment in platform_driver and .data assignment in
    of_device_id table
  - add synchronize_irq and disable interrupt in .remove
  - Move most prints to dev_dbg
  - add COMPILE_TEST
  - align wrapped line in function definitions
  - IRQ_NONE return if interrupt is not ours.
  - error check frequency setting in DTB
  - fix check of return of devm_ioremap_resource() and remove
    unnecessary prints
  - fix incorrect irq check
  - include file ordering fixed
  - few unneeded variables taken out
  - use u32 consistently for unsigned 32 bit int
  - add comment for prescale value calculation

* Change clock-frequency parameter to take the bus frequency
  as expected in i2c subsystem

* Rearrage register definitions to group them better

* Add I2C_FUNC_10BIT_ADDR to xlp9xx_i2c_functionality()

* use reinit_completion before each transfer

* use i2c_add_adapter instead of doing i2c_add_numbered_adapter

Subhendu Sekhar Behera (2):
  of: Add vendor prefix 'netlogic'
  i2c: Support for Netlogic XLP9XX/5XX I2C controller.

 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  19 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-xlp9xx.c                    | 446 +++++++++++++++++++++
 5 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 create mode 100644 drivers/i2c/busses/i2c-xlp9xx.c

-- 
1.9.1
