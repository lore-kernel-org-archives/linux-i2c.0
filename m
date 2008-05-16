From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Group bus drivers by type
Date: Fri, 16 May 2008 13:09:20 +0200
Message-ID: <20080516130920.0a735d77@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

This is an attempt to group the I2C/SMBus bus drivers by type in the
configuration menu, to make it easier for users to figure out what they
need. It could also be convenient for distributions to decide what
drivers they should include, and for developers too.

The groups I made are only a proposal at this point, I would welcome
comments and suggestions. In particular my "Other I2C/SMBus bus
drivers" group is still a bit large, so if someone has ideas to split
it further, please speak up. I was thinking of a group for embedded
platforms but I don't really know myself which of these drivers would
belong there, so I would probably get it wrong.

* * * * *

The list of I2C/SMBus bus drivers is growing and it is sometimes
difficult for the users to figure out what drivers they should enable.
By grouping the drivers by type, I hope to make the selection easier.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/Kconfig  |  460 +++++++++++++++++++++----------------------
 drivers/i2c/busses/Makefile |   39 ++-
 2 files changed, 257 insertions(+), 242 deletions(-)

--- linux-2.6.26-rc2.orig/drivers/i2c/busses/Makefile	2008-05-16 08:45:52.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/Makefile	2008-05-16 12:53:25.000000000 +0200
@@ -2,12 +2,34 @@
 # Makefile for the i2c bus drivers.
 #
 
+# PC SMBus host controller drivers
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
+obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
+obj-$(CONFIG_I2C_NFORCE2_S4985)	+= i2c-nforce2-s4985.o
+obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
+obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
+obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
+obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
+obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
+
+# Graphics adapter I2C/DDC channel drivers
+obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
+
+# External I2C/SMBus adapter drivers
+obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
+obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
+obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
+obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
+
+# Other I2C/SMBus bus drivers
+obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
@@ -15,42 +37,27 @@ obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
-obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
-obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
-obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
-obj-$(CONFIG_I2C_NFORCE2_S4985)	+= i2c-nforce2-s4985.o
 obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
 obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
-obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
-obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
-obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
 obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
+obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
 obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
-obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
-obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
-obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
 obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
-obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
-obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
-obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
-obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
-obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
-obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/Kconfig	2008-05-16 08:45:52.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/Kconfig	2008-05-16 12:56:43.000000000 +0200
@@ -4,6 +4,8 @@
 
 menu "I2C Hardware Bus support"
 
+comment "PC SMBus host controller drivers"
+
 config I2C_ALI1535
 	tristate "ALI 1535"
 	depends on PCI
@@ -73,6 +75,238 @@ config I2C_AMD8111
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd8111.
 
