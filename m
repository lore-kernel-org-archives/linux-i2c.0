From: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Thu, 06 Dec 2012 16:14:20 -0700
Message-ID: <1354835660.25841.5776.camel@bebrown-nhm1.ch.intel.com>
References: <1346974378-4256-1-git-send-email-bill.e.brown@intel.com>
	 <20120930224505.094496e3@endymion.delvare>
	 <9F9F993390252A42882D73CFAFE276A517A143EF@FMSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9F9F993390252A42882D73CFAFE276A517A143EF-AtyAts71sc9cIJlls4ac1rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> On Tue, 2012-12-04 at 16:23 -0700, Brown, Bill E wrote:
> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
> Sent: Sunday, September 30, 2012 1:45 PM
> To: Brown, Bill E
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v2] i2c: Adding support for Intel iSMT SMBus 2.0 host controller
> 
> Hi Bill,
> 
> On Thu,  6 Sep 2012 16:32:58 -0700, Bill Brown wrote:
> > The iSMT (Intel SMBus Message Transport) supports multi-master 
> > I2C/SMBus, as well as IPMI.  It's operation is DMA-based and utilizes 
> > descriptors to initiate transactions on the bus.
> > 
> > The iSMT hardware can act as both a master and a target, although this 
> > driver only supports being a master.
> > 
> > Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig    |   10 +
> >  drivers/i2c/busses/Makefile   |    1 +
> >  drivers/i2c/busses/i2c-ismt.c |  845 
> > +++++++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/busses/i2c-ismt.h |  111 ++++++
> >  4 files changed, 967 insertions(+), 0 deletions(-)  create mode 
> > 100644 drivers/i2c/busses/i2c-ismt.c  create mode 100644 
> > drivers/i2c/busses/i2c-ismt.h
> 
> Here's my review, sorry for the delay. The driver looks overall good and most of my comments are suggestions for improvements, either for code readability or performance. For these it's up to you if you want to follow my advice or not.
> 
> There are a few real bugs too though, which you will _have_ to fix. If you're quick we can be in time for kernel 3.7.
> 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig 
> > index 7244c8b..64d5756 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -119,6 +119,16 @@ config I2C_ISCH
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called i2c-isch.
> >  
> > +config I2C_ISMT
> > +	tristate "Intel iSMT SMBus Controller"
> > +	depends on PCI
> > +	help
> > +	  If you say yes to this option, support will be included for the Intel
> > +	  iSMT SMBus host controller interface.
> > +
> > +	  This driver can also be built as a module.  If so, the module will be
> > +	  called i2c-ismt.
> > +
> >  config I2C_PIIX4
> >  	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
> >  	depends on PCI
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile 
> > index ce3c2be..694711a 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -22,6 +22,7 @@ obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
> >  obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
> >  obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
> >  obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
> > +obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
> 
> In alphabetical order please.

done

> 
> >  
> >  # Mac SMBus host controller drivers
> >  obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
> > diff --git a/drivers/i2c/busses/i2c-ismt.c 
> > b/drivers/i2c/busses/i2c-ismt.c new file mode 100644 index 
> > 0000000..46df042
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-ismt.c
> > @@ -0,0 +1,845 @@
> > +/*
> > + * This file is provided under a dual BSD/GPLv2 license.  When using 
> > +or
> > + * redistributing this file, you may do so under either license.
> > + *
> > + * GPL LICENSE SUMMARY
> > + *
> > + * Copyright(c) 2012 Intel Corporation. All rights reserved.
> 
> Copyright is independent from licensing, so please move the copyright statement outside of the license blocks. This will avoid duplicating the copyright statement.
> 

done

> > + *
> > + * This program is free software; you can redistribute it and/or 
> > + modify
> > + * it under the terms of version 2 of the GNU General Public License 
> > + as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, 
> > + but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> > + * The full GNU General Public License is included in this 
> > + distribution
> > + * in the file called LICENSE.GPL.
> > + *
> > + * BSD LICENSE
> > + *
> > + * Copyright(c) 2012 Intel Corporation. All rights reserved.
> > + * All rights reserved.
> 
> Very reserved it seems ;)

Not by my choice...  :)

> 
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + *
> > + *   * Redistributions of source code must retain the above copyright
> > + *     notice, this list of conditions and the following disclaimer.
> > + *   * Redistributions in binary form must reproduce the above copyright
> > + *     notice, this list of conditions and the following disclaimer in
> > + *     the documentation and/or other materials provided with the
> > + *     distribution.
> > + *   * Neither the name of Intel Corporation nor the names of its
> > + *     contributors may be used to endorse or promote products derived
> > + *     from this software without specific prior written permission.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
> > + CONTRIBUTORS
> > + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
> > + FOR
> > + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
> > + COPYRIGHT
> > + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
> > + INCIDENTAL,
> > + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF 
> > + USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON 
> > + ANY
> > + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
> > + TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
> > + USE
> > + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> > +/*
> > +  Supports the SMBus Message Transport (SMT) on the following Intel SOCs:
> 
> Please use standard comment style for consistency (as above.)

done

> 
> > +  BWD
> > +  CTN
> 
> Very cryptic names. Can you use something more user-friendly?

done

> 
> > +
> > +  Features supported by this driver:
> > +  Software PEC                     no
> 
> Does the hardware support this at all? If not, there's no point in mentioning it.

The hardware supports it, so I there's no real reason to mention this.  

> 
> > +  Hardware PEC                     yes
> > +  Block buffer                     yes
> > +  Block process call transaction   no
> 
> Same question here.

The SOC supports it, but the driver doesn't.

> 
> > +  Slave mode                       no
> > +*/
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/pci.h>
> > +#include <linux/kernel.h>
> > +#include <linux/stddef.h>
> > +#include <linux/delay.h>
> 
> It doesn't look like you need this one. OTOH you need <linux/completion.h>, which is missing. Including <linux/dma-mapping.h> would probably be a good idea too.

done

> 
> > +#include <linux/i2c.h>
> > +#include <linux/acpi.h>
> > +#include <linux/interrupt.h>
> > +#include "i2c-ismt.h"
> > +
> > +/**
> > + * DEFINE_PCI_DEVICE_TABLE - PCI device IDs supported by this driver
> 
> You're describing ismt_ids not DEFINE_PCI_DEVICE_TABLE.

Oops, fixed.  :)

> 
> > + */
> > +static const DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BWD_SMBUS_SMT0) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BWD_SMBUS_SMT1) },
> > +	{ 0, }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(pci, ismt_ids);
> > +
> > +/* Master Descriptor control bits */
> > +static unsigned int stop_on_error = 1; module_param(stop_on_error, 
> > +uint, S_IRUGO); MODULE_PARM_DESC(stop_on_error, "Stop on Error");
> 
> I'd write "error" with no leading capital, for consistency.
> 
> > +
> > +static unsigned int fair = 1;
> > +module_param(fair, uint, S_IRUGO);
> > +MODULE_PARM_DESC(fair, "Enable fairness on the SMBus");
> 
> It would make sense to make these parameters writable by root in sysfs, so that the settings can be changed at run-time.
> 
> You could also make these bools rather than uints, I think this gets you stricter input validation, and maybe some optimizations too.
> 
> Both options would be good to document in Documentation/i2c/busses/i2c-ismt, as their effect isn't obvious. See
> i2c-i801 in this directory for the formatting. You don't have to be extra verbose if you don't have the time, just write the information that you think is useful for other users and developers.

