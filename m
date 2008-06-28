From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Sat, 28 Jun 2008 10:58:50 +0200
Message-ID: <20080628105850.2c56f1a2@hyperion.delvare>
References: <20080627145236.2a20aaad@hyperion.delvare>
	<20080627134436.GC3931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627134436.GC3931-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 27 Jun 2008 15:44:36 +0200, Wolfram Sang wrote:
> On Fri, Jun 27, 2008 at 02:52:36PM +0200, Jean Delvare wrote:
> > As was mentioned previously, I have decided to group the i2c bus
> > drivers to make it easier for the users to know what they need (and also
> > for me to know what drivers might be affected by a given problem.) Here
> > is the list I have at the moment. There are still many drivers in the
> > "Other" category. I suspect that many of these should move to the
> > "Embedded" category, but I don't know for sure. So I would welcome
> > comments and suggestions for improvements.
> 
> From my first glimpse:
> 
> > 
> > # PC SMBus host controller drivers
> > obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
> > obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
> > obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
> > obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
> > obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
> > obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
> > obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
> > obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
> > obj-$(CONFIG_I2C_NFORCE2_S4985)	+= i2c-nforce2-s4985.o
> > obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
> > obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
> > obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
> > obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
> > obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
> > obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
> > 
> > # Mac SMBus host controller drivers
> > obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
> > obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
> > 
> > # Embebbed system I2C/SMBus host controller drivers
> > obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
> > obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
> > obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
> > obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
> > obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
> > obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
> > obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
> > obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
> > 
> > # External I2C/SMBus adapter drivers
> > obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
> > obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
> > obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
> > obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
> > 
> > # Graphics adapter I2C/DDC channel drivers
> > obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
> > 
> > # Other I2C/SMBus bus drivers
> > obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
> > obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
> > obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
> Embedded.

Done.

> > obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
> It is not SMBus, but still PC (ISA).

Does ISA imply PC? I don't think so. Also, this is a do-it-yourself
adapter for hobbyists if I remember correctly, not something you can
find in a regular PC. So having it in the "PC" group would be
confusing. If anything, I'd rather move it to the "External" group,
even though it doesn't fit there perfectly either.

> > obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
> Embedded.

Done.

> > obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
> > obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
> > obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
> > obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
> Embedded.

Done.

> > obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
> > obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
> > obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
> > obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
> It is not SMBus, but still PC (ISA).

Again, ISA doesn't imply PC. I seem to recall that this particular
driver was written by someone NOT on a PC. Note that this driver will
probably be deprecated someday anyway as the i2c-pca-platform is simply
better.

> > obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
> External means probably: Connected via some bus? This one is just memory
> mapped...

External means outside of the computer. In practice: connected to a
parallel port, serial port or USB port.

> > obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
> > obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
> > obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
> Embedded.

Done.

> > obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
> Embedded.

Done.

> > obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
> PC? Looking at MODULE_DESCRIPTION.

No, it's a MIPS thing. Probably embedded but I don't know for sure.

> > obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
> > obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
> > obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
> > obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> > 
> > (Of course, Kconfig has similar groups.)

Thanks for your contribution!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
