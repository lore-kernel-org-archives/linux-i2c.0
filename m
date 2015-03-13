From: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/2] i2c: Support for Netlogic XLP9XX/5XX I2C controller
Date: Fri, 13 Mar 2015 11:59:56 +0530
Message-ID: <1426228198-3314-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here is v3 of the driver for XLP9xx I2C controller. We have udpated
the driver with changes for the review from Uwe.

Please let me know if there are any comments or suggestions.

Thanks,
JC.

Changes v2->v3:
* Implement changes from Uwe Kleine-K=C3=B6nig's review:
  - add documentation link
  - remove unnecessary #includes
  - remove DATARDY interrupt
  - clean up alignment and whitespace
  - set CMD_STOP flag only for the last transfer
  - correct freq assignment in xlp9xx_i2c_get_frequency
  - remove printing out adap.nr in case of failure
  - update writing to control register to make the logic clear
  - clean up the #define ordering and naming a bit more
* use correct type in handling return of wait_for_completion_timeout

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

 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-xlp9xx.c                    | 446 +++++++++++++=
++++++++
 5 files changed, 480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.tx=
t
 create mode 100644 drivers/i2c/busses/i2c-xlp9xx.c

--=20
1.9.1