I removed both parameters as they weren't really needed.  I added a new
one though for changing the bus frequency and documented it as you
suggested.  Refer to the #ifdef DEBUG_SLOW_HW comment you made below.

> 
> > +
> > +#ifdef DEBUG
> > +/**
> > + * ismt_desc_dump() - dump the contents of a descriptor for debug 
> > +purposes
> > + * @adap: the I2C host adapter
> > + */
> > +static void ismt_desc_dump(struct i2c_adapter *adap) {
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> 
> In this function and the 2 other debug functions below, you don't need adap, so you better pass priv as the function parameter.

done

> 
> > +	struct device *dev = &priv->pci_dev->dev;
> > +	struct ismt_desc *desc = &priv->hw[priv->head];
> > +
> > +	dev_dbg(dev, "Dump of the descriptor struct:  0x%X\n", priv->head);
> > +	dev_dbg(dev, "\ttgtaddr_rw=0x%02X\n", desc->tgtaddr_rw);
> > +	dev_dbg(dev, "\twr_len_cmd=0x%02X\n", desc->wr_len_cmd);
> > +	dev_dbg(dev, "\trd_len=    0x%02X\n", desc->rd_len);
> > +	dev_dbg(dev, "\tcontrol=   0x%02X\n", desc->control);
> > +	dev_dbg(dev, "\tstatus=    0x%02X\n", desc->status);
> > +	dev_dbg(dev, "\tretry=     0x%02X\n", desc->retry);
> > +	dev_dbg(dev, "\trxbytes=   0x%02X\n", desc->rxbytes);
> > +	dev_dbg(dev, "\ttxbytes=   0x%02X\n", desc->txbytes);
> > +	dev_dbg(dev, "\tdptr_low=  0x%08X\n", desc->dptr_low);
> > +	dev_dbg(dev, "\tdptr_high= 0x%08X\n", desc->dptr_high); }
> > +
> > +/**
> > + * ismt_gen_reg_dump() - dump the iSMT General Registers
> > + * @adap: the I2C host adapter
> > + */
> > +static void ismt_gen_reg_dump(struct i2c_adapter *adap) {
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> > +	struct device *dev = &priv->pci_dev->dev;
> > +
> > +	dev_dbg(dev, "Dump of the iSMT General Registers\n");
> > +	dev_dbg(dev, "  GCTRL.... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_GR_GCTRL,
> > +		readl(priv->smba + ISMT_GR_GCTRL));
> > +	dev_dbg(dev, "  SMTICL... : (0x%p)=0x%016lX\n",
> > +		priv->smba + ISMT_GR_SMTICL,
> > +		readq(priv->smba + ISMT_GR_SMTICL));
> > +	dev_dbg(dev, "  ERRINTMSK : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_GR_ERRINTMSK,
> > +		readl(priv->smba + ISMT_GR_ERRINTMSK));
> > +	dev_dbg(dev, "  ERRAERMSK : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_GR_ERRAERMSK,
> > +		readl(priv->smba + ISMT_GR_ERRAERMSK));
> > +	dev_dbg(dev, "  ERRSTS... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_GR_ERRSTS,
> > +		readl(priv->smba + ISMT_GR_ERRSTS));
> > +	dev_dbg(dev, "  ERRINFO.. : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_GR_ERRINFO,
> > +		readl(priv->smba + ISMT_GR_ERRINFO)); }
> > +
> > +/**
> > + * ismt_mstr_reg_dump() - dump the iSMT Master Registers
> > + * @adap: the I2C host adapter
> > + */
> > +static void ismt_mstr_reg_dump(struct i2c_adapter *adap) {
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> > +	struct device *dev = &priv->pci_dev->dev;
> > +
> > +	dev_dbg(dev, "Dump of the iSMT Master Registers\n");
> > +	dev_dbg(dev, "  MDBA..... : (0x%p)=0x%016lX\n",
> > +		priv->smba + ISMT_MSTR_MDBA,
> > +		readq(priv->smba + ISMT_MSTR_MDBA));
> > +	dev_dbg(dev, "  MCTRL.... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_MSTR_MCTRL,
> > +		readl(priv->smba + ISMT_MSTR_MCTRL));
> > +	dev_dbg(dev, "  MSTS..... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_MSTR_MSTS,
> > +		readl(priv->smba + ISMT_MSTR_MSTS));
> > +	dev_dbg(dev, "  MDS...... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_MSTR_MDS,
> > +		readl(priv->smba + ISMT_MSTR_MDS));
> > +	dev_dbg(dev, "  RPOLICY.. : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_MSTR_RPOLICY,
> > +		readl(priv->smba + ISMT_MSTR_RPOLICY));
> > +	dev_dbg(dev, "  SPGT..... : (0x%p)=0x%X\n",
> > +		priv->smba + ISMT_SPGT,
> > +		readl(priv->smba + ISMT_SPGT));
> > +}
> > +
> > +#else
> > +static void ismt_desc_dump(struct i2c_adapter *adap) {} static void 
> > +ismt_gen_reg_dump(struct i2c_adapter *adap) {} static void 
> > +ismt_mstr_reg_dump(struct i2c_adapter *adap) {} #endif
> 
> This prevents using the dynamic debug feature. The 3 debug functions do nothing by default if DEBUG isn't set, so I think they should depend on
> defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG). That way they can be included but disabled by default under DYNAMIC_DEBUG, and you can enable specific debugging messages at run-time. Same is done in net/netfilter/nf_conntrack_pptp.c for example.

Good idea, done.