+config I2C_I801
+	tristate "Intel 82801 (ICH)"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the Intel
+	  801 family of mainboard I2C interfaces.  Specifically, the following
+	  versions of the chipset are supported:
+	    82801AA
+	    82801AB
+	    82801BA
+	    82801CA/CAM
+	    82801DB
+	    82801EB/ER (ICH5/ICH5R)
+	    6300ESB
+	    ICH6
+	    ICH7
+	    ESB2
+	    ICH8
+	    ICH9
+	    Tolapai
+	    ICH10
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-i801.
+
+config I2C_PIIX4
+	tristate "Intel PIIX4 and compatible (ATI/Serverworks/Broadcom/SMSC)"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the Intel
+	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
+	  versions of the chipset are supported (note that Serverworks is part
+	  of Broadcom):
+	    Intel PIIX4
+	    Intel 440MX
+	    ATI IXP200
+	    ATI IXP300
+	    ATI IXP400
+	    ATI SB600
+	    ATI SB700
+	    ATI SB800
+	    Serverworks OSB4
+	    Serverworks CSB5
+	    Serverworks CSB6
+	    Serverworks HT-1000
+	    SMSC Victory66
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-piix4.
+
+config I2C_NFORCE2
+	tristate "Nvidia nForce2, nForce3 and nForce4"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the Nvidia
+	  nForce2, nForce3 and nForce4 families of mainboard I2C interfaces.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-nforce2.
+
+config I2C_NFORCE2_S4985
+	tristate "SMBus multiplexing on the Tyan S4985"
+	depends on I2C_NFORCE2 && EXPERIMENTAL
+	help
+	  Enabling this option will add specific SMBus support for the Tyan
+	  S4985 motherboard.  On this 4-CPU board, the SMBus is multiplexed
+	  over 4 different channels, where the various memory module EEPROMs
+	  live.  Saying yes here will give you access to these in addition
+	  to the trunk.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-nforce2-s4985.
+
+config I2C_SIS5595
+	tristate "SiS 5595"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the
+	  SiS5595 SMBus (a subset of I2C) interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis5595.
+
+config I2C_SIS630
+	tristate "SiS 630/730"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the
+	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis630.
+
+config I2C_SIS96X
+	tristate "SiS 96x"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the SiS
+	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
+	  chipsets are supported:
+	    645/961
+	    645DX/961
+	    645DX/962
+	    648/961
+	    650/961
+	    735
+	    745
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis96x.
+
+config I2C_VIA
+	tristate "VIA VT82C586B"
+	depends on PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for the VIA
+          82C586B I2C interface
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-via.
+
+config I2C_VIAPRO
+	tristate "VIA VT82C596/82C686/82xx and CX700"
+	depends on PCI
+	help
+	  If you say yes to this option, support will be included for the VIA
+	  VT82C596 and later SMBus interface.  Specifically, the following
+	  chipsets are supported:
+	    VT82C596A/B
+	    VT82C686A/B
+	    VT8231
+	    VT8233/A
+	    VT8235
+	    VT8237R/A/S
+	    VT8251
+	    CX700
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-viapro.
+
+comment "Graphics adapter I2C/DDC channel drivers"
+
+config I2C_VOODOO3
+	tristate "Voodoo 3"
+	depends on PCI
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for the
+	  Voodoo 3 I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-voodoo3.
+
+comment "External I2C/SMBus adapter drivers"
+
+config I2C_PARPORT
+	tristate "Parallel port adapter"
+	depends on PARPORT
+	select I2C_ALGOBIT
+	help
+	  This supports parallel port I2C adapters such as the ones made by
+	  Philips or Velleman, Analog Devices evaluation boards, and more.
+	  Basically any adapter using the parallel port as an I2C bus with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a replacement for (and was inspired by) an older
+	  driver named i2c-philips-par.  The new driver supports more devices,
+	  and makes it easier to add support for new devices.
+
+	  An adapter type parameter is now mandatory.  Please read the file
+	  Documentation/i2c/busses/i2c-parport for details.
+
+	  Another driver exists, named i2c-parport-light, which doesn't depend
+	  on the parport driver.  This is meant for embedded systems. Don't say
+	  Y here if you intend to say Y or M there.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-parport.
+
+config I2C_PARPORT_LIGHT
+	tristate "Parallel port adapter (light)"
+	select I2C_ALGOBIT
+	help
+	  This supports parallel port I2C adapters such as the ones made by
+	  Philips or Velleman, Analog Devices evaluation boards, and more.
+	  Basically any adapter using the parallel port as an I2C bus with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a light version of i2c-parport.  It doesn't depend
+	  on the parport driver, and uses direct I/O access instead.  This
+	  might be preferred on embedded systems where wasting memory for
+	  the clean but heavy parport handling is not an option.  The
+	  drawback is a reduced portability and the impossibility to
+	  daisy-chain other parallel port devices.
+
+	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to
+	  both is possible but both modules should not be loaded at the same
+	  time.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-parport-light.
+
+config I2C_TAOS_EVM
+	tristate "TAOS evaluation module"
+	depends on EXPERIMENTAL
+	select SERIO
+	select SERIO_SERPORT
+	default n
+	help
+	  This supports TAOS evaluation modules on serial port. In order to
+	  use this driver, you will need the inputattach tool, which is part
+	  of the input-utils package.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-taos-evm.
+
+config I2C_TINY_USB
+	tristate "Tiny-USB adapter"
+	depends on USB
+	help
+	  If you say yes to this option, support will be included for the
+	  i2c-tiny-usb, a simple do-it-yourself USB to I2C interface. See
+	  http://www.harbaum.org/till/i2c_tiny_usb for hardware details.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-tiny-usb.
+
+comment "Other I2C/SMBus bus drivers"
+
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
 	depends on ARCH_AT91 && EXPERIMENTAL && BROKEN