> 
> > +
> > +/**
> > + * ismt_insert_cmd() -  stuff a command into the head of the data 
> > +buffer
> 
> Extra space after dash.

fixed

> 
> > + * @data: data buffer
> > + * @command: command to insert
> > + */
> > +static void ismt_insert_cmd(union i2c_smbus_data *data, u8 command) {
> > +	memmove(&data->block[1], &data->block[0], I2C_SMBUS_BLOCK_MAX);
> > +	data->block[0] = command;
> 
> Ouch, no, you can't do that, sorry. This union is not under your full control. The caller must be able to re-use the same union with no change to issue the same SMBus transaction. As a matter of fact,
> i2c-core.c:i2c_smbus_xfer() will do exactly this if it detects arbitration loss.
> 
> Obviously if you modify the contents like that, it will break. So, to put it short: if you need buffers for your own use, allocate them as part of your private data structure.
> 

Ouch is right, I didn't know that. I fixed it by creating a temp buffer.

> 
> As a side note, it may be faster anyway. The memmove() above had to move 32 bytes one by one because the areas overlap, that was certainly slow.
> 
> Also note that you're only supposed to access data->block for block transactions. For other transactions it's ->byte or ->word. You probably don't care much about endianness in this specific driver, but if you had to, the above would inevitably fail for word transactions on either endianness.

Noted.  I don't have to worry about it here since this is x86 only.

> 
> > +}
> > +
> > +/**
> > + * ismt_submit_desc() - add a descriptor to the ring
> > + * @adap: the i2c host adapter
> > + */
> > +static void ismt_submit_desc(struct i2c_adapter *adap) {
> > +	int fmhp;
> > +	int val;
> 
> These should be unsigned, as you use them for readl()/writel().

fixed

> 
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> > +
> > +	ismt_desc_dump(adap);
> > +	ismt_gen_reg_dump(adap);
> > +	ismt_mstr_reg_dump(adap);
> 
> I fail to see the rationale for putting these debug calls here. In this function you don't need adap, so by moving the debug calls back to ismt_access(), you could pass priv directly as a parameter and save a few bytes.

I used this during debug to verify that the descriptor and the
controller are correct before I start a transaction (it came in quite
handy for me :) ).

Switched to passing priv as the parameter per your suggestion.

> 
> > +
> > +	/* Set the FMHP (Firmware Master Head Pointer)*/
> > +	fmhp = ((priv->head + 1) % ISMT_DESC_ENTRIES) << 16;
> > +	val = readl(priv->smba + ISMT_MSTR_MCTRL);
> > +	writel((val & ~(ISMT_MCTRL_FMHP)) | fmhp,
> > +		(priv->smba + ISMT_MSTR_MCTRL));
> 
> Alignment is off by one, and parentheses around (ISMT_MCTRL_FMHP) and (priv->smba + ISMT_MSTR_MCTRL) aren't needed.

fixed

> 
> > +
> > +	/* Set the start bit */
> > +	val = readl(priv->smba + ISMT_MSTR_MCTRL);
> > +	writel((val | ISMT_MCTRL_SS),
> > +	       (priv->smba + ISMT_MSTR_MCTRL));
> 
> Many unneeded parentheses here too.

fixed

> 
> > +}
> > +
> > +/**
> > + * ismt_process_desc() - handle the completion of the descriptor
> > + * @adap: the i2c host adapter
> > + */
> > +static int ismt_process_desc(struct i2c_adapter *adap) {
> > +	struct ismt_desc *desc;
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> 
> All you really need in this function is desc, and you have it at hand on the calling side. So just pass "desc" as the function parameter.
> This saves 32 binary bytes on x86_64. You can even make desc const as the function doesn't modify it.

done and done

> 
> > +
> > +	desc = &priv->hw[priv->head];
> > +
> > +	if (desc->status & ISMT_DESC_SCS)
> > +		return 0;
> 
> We can probably assume that this is the most frequent case, and use
> likely() to help gcc optimize the most frequent path.

I just learned something new, done.  :)

> 
> > +
> > +	if ((desc->status & ISMT_DESC_NAK) || (desc->status & ISMT_DESC_CRC))
> > +		return -ENXIO;
> 
> According to Documentation/i2c/fault-codes, CRC (PEC) errors are to be reported with -EBADMSG.

fixed

> 
> NAK is probably the second most likely case, as it happens on device probing, so again likely() may be good to use.

done

> 
> > +
> > +	if (desc->status & ISMT_DESC_COL)
> > +		return -EAGAIN;
> > +
> > +	return 0;
> 
> Can it really be a success if ISMT_DESC_SCS wasn't set? I doubt it.

Ugh, nice catch.  Fixed and added some other failure cases.

> 
> > +}
> > +
> > +/**
> > + * ismt_access() - process an SMBus command
> > + * @adap: the i2c host adapter
> > + * @addr: address of the i2c/SMBus target
> > + * @flags: command options
> > + * @read_write: read from or write to device
> > + * @command: the i2c/SMBus command to issue
> > + * @size: SMBus transaction type
> > + * @data: read/write data buffer
> > + */
> > +static int ismt_access(struct i2c_adapter *adap, u16 addr,
> > +		       unsigned short flags, char read_write, u8 command,
> > +		       int size, union i2c_smbus_data *data) {
> > +	unsigned int ret = 0; /* return code */
> 
> You won't catch (negative!) error codes with an unsigned int.

fixed

> 
> The comment /* return code */ is pretty redundant, BTW, it's quite clear what this variable is for. And initialization isn't needed either.

I get a little verbose sometimes...fixed.  :)

> 
> > +	dma_addr_t dma_addr = 0; /* address of the data buffer */
> > +	u8 dma_size = 0;
> > +	enum dma_data_direction dma_direction = 0;
> > +	bool map_dma_flag = 0;
> 
> Could you do without this flag? AFAICS map_dma_flag always evaluates to the same as dma_size != 0.

I looked at it, and you are right.  I removed the flag and modified
accordingly.

> 
> > +	struct ismt_desc *desc;
> > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> 
> I'd suggest that you also declare:
> 	struct device *dev = &priv->pci_dev->dev; and use it in all debug and error messages, this will make the code much more readable!

That is much better, done.

> 
> > +
> > +	desc = &priv->hw[priv->head];
> > +
> > +	/* Initialize the descriptor */
> > +	memset(desc, 0, sizeof(struct ismt_desc));
> > +	desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, read_write);
> > +
> > +	/* Initialize common control bits */
> > +	desc->control |= ISMT_DESC_INT;
> 
> You just zeroed this field with memset(), so "=" will do the same as "|=", and is probably more efficient.

done

> 
> > +
> > +	if (stop_on_error)
> > +		desc->control |= ISMT_DESC_SOE;
> > +
> > +	if ((flags & I2C_CLIENT_PEC) && (size != I2C_SMBUS_QUICK)
> > +		&& (size != I2C_SMBUS_I2C_BLOCK_DATA))
> 
> Please align the && on opening parenthesis to avoid confusion between the condition and the action.

done

> 
> > +		desc->control |= ISMT_DESC_PEC;
> > +
> > +	if (fair)
> > +		desc->control |= ISMT_DESC_FAIR;
> > +
> > +	switch (size) {
> > +	case I2C_SMBUS_QUICK:
> > +		dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_QUICK\n");
> > +		break;
> > +
> > +	case I2C_SMBUS_BYTE:
> > +		if (read_write == I2C_SMBUS_WRITE) {
> > +			/*
> > +			 * Send Byte
> > +			 * The command field contains the write data
> > +			 */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BYTE:  WRITE\n");
> > +			desc->control |= ISMT_DESC_CWRL;
> > +			desc->wr_len_cmd = command;
> > +		} else {
> > +			/* Receive Byte */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BYTE:  READ\n");
> > +			dma_size = 1;
> > +			dma_direction = DMA_FROM_DEVICE;
> > +			map_dma_flag = 1;
> > +			desc->rd_len = 1;
> > +		}
> > +
> > +		break;
> > +
> > +	case I2C_SMBUS_BYTE_DATA:
> > +		if (read_write == I2C_SMBUS_WRITE) {
> > +			/*
> > +			 * Write Byte
> > +			 * Command plus 1 data byte
> > +			 */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BYTE_DATA:  WRITE\n");
> > +			desc->wr_len_cmd = 2;
> > +
> > +			/* Stuff the command ahead of the data in the buffer */
> > +			ismt_insert_cmd(data, command);
> > +			dma_size = 2;
> > +			dma_direction = DMA_TO_DEVICE;
> > +		} else {
> > +			/* Read Byte */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
> > +			desc->control |= ISMT_DESC_CWRL;
> > +			desc->wr_len_cmd = command;
> > +			desc->rd_len = 1;
> > +			dma_size = 1;
> > +			dma_direction = DMA_FROM_DEVICE;
> > +		}
> > +
> > +		map_dma_flag = 1;
> > +		break;
> > +
> > +	case I2C_SMBUS_WORD_DATA:
> > +		if (read_write == I2C_SMBUS_WRITE) {
> > +			/* Write Word */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_WORD_DATA:  WRITE\n");
> > +			desc->wr_len_cmd = 3;
> > +
> > +			/* Stuff the command ahead of the data in the buffer */
> > +			ismt_insert_cmd(data, command);
> > +			dma_size = 3;
> > +			dma_direction = DMA_TO_DEVICE;
> > +		} else {
> > +			/* Read Word */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_WORD_DATA:  READ\n");
> > +			desc->wr_len_cmd = command;
> > +			desc->control |= ISMT_DESC_CWRL;
> > +			desc->rd_len = 2;
> > +			dma_size = 2;
> > +			dma_direction = DMA_FROM_DEVICE;
> > +		}
> > +
> > +		map_dma_flag = 1;
> > +		break;
> > +
> > +	case I2C_SMBUS_PROC_CALL:
> > +		dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_PROC_CALL\n");
> > +		desc->wr_len_cmd = 3;
> > +		desc->rd_len = 2;
> > +
> > +		/* Stuff the command ahead of the data in the buffer */
> > +		ismt_insert_cmd(data, command);
> > +		dma_size = 3;
> > +		dma_direction = DMA_BIDIRECTIONAL;
> > +		map_dma_flag = 1;
> > +		break;
> > +
> > +	case I2C_SMBUS_BLOCK_DATA:
> > +		if (read_write == I2C_SMBUS_WRITE) {
> > +			/* Block Write */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BLOCK_DATA:  WRITE\n");
> > +			dma_size = data->block[0] + 1;
> > +			dma_direction = DMA_TO_DEVICE;
> > +			desc->wr_len_cmd = dma_size;
> > +			desc->control |= ISMT_DESC_BLK;
> > +			ismt_insert_cmd(data, command);
> > +		} else {
> > +			/* Block Read */
> > +			dev_dbg(&priv->pci_dev->dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> > +			dma_size = data->block[0] + 1;
> 
> Probably not. For SMBus block reads, the block length is _received_ from the slave, so at this point you don't know it. So you probably have to map the maximum (I2C_SMBUS_BLOCK_MAX == 32 bytes) always.

Yep, fixed.

> 
> > +			dma_direction = DMA_FROM_DEVICE;
> > +			desc->rd_len = dma_size;
> > +			desc->wr_len_cmd = command;
> > +			desc->control |= (ISMT_DESC_BLK | ISMT_DESC_CWRL);
> > +		}
> > +
> > +		map_dma_flag = 1;
> > +		break;
> > +
> > +	default:
> > +		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n",
> > +			size);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* map the data buffer */
> > +	if (map_dma_flag) {
> > +		dev_dbg(&priv->pci_dev->dev,
> > +			" &priv->pci_dev->dev=%p\n", &priv->pci_dev->dev);
> > +		dev_dbg(&priv->pci_dev->dev, " data=%p\n", data);
> > +		dev_dbg(&priv->pci_dev->dev, " dma_size=%d\n", dma_size);
> > +		dev_dbg(&priv->pci_dev->dev,
> > +			" dma_direction=%d\n", dma_direction);
> > +
> > +		dma_addr = dma_map_single(&priv->pci_dev->dev,
> > +				      data,
> > +				      dma_size,
> > +				      dma_direction);
> > +
> > +		dev_dbg(&priv->pci_dev->dev, " dma_addr = 0x%016llX\n",
> > +			dma_addr);
> > +
> > +		desc->dptr_low = lower_32_bits(dma_addr);
> > +		desc->dptr_high = upper_32_bits(dma_addr);
> > +	}
> > +
> > +	INIT_COMPLETION(priv->cmp);
> > +
> > +	/* Add the descriptor */
> > +	ismt_submit_desc(adap);
> > +
> > +	/* Now we wait for interrupt completion, 1s */
> > +	ret = wait_for_completion_interruptible_timeout(&priv->cmp, HZ*1);
> > +
> > +	/* unmap the data buffer */
> > +	if (map_dma_flag)
> > +		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> > +
> > +	if (ret < 0) {
> > +		dev_err(&priv->pci_dev->dev, "completion wait interrupted\n");
> > +		ret = -EIO;
> > +	} else if (ret == 0) {
> > +		dev_err(&priv->pci_dev->dev, "completion wait timed out\n");
> > +		ret = -ETIMEDOUT;
> 
> Both are unlikely and you could help the compiler optimize the most common case.

done

> 
> > +	} else
> > +		/* do any post processing of the descriptor here */
> > +		ret = ismt_process_desc(adap);
> > +
> > +	/* Update the ring pointer */
> > +	priv->head++;
> > +	priv->head %= ISMT_DESC_ENTRIES;
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * ismt_func() - report which i2c commands are supported by this 
> > +adapter
> > + * @adap: the i2c host adapter
> > + */
> > +static u32 ismt_func(struct i2c_adapter *adap) {
> > +	return  I2C_FUNC_SMBUS_QUICK           |
> > +		I2C_FUNC_SMBUS_BYTE            |
> > +		I2C_FUNC_SMBUS_BYTE_DATA       |
> > +		I2C_FUNC_SMBUS_WORD_DATA       |
> > +		I2C_FUNC_SMBUS_PROC_CALL       |
> > +		I2C_FUNC_SMBUS_BLOCK_DATA      |
> > +		I2C_FUNC_SMBUS_PEC;
> 
> Unusual spacing... There should be a single space between return and I2C_FUNC_SMBUS_QUICK, and if you really want to align the "|"s that should be done with tabs, not spaces.

done

> 
> > +}
> > +
> > +/**
> > + * struct i2c_algorithm - the adapter algorithm and supported 
> > +functionality
> 
> Your structure is actually named smbus_algorithm. Anyway this syntax is meant to describe structures as you define them, not as you instantiate them. I think you have to omit the "struct" here.

done

> 
> > + * @smbus_xfer: the adapter algorithm
> > + * @functionality: functionality supported by the adapter  */ static 
> > +const struct i2c_algorithm smbus_algorithm = {
> > +	.smbus_xfer	= ismt_access,
> > +	.functionality	= ismt_func,
> > +};
> > +
> > +/**
> > + * ismt_handle_isr() - interrupt handler bottom half
> > + * @priv: iSMT private data
> > + */
> > +static irqreturn_t ismt_handle_isr(struct ismt_priv *priv) {
> > +	complete(&priv->cmp);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +
> > +/**
> > + * ismt_do_interrupt() - IRQ interrupt handler
> > + * @vec: interrupt vector
> > + * @data:  iSMT private data
> 
> Extra space after colon.

fixed

> 
> > + */
> > +static irqreturn_t ismt_do_interrupt(int vec, void *data) {
> > +	u32 val;
> > +	struct ismt_priv *priv = (struct ismt_priv *)data;
> 
> You never need to explicitly cast a void * pointer.

fixed

> 
> > +
> > +	/*
> > +	 * check to see it's our interrupt, return IRQ_NONE if not ours
> > +	 * since we are sharing interrupt
> > +	 */
> > +	val = readl(priv->smba + ISMT_MSTR_MSTS);
> > +
> > +	if (!(val & (ISMT_MSTS_MIS | ISMT_MSTS_MEIS)))
> > +		return IRQ_NONE;
> > +
> > +	if (val & ISMT_MSTS_MIS) {
> > +		/* completed successfully */
> > +		writel((val | ISMT_MSTS_MIS), priv->smba + ISMT_MSTR_MSTS);
> 
> Parentheses not needed. Plus I doubt this is what you want to do... if (val & ISMT_MSTS_MIS) then (val | ISMT_MSTS_MIS) == val. Maybe you really meant "&" instead of "|"?
> 
> 

Nice find, thanks!

> Could it be that this code was never tested because MSI interrupts were always available? Please inject a pci_enable_msi error in
> ismt_int_init() to test this code path.
> 

fixed and tested out okay with legacy ints.

> > +	} else {
> > +		/* completed with errors */
> > +		writel((val | ISMT_MSTS_MEIS), priv->smba + ISMT_MSTR_MSTS);
> 
> Same here.

done

> 
> Furthermore, I would like to see the conditional go. I'm sure you can do without it, and this will speed up the code. Isn't it OK to write back both ISMT_MSTS_MIS and ISMT_MSTS_MEIS unconditionally? This would simplify the code a lot. If this isn't OK, then you can still remember which flag was set and write only that flag back, with:
> 
> 	val = readl(priv->smba + ISMT_MSTR_MSTS) &
> 	      (ISMT_MSTS_MIS | ISMT_MSTS_MEIS);
> 
> 	if (!val)
> 		return IRQ_NONE;
> 
> 	writel(val, priv->smba + ISMT_MSTR_MSTS);
> 
> This too simplifies the code a lot (-27 binary bytes on x86_64) which is good to keep the latency low.
> 
> I was also wondering if it was possible that both flags were set at the same time? My code would deal with this case properly, yours did not.

I rewrote it pretty much the way you described, with the exception that
there are other bits that I don't want changed.

> 
> > +	}
> > +
> > +	return ismt_handle_isr(priv);
> > +}
> > +
> > +/**
> > + * ismt_do_msi_interrupt() - MSI interrupt handler
> > + * @vec: interrupt vector
> > + * @data:  iSMT private data
> 
> Extra space after colon.

fixed

> 
> > + */
> > +static irqreturn_t ismt_do_msi_interrupt(int vec, void *data) {
> > +	struct ismt_priv *priv = (struct ismt_priv *)data;
> 
> Here again the cast isn't needed. In fact you can pass data to
> ismt_handle_isr() directly, so you don't even need to introduce priv.

done

> 
> > +
> > +	return ismt_handle_isr(priv);
> > +}
> > +
> > +/**
> > + * ismt_hw_init() - initialize the iSMT hardware
> > + * @pdev: PCI-Express device
> > + */
> > +static void __devinit ismt_hw_init(struct pci_dev *pdev) {
> > +	u32 val;
> > +	struct ismt_priv *priv = pci_get_drvdata(pdev);
> > +
> > +	/* initialize the Master Descriptor Base Address (MDBA) */
> > +	writeq(priv->io_rng_dma, priv->smba + ISMT_MSTR_MDBA);
> 
> writeq() doesn't exist on 32-bit architectures, causing a build failure.
> 
> If this driver has to work on 32-bit systems, you'll have to come up with a workaround. If not, I suggest we make it depend on CONFIG_X86_64. I doubt this driver is of any use besides X86 anyway, right?

Yep, x86 only.
fixed

> 
> > +
> > +	/* initialize the Master Control Register (MCTRL) */
> > +	writel(ISMT_MCTRL_MEIE, priv->smba + ISMT_MSTR_MCTRL);
> > +
> > +	/* initialize the Master Status Register (MSTS) */
> > +	writel(0, priv->smba + ISMT_MSTR_MSTS);
> > +
> > +	/* initialize the Master Descriptor Size (MDS) */
> > +	val = readl(priv->smba + ISMT_MSTR_MDS);
> > +	writel((val & ~(ISMT_MDS_MDS)) | (ISMT_DESC_ENTRIES - 1),
> 
> Parentheses around ISMT_MDS_MDS aren't needed.

done

> 
> > +		priv->smba + ISMT_MSTR_MDS);
> > +
> > +#ifdef DEBUG_SLOW_HW
> > +	/*
> > +	 * initialize the SMBus speed to 80KHz for slow HW debuggers
> > +	 */
> > +	dev_dbg(&pdev->dev, " Setting SMBus clock to 80KHz\n");
> > +	val = readl(priv->smba + ISMT_SPGT);
> > +	writel(((val & ~(ISMT_SPGT_SPD)) | ISMT_SPGT_SPD_80K),
> 
> Same here. But I don't think we want to keep this in the upstream driver, at least not in this form. If it's still useful it should be controlled by a module parameter, not a hidden define.

I made this a module parameter and documented it
in /Documentation/i2c/busses/i2c-ismt

> 
> > +	       priv->smba + ISMT_SPGT);
> > +#endif
> > +
> > +	dev_dbg(&pdev->dev, " priv->smba=%p\n", priv->smba);
> 
> This would rather belong to the ismt_probe function IMHO. If needed at all...

It was extraneous, so I removed it.

> 
> > +}
> > +
> > +/**
> > + * ismt_init() - initialize the iSMT data structures
> > + * @pdev: PCI-Express Device
> > + */
> > +static int __devinit ismt_init(struct pci_dev *pdev)
> 
> This name is a little confusing with i2c_ismt_init later in the driver.
> What about ismt_dev_init?

changed

> 
> > +{
> > +	struct ismt_priv *priv = pci_get_drvdata(pdev);
> > +
> > +	priv->entries = ISMT_DESC_ENTRIES;
> > +
> > +	/* allocate memory for the descriptor */
> > +	priv->hw = dmam_alloc_coherent(&pdev->dev,
> > +				       (ISMT_DESC_ENTRIES
> > +					       * sizeof(struct ismt_desc)),
> > +				       &priv->io_rng_dma,
> > +				       GFP_KERNEL);
> > +	if (!priv->hw)
> > +		return -ENOMEM;
> > +
> > +	memset(priv->hw, 0, (ISMT_DESC_ENTRIES * sizeof(struct ismt_desc)));
> > +
> > +	priv->head = 0;
> > +	priv->tail = 0;
> > +	init_completion(&priv->cmp);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * ismt_int_init() - initialize interrupts
> > + * @pdev: PCI-Express device
> > + * @priv: iSMT private data
> > + */
> > +static int __devinit ismt_int_init(struct pci_dev *pdev, struct 
> > +ismt_priv *priv)
> 
> That's not consistent with the two previous functions where you derive priv from pdev. Please do the same in all 3 functions. Given that gcc is very likely to inline the functions, I suggest passing the priv parameter always, as this is simplified at inlining time.

done

> 
> > +{
> > +	int err;
> > +
> > +	/* Try using MSI interrupts */
> > +	err = pci_enable_msi(pdev);
> > +	if (err)
> 
> Maybe a warning message would be good to have, indicating that we're falling back to legacy interrupts? Or is it supposed to happen on many systems?

Good idea, done.

> 
> > +		goto intx;
> > +
> > +	err = devm_request_irq(&pdev->dev,
> > +			       pdev->irq,
> > +			       ismt_do_msi_interrupt,
> > +			       0,
> > +			       "ismt-msi",
> > +			       priv);
> > +
> > +	if (err) {
> > +		pci_disable_msi(pdev);
> > +		goto intx;
> > +	}
> > +
> > +	goto done;
> > +
> > +	/* Try using legacy interrupts */
> > +intx:
> 
> Out of curiosity, what's the "x" for?

For whatever reason, the docs refer to legacy interrupts as "INTx" :)

> 
> > +	err = devm_request_irq(&pdev->dev,
> > +			       pdev->irq,
> > +			       ismt_do_interrupt,
> > +			       IRQF_SHARED,
> > +			       "ismt-intx",
> > +			       priv);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "no usable interrupts\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +done:
> > +	return 0;
> > +}
> > +
> > +static struct pci_driver ismt_driver;
> > +
> > +/**
> > + * ismt_probe() - probe for iSMT devices
> > + * @pdev: PCI-Express device
> > + * @id: PCI-Express device ID
> > + */
> > +static int __devinit
> > +ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id) {
> > +	int err;
> > +	struct ismt_priv *priv;
> > +	unsigned long start, len;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	pci_set_drvdata(pdev, priv);
> > +	i2c_set_adapdata(&priv->adapter, priv);
> > +	priv->adapter.owner = THIS_MODULE;
> > +
> > +	priv->adapter.class = I2C_CLASS_HWMON;
> 
> Can't there be SPD EEPROMs on this bus?

Unfortunately, not on these controllers.  Memory isn't available for the
descriptors during memory initialization in BIOS, so this controller
cannot be used.

> 
> > +
> > +	priv->adapter.algo = &smbus_algorithm;
> > +	priv->pci_dev = pdev;
> > +
> > +	err = pcim_enable_device(pdev);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to enable SMBus PCI device (%d)\n",
> > +			err);
> > +		return err;
> > +	}
> > +
> > +	/* enable bus mastering */
> > +	pci_set_master(pdev);
> > +
> > +	/* Determine the address of the SMBus area */
> > +	start = pci_resource_start(pdev, SMBBAR);
> > +	if (!start) {
> > +		dev_err(&pdev->dev,
> > +			"SMBus base address uninitialized, upgrade BIOS\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	len = pci_resource_len(pdev, SMBBAR);
> > +	if (len == 0) {
> > +		dev_err(&pdev->dev,
> > +			"SMBus base address uninitialized, upgrade BIOS\n");
> > +		return -ENODEV;
> > +	}
> 
> As you are printing the same error message, you can refactor the two tests to make the code more simple.

done

> 
> > +
> > +	dev_dbg(&priv->pci_dev->dev, " start=0x%lX\n", start);
> > +	dev_dbg(&priv->pci_dev->dev, " len=0x%lX\n", len);
> > +
> > +	err = acpi_check_resource_conflict(&pdev->resource[SMBBAR]);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "ACPI resource conflict!\n");
> > +		return err;
> > +	}
> > +
> > +	err = pci_request_region(pdev, SMBBAR, ismt_driver.name);
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to request SMBus region 0x%lx-0x%lx\n",
> > +			start, start + len);
> > +		return err;
> > +	}
> > +
> > +	priv->smba = pcim_iomap(pdev, SMBBAR, len);
> > +	if (!priv->smba) {
> > +		dev_err(&pdev->dev, "Unable to ioremap SMBus BAR\n");
> > +		err = -ENODEV;
> > +		goto fail;
> > +	}
> > +
> > +	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (err) {
> > +		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> > +		if (err)
> > +			goto fail;
> > +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
> > +	}
> > +
> > +	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (err) {
> > +		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> > +		if (err)
> > +			goto fail;
> > +		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> > +	}
> 
> This doesn't look safe to me. What if
> pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) succeeds but pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) fails, or vice-versa? I'd rather do (with a disclaimer: I don't know anything about this "consistent DMA" thing):
> 
> 	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> 	if (err) {
> 		/* Fall back to 32-bit - lowmem */
> 		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> 		if (err)
> 			goto fail;
> 		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> 		if (err)
> 			goto fail;
> 		dev_warn(&pdev->dev, "Cannot DMA highmem, falling back to lowmem\n");
> 	} else {
> 		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> 		if (err)
> 			goto fail;
> 	}
> 
> (Or the more compact variants found in drivers/scsi/vmw_pvscsi.c or drivers/scsi/bfa/bfad.c for example.)
> 
> What do you think? To my candid eyes, setting a different value for
> pci_set_consistent_dma_mask() than for pci_set_dma_mask() seems incorrect. OTOH it seems that some other drivers are doing exactly that so maybe I'm just wrong.