@@ -160,31 +394,6 @@ config I2C_HYDRA
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-hydra.
 
-config I2C_I801
-	tristate "Intel 82801 (ICH)"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the Intel
-	  801 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset are supported:
-	    82801AA
-	    82801AB
-	    82801BA
-	    82801CA/CAM
-	    82801DB
-	    82801EB/ER (ICH5/ICH5R)
-	    6300ESB
-	    ICH6
-	    ICH7
-	    ESB2
-	    ICH8
-	    ICH9
-	    Tolapai
-	    ICH10
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-i801.
-
 config I2C_PXA
 	tristate "Intel PXA2XX I2C adapter (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ARCH_PXA
@@ -201,31 +410,6 @@ config I2C_PXA_SLAVE
 	  is necessary for systems where the PXA may be a target on the
 	  I2C bus.
 
-config I2C_PIIX4
-	tristate "Intel PIIX4 and compatible (ATI/Serverworks/Broadcom/SMSC)"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the Intel
-	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset are supported (note that Serverworks is part
-	  of Broadcom):
-	    Intel PIIX4
-	    Intel 440MX
-	    ATI IXP200
-	    ATI IXP300
-	    ATI IXP400
-	    ATI SB600
-	    ATI SB700
-	    ATI SB800
-	    Serverworks OSB4
-	    Serverworks CSB5
-	    Serverworks CSB6
-	    Serverworks HT-1000
-	    SMSC Victory66
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-piix4.
-
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on 4xx
@@ -284,29 +468,6 @@ config I2C_MPC
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
 
-config I2C_NFORCE2
-	tristate "Nvidia nForce2, nForce3 and nForce4"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the Nvidia
-	  nForce2, nForce3 and nForce4 families of mainboard I2C interfaces.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-nforce2.
-
-config I2C_NFORCE2_S4985
-	tristate "SMBus multiplexing on the Tyan S4985"
-	depends on I2C_NFORCE2 && EXPERIMENTAL
-	help
-	  Enabling this option will add specific SMBus support for the Tyan
-	  S4985 motherboard.  On this 4-CPU board, the SMBus is multiplexed
-	  over 4 different channels, where the various memory module EEPROMs
-	  live.  Saying yes here will give you access to these in addition
-	  to the trunk.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-nforce2-s4985.
-
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
 	depends on EXPERIMENTAL
@@ -328,53 +489,6 @@ config I2C_OMAP
 	  Like OMAP1510/1610/1710/5912 and OMAP242x.
 	  For details see http://www.ti.com/omap.
 