I agree, it doesn't look right.  I asked around, and heard that there
are no known issues with the way I implemented it, but that doesn't make
it right.  I liked the implementation in bfad.c and used it, thanks!

> 
> > +
> > +	err = ismt_init(pdev);
> > +	if (err) {
> > +		err = -ENODEV;
> 
> Please just return the err value returned by the called function.

fixed

> 
> > +		goto fail;
> > +	}
> > +
> > +	ismt_hw_init(pdev);
> > +
> > +	err = ismt_int_init(pdev, priv);
> > +	if (err)
> > +		goto fail;
> > +
> > +	/* set up the sysfs linkage to our parent device */
> > +	priv->adapter.dev.parent = &pdev->dev;
> > +
> > +	/* number of retries on lost arbitration */
> > +	priv->adapter.retries = ISMT_MAX_RETRIES;
> > +
> > +	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
> > +		 "SMBus iSMT adapter at %p", priv->smba);
> 
> A good I2C adapter name is stable across reboots, this one is not. It's better to use "start" as the unique value, as it will stay the same across reboots.

Thanks for the help here!
done

> 
> As a side note, it may make sense, for performance and clarity, to group the initialization of all priv->adapter fields in one place. You initialize 4 fields at the top of the function and 3 fields at the bottom, for no obvious reason.

done

> 
> > +	err = i2c_add_adapter(&priv->adapter);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to add SMBus iSMT adapter\n");
> > +		err = -ENODEV;
> > +		goto fail;
> > +	}
> > +	return 0;
> > +
> > +fail:
> > +	pci_release_region(pdev, SMBBAR);
> > +	return err;
> > +}
> > +
> > +/**
> > + * ismt_remove() - release driver resources
> > + * @pdev: PCI-Express device
> > + */
> > +static void __devexit ismt_remove(struct pci_dev *pdev) {
> > +	struct ismt_priv *priv = pci_get_drvdata(pdev);
> > +
> > +	writel(ISMT_GCTRL_SRST, priv->smba + ISMT_GR_GCTRL);
> > +	i2c_del_adapter(&priv->adapter);
> 
> This is most certainly racy, I think you want to delete the I2C adapter first. BTW, what's the rationale for unconditionally resetting the bus here?

I removed the unconditional reset.  It was a leftover from a polling
implementation I had done that required the reset.

> 
> > +	pci_release_region(pdev, SMBBAR);
> > +}
> > +
> > +/**
> > + * ismt_suspend() - place the device in suspend
> > + * @pdev: PCI-Express device
> > + * @mesg: PM message
> > + */
> > +#ifdef CONFIG_PM
> > +static int ismt_suspend(struct pci_dev *pdev, pm_message_t mesg) {
> > +	pci_save_state(pdev);
> > +	pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
> > +	return 0;
> > +}
> > +
> > +/**
> > + * ismt_resume() - PCI resume code
> > + * @pdev: PCI-Express device
> > + */
> > +static int ismt_resume(struct pci_dev *pdev) {
> > +	pci_set_power_state(pdev, PCI_D0);
> > +	pci_restore_state(pdev);
> > +	return pci_enable_device(pdev);
> > +}
> > +
> > +#else
> > +
> > +#define ismt_suspend NULL
> > +#define ismt_resume NULL
> > +
> > +#endif
> > +
> > +static struct pci_driver ismt_driver = {
> > +	.name = "ismt_smbus",
> > +	.id_table = ismt_ids,
> > +	.probe = ismt_probe,
> > +	.remove = __devexit_p(ismt_remove),
> > +	.suspend = ismt_suspend,
> > +	.resume = ismt_resume,
> > +};
> > +
> > +/**
> > + * i2c_ismt_init() - iSMT driver initialization  */ static int __init 
> > +i2c_ismt_init(void) {
> > +	pr_debug("Loading the iSMT SMBus driver\n");
> > +	return pci_register_driver(&ismt_driver);
> > +}
> > +
> > +/**
> > + * i2c_ismt_exit() - iSMT driver exit code  */ static void __exit 
> > +i2c_ismt_exit(void) {
> > +	pr_debug("Unloading iSMT SMBus driver\n");
> > +	pci_unregister_driver(&ismt_driver);
> > +}
> 
> If you can live without the two debugging messages above (and they don't strike me as terribly useful) you can use module_pci_driver().

I learned something new, thanks!  I went with module_pci_driver().

> 
> > +
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_AUTHOR("Bill E. Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>"); 
> > +MODULE_DESCRIPTION("Intel SMBus Message Transport (iSMT) driver");
> > +
> > +module_init(i2c_ismt_init);
> > +module_exit(i2c_ismt_exit);
> > +
> 
> No blank line at end of file please.

done

> 
> > diff --git a/drivers/i2c/busses/i2c-ismt.h 
> > b/drivers/i2c/busses/i2c-ismt.h new file mode 100644 index 
> > 0000000..e9c10e1
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-ismt.h
> 
> Is there any reason why you'd ever need to include this file from another driver file than i2c-ismt.c? If not, then please just move all these definitions at the top of i2c-ismt.c. This speeds up the build.

Good point.  I like a separate header file when they start to get long,
but this isn't too bad so I moved it to the top of i2c-ismt.c.

> 
> > @@ -0,0 +1,111 @@
> > +#ifndef _I2C_ISMT_H_
> > +#define _I2C_ISMT_H_
> > +
> > +/* PCI Address Constants */
> > +#define SMBBAR		0
> > +
> > +/* PCI DIDs for Briarwood's pair of SMBus Message Transport (SMT) 
> > +Devices */ #define PCI_DEVICE_ID_INTEL_BWD_SMBUS_SMT0 0x0c59 #define 
> > +PCI_DEVICE_ID_INTEL_BWD_SMBUS_SMT1 0x0c5a
> 
> Please align IDs using tabs, it will improve readability especially in case we ever have to add more (and history suggests we will.) Same everywhere below, all values and comments (at least within a given
> block) should be aligned, using tabs.

done

> 
> > +
> > +#define ISMT_DESC_ENTRIES 32 /* number of descritor entries */
> 
> Typo: descriptor

fixed

> 
> > +#define ISMT_MAX_RETRIES 3   /* number of SMBus retries to attempt */
> > +
> > +/* Hardware Descriptor Constants - Control Field */
> > +#define ISMT_DESC_CWRL  0x01    /* Command/Write Length */
> > +#define ISMT_DESC_BLK   0X04    /* Perform Block Transaction */
> > +#define ISMT_DESC_FAIR  0x08    /* Set fairness flag upon successful arbit. */
> > +#define ISMT_DESC_PEC   0x10    /* Packet Error Code */
> > +#define ISMT_DESC_I2C   0x20    /* I2C Enable */
> > +#define ISMT_DESC_INT   0x40    /* Interrupt */
> > +#define ISMT_DESC_SOE   0x80    /* Stop On Error */
> > +
> > +/* Hardware Descriptor Constants - Status Field */
> > +#define ISMT_DESC_SCS   0x01    /* Success */
> > +#define ISMT_DESC_DLTO  0x04    /* Data Low Time Out */
> > +#define ISMT_DESC_NAK   0x08    /* NAK Received */
> > +#define ISMT_DESC_CRC   0x10    /* CRC Error */
> > +#define ISMT_DESC_CLTO  0x20    /* Clock Low Time Out */
> > +#define ISMT_DESC_COL   0x40    /* Collisions */
> > +#define ISMT_DESC_LPR   0x80    /* Large Packet Received */
> > +
> > +/* Hardware Descriptor Masks */
> > +#define ISMT_DESC_ADDR  0x7f    /* I2C/SMB address mask */
> > +#define ISMT_DESC_RW    0x01    /* Read/Write bit mask */
> 
> I don't think it's worth introducing these for a single use where the constants would be just as clear.

Agreed, done.

> 
> > +
> > +/* Macros */
> > +#define ISMT_DESC_ADDR_RW(addr, rw) (((addr & ISMT_DESC_ADDR) << 1)	\
> > +				     | (rw & ISMT_DESC_RW))
> 
> The masking doesn't seem to be terribly needed anyway, it would work the same (and be marginally faster) without. Also note that addr and rw must be enclosed in parentheses for your macro to be safe.