-config I2C_PARPORT
-	tristate "Parallel port adapter"
-	depends on PARPORT
-	select I2C_ALGOBIT
-	help
-	  This supports parallel port I2C adapters such as the ones made by
-	  Philips or Velleman, Analog Devices evaluation boards, and more.
-	  Basically any adapter using the parallel port as an I2C bus with
-	  no extra chipset is supported by this driver, or could be.
-
-	  This driver is a replacement for (and was inspired by) an older
-	  driver named i2c-philips-par.  The new driver supports more devices,
-	  and makes it easier to add support for new devices.
-
-	  An adapter type parameter is now mandatory.  Please read the file
-	  Documentation/i2c/busses/i2c-parport for details.
-
-	  Another driver exists, named i2c-parport-light, which doesn't depend
-	  on the parport driver.  This is meant for embedded systems. Don't say
-	  Y here if you intend to say Y or M there.
-
-	  This support is also available as a module.  If so, the module
-	  will be called i2c-parport.
-
-config I2C_PARPORT_LIGHT
-	tristate "Parallel port adapter (light)"
-	select I2C_ALGOBIT
-	help
-	  This supports parallel port I2C adapters such as the ones made by
-	  Philips or Velleman, Analog Devices evaluation boards, and more.
-	  Basically any adapter using the parallel port as an I2C bus with
-	  no extra chipset is supported by this driver, or could be.
-
-	  This driver is a light version of i2c-parport.  It doesn't depend
-	  on the parport driver, and uses direct I/O access instead.  This
-	  might be preferred on embedded systems where wasting memory for
-	  the clean but heavy parport handling is not an option.  The
-	  drawback is a reduced portability and the impossibility to
-	  daisy-chain other parallel port devices.
-
-	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to
-	  both is possible but both modules should not be loaded at the same
-	  time.
-
-	  This support is also available as a module.  If so, the module
-	  will be called i2c-parport-light.
-
 config I2C_PASEMI
 	tristate "PA Semi SMBus interface"
 	depends on PPC_PASEMI && PCI
@@ -449,60 +563,6 @@ config SCx200_ACB
 	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
 
-config I2C_SIS5595
-	tristate "SiS 5595"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the
-	  SiS5595 SMBus (a subset of I2C) interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-sis5595.
-
-config I2C_SIS630
-	tristate "SiS 630/730"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the
-	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-sis630.
-
-config I2C_SIS96X
-	tristate "SiS 96x"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the SiS
-	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
-	  chipsets are supported:
-	    645/961
-	    645DX/961
-	    645DX/962
-	    648/961
-	    650/961
-	    735
-	    745
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-sis96x.
-
-config I2C_TAOS_EVM
-	tristate "TAOS evaluation module"
-	depends on EXPERIMENTAL
-	select SERIO
-	select SERIO_SERPORT
-	default n
-	help
-	  This supports TAOS evaluation modules on serial port. In order to
-	  use this driver, you will need the inputattach tool, which is part
-	  of the input-utils package.
-
-	  If unsure, say N.
-
-	  This support is also available as a module.  If so, the module
-	  will be called i2c-taos-evm.
-
 config I2C_STUB
 	tristate "I2C/SMBus Test Stub"
 	depends on EXPERIMENTAL && m
@@ -516,17 +576,6 @@ config I2C_STUB
 
 	  If you don't know what to do here, definitely say N.
 
-config I2C_TINY_USB
-	tristate "I2C-Tiny-USB"
-	depends on USB
-	help
-	  If you say yes to this option, support will be included for the
-	  i2c-tiny-usb, a simple do-it-yourself USB to I2C interface. See
-	  http://www.harbaum.org/till/i2c_tiny_usb for hardware details.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-tiny-usb.
-
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
 	depends on ARCH_VERSATILE || ARCH_REALVIEW
@@ -548,47 +597,6 @@ config I2C_ACORN
 
 	  If you don't know, say Y.
 
-config I2C_VIA
-	tristate "VIA 82C586B"
-	depends on PCI && EXPERIMENTAL
-	select I2C_ALGOBIT
-	help
-	  If you say yes to this option, support will be included for the VIA
-          82C586B I2C interface
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-via.
-
-config I2C_VIAPRO
-	tristate "VIA VT82C596/82C686/82xx and CX700"
-	depends on PCI
-	help
-	  If you say yes to this option, support will be included for the VIA
-	  VT82C596 and later SMBus interface.  Specifically, the following
-	  chipsets are supported:
-	    VT82C596A/B
-	    VT82C686A/B
-	    VT8231
-	    VT8233/A
-	    VT8235
-	    VT8237R/A/S
-	    VT8251
-	    CX700
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-viapro.
-
-config I2C_VOODOO3
-	tristate "Voodoo 3"
-	depends on PCI
-	select I2C_ALGOBIT
-	help
-	  If you say yes to this option, support will be included for the
-	  Voodoo 3 I2C interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-voodoo3.
-
 config I2C_PCA_ISA
 	tristate "PCA9564 on an ISA bus"
 	depends on ISA


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