done

> 
> > +
> > +/* iSMT General Register address offsets (SMBAR + <addr>) */
> 
> Typo: SMBBAR

fixed

> 
> > +#define ISMT_GR_GCTRL      0x000 /* General Control */
> > +#define ISMT_GR_SMTICL     0x008 /* SMT Interrupt Cause Location */
> > +#define ISMT_GR_ERRINTMSK  0x010 /* Error Interrupt Mask */ #define 
> > +ISMT_GR_ERRAERMSK  0x014 /* Error AER Mask */
> > +#define ISMT_GR_ERRSTS     0x018 /* Error Status */
> > +#define ISMT_GR_ERRINFO    0x01c /* Error Information */
> > +
> > +/* iSMT Master Registers */
> > +#define ISMT_MSTR_MDBA    0x100  /* Master Descriptor Base Address */
> > +#define ISMT_MSTR_MCTRL   0x108  /* Master Control */
> > +#define ISMT_MSTR_MSTS    0x10c  /* Master Status */
> > +#define ISMT_MSTR_MDS     0x110  /* Master Descriptor Size */
> > +#define ISMT_MSTR_RPOLICY 0x114  /* Retry Policy */
> > +
> > +/* iSMT Miscellaneous Registers */
> > +#define ISMT_SPGT  0x300  /* SMBus PHY Global Timing */
> > +
> > +/* General Control Register (GCTRL) bit definitions */
> > +#define ISMT_GCTRL_TRST 0x04    /* Target Reset */
> > +#define ISMT_GCTRL_KILL 0x08    /* Kill */
> > +#define ISMT_GCTRL_SRST 0x40    /* Soft Reset */
> > +
> > +/* Master Control Register (MCTRL) bit definitions */
> > +#define ISMT_MCTRL_SS    0x01       /* Start/Stop */
> > +#define ISMT_MCTRL_MEIE  0x10       /* Master Error Interrupt Enable */
> > +#define ISMT_MCTRL_FMHP  0x00ff0000 /* Firmware Master Head Pointer 
> > +(FMHP) */
> > +
> > +/* Master Status Register (MSTS) bit definitions */ #define 
> > +ISMT_MSTS_HMTP  0xff0000 /* HW Master Tail Pointer (HMTP) */
> > +#define ISMT_MSTS_MIS   0x20     /* Master Interrupt Status (MIS) */
> > +#define ISMT_MSTS_MEIS  0x10     /* Master Error Interrupt Status (MEIS) */
> > +#define ISMT_MSTS_IP    0x01     /* In Progress */
> > +
> > +/* Master Descriptor Size (MDS) bit definitions */ #define 
> > +ISMT_MDS_MDS  0xFF /* Master Descriptor Size mask (MDS) */
> 
> I tend to prefer when masks are clearly identified as such with a trailing _MASK.

done

> 
> > +
> > +/* SMBus PHY Global Timing Register (SPGT) bit definitions */
> > +#define ISMT_SPGT_SPD     0xc0000000   /* SMBus Speed mask */
> 
> Same here.

done

> 
> > +#define ISMT_SPGT_SPD_80K (0x01 << 30) /* 80 KHz */
> 
> kHz with lower-case k, please.

changed

> 
> Please define the other possible speeds, in case people without the datasheet need to experiment or debug.

I added them in.  They came in handy for the module parameter.

> 
> > +
> > +/* MSI Control Register (MSICTL) bit definitions */ #define 
> > +ISMT_MSICTL_MSIE 0x01 /* MSI Enable */
> > +
> > +/* iSMT Hardware Descriptor */
> > +struct ismt_desc {
> > +	u8 tgtaddr_rw; /* target address & r/w bit */
> > +	u8 wr_len_cmd; /* write length in bytes or a command */
> > +	u8 rd_len; /* read length */
> > +	u8 control; /* control bits */
> > +	u8 status; /* status bits */
> > +	u8 retry; /* collision retry and retry count */
> > +	u8 rxbytes; /* received bytes */
> > +	u8 txbytes; /* transmitted bytes */
> > +	u32 dptr_low; /* lower 32 bit of the data pointer */
> > +	u32 dptr_high; /* upper 32 bit of the data pointer */ };
> 
> Aren't you supposed to declare it with __packed to guarantee it matches the hardware's idea of the descriptor?

Good idea, done/

> 
> > +
> > +struct ismt_priv {
> > +	struct i2c_adapter adapter;
> > +	void *smba; /* PCI BAR */
> > +	struct pci_dev *pci_dev;
> > +	struct ismt_ring_ent **ring; /* housekeeping struct pointer */
> 
> This structure isn't defined anywhere, and this member is never used.

removed

> 
> > +	struct ismt_desc *hw; /* virtual base address of the descriptor */
> > +	dma_addr_t io_rng_dma; /* hardware base address of the descriptor */
> > +	int entries; /* number of descriptor entries */
> 
> This member is assigned once and never used after that. You hard-coded ISMT_DESC_ENTRIES everywhere in the driver. If there's no reason to use another value, just drop priv->entries. If there is a good reason to ever change it, keep and consistently use priv->entries everywhere.

removed

> 
> > +	u8 head; /* ring buffer head pointer */
> > +	u8 tail; /* ring buffer tail pointer */
> 
> Same here, assigned once and never used after that.

removed

> 
> > +	struct completion cmp; /* interrupt completion */ };
> > +
> > +#endif
> 
> --
> Jean Delvare

I'll be submitting v3 shortly.  :)
Many thanks for the thorough review Jean, I really appreciate it!!

Bill Brown
