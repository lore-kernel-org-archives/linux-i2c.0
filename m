Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55543BB66B;
	Thu,  4 Jun 2026 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596555; cv=none; b=psqqTdHIlVpnAWcBVhoRSz7aSJJ+Yvuw6kqHREtS6UZWyG8tL/+O2HHSrArAbKnoBfbOHj78jQVg2dOU6aVArS53WGtmObLX8BbDB9mhmyEbIyoAVjcAsvLHcBQROiKR4uBblbNRzhngKFDCaTiFvWpr70VVYJV5/PWmrFvH4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596555; c=relaxed/simple;
	bh=BUQ1NfOhS73doaAVOJN0D+g64PDhJPFZS90fjp01EK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8QGUSRHOp3JhOxEz38H7qqJ59hKHEA/UhqgMvu4D/bkh+5xotOCc4vXk23WPCuoahlQKuhxXUaaoj11QXAlPTT5HNfYGagRTK2COe75mEAXtHdu/AYt/ITB1TThf6XczE25TOD8lepisDfJjlfviA0lCKhtHAKjvhVvYfJ4awo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqoLtyuE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqoLtyuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780596552; x=1812132552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BUQ1NfOhS73doaAVOJN0D+g64PDhJPFZS90fjp01EK4=;
  b=GqoLtyuECH4qq2zHD1M9tAgY5AI8uOVF4zOXzgemdw3VISio4sX8C+8o
   xto/5G67baIJQOso2Z4cZ7H+YH6f41EiGKWYPiPRRVqUd59Fl68dkLY8o
   gqKp9+CvuONEBxUtr0bqOTQt5Jem3bt0ADBeIe398LBu6+etMN96KGD3f
   CPs+5Ax2d/uwnfbRpA+wbh255Lq+6MzBOmFfRcvrxj6aAz+bAMZ3LO5y8
   ySWbbujy6q4HL4Oj6P0yz9abivrsfN0zKMQLSQQBoYWKsW6dB0tAbgdPJ
   EC3PsLfQscALQ+nML18LRunT0I96AThU0jKif8GzJphC1KXYxKqJWYoJ9
   Q==;
X-CSE-ConnectionGUID: LMyjaYkpTYyPp0ll/+Y9cA==
X-CSE-MsgGUID: mSFWLc0/Qv68xY/R+4IdbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81490164"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81490164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:09:12 -0700
X-CSE-ConnectionGUID: LhIY7hr2QYu5BBljV3pdEg==
X-CSE-MsgGUID: /wq8ae1qRwqEUqhiwLk+PQ==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:09:08 -0700
Date: Thu, 4 Jun 2026 21:09:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2 0/3] i2c: Add Starfive JHB100
 I2C master/slave support
Message-ID: <aiG_QviPrmFKwZq3@ashevche-desk.local>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <ah9Yrt_gO8uGaPw_@ashevche-desk.local>
 <ZQ0PR01MB12690FA279708FD6A6DB063282132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <ah_AOjTY9effYDtb@ashevche-desk.local>
 <ZQ0PR01MB126986C9C4A60F6AA767F3D882132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <ah_MM_Ur-VGixAyr@ashevche-desk.local>
 <ZQ0PR01MB1269A0AC9B335723A3C689F782102@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQ0PR01MB1269A0AC9B335723A3C689F782102@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 03:00:13AM +0000, Lianfeng Ouyang wrote:
> > 发件人: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 发送时间: 2026年6月3日 14:40
> > On Wed, Jun 03, 2026 at 06:09:24AM +0000, Lianfeng Ouyang wrote:
> > > > 发件人: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 发送时间: 2026年6月3日 13:49
> > > > On Wed, Jun 03, 2026 at 05:31:38AM +0000, Lianfeng Ouyang wrote:
> > > > > > 发件人: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > 发送时间: 2026年6月3日 6:27
> > > > > > On Wed, May 27, 2026 at 04:50:36PM +0800, lianfeng.ouyang wrote:
> > 
> > > > > > > The Starfive JHB100 I2C controller is a variant of the widely-used
> > > > > > > DesignWare I2C IP, with a distinct register layout and enhanced
> > features
> > > > > > > such as SMBus Alert and programmable FIFO depths.
> > > > > > >
> > > > > > > The series is structured as follows:
> > > > > > > 1.  Adds the device tree binding document for the starfive,jhb100-i2c
> > > > > > >         compatible.
> > > > > > > 2.  Prepares the existing i2c-designware-core by exporting and
> > making
> > > > > > >         certain key functions overridable, allowing code reuse.
> > > > > > > 3.  Introduces the new i2c-starfive-* driver, with separate modules for
> > > > > > >         master and slave functionality, based on the 2023-07 revision
> > of
> > > > > > > 	the Synopsys IP manual.
> > > > > > >
> > > > > > > Currently, due to the following differences, i2c designware cannot be
> > > > > > > fully reused
> > > > > > > 1.  For high and low level counting settings at different rates, i2c
> > > > > > >         starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
> > > > > > > 2.  Interrupt clearing is achieved by writing 1 to the corresponding
> > > > > > >         bit of INTR_CLR, while designware reads different clearing
> > > > > > > 	registers
> > > > > > > 3.  Master and slave require separate probe callbacks and cannot rely
> > > > > > >         solely on the runtime mode switching provided by
> > > > > > i2c_dw_set_mode()
> > > > > > > 4.  The value of FIFO depth is not obtained through registers, but
> > > > > > >         written through DTS
> > > > > >
> > > > > > NAK in this form. We well discourage code duplication and ugly ifdeffery
> > with
> > > > > > full of __weak annotations that may not be present in the regular driver.
> > > > There
> > > > > > is not even a tiny bit of justification for this nonsense.
> > > > > >
> > > > > > TL;DR: this series needs much more work.
> > > > > >
> > > > > > > I have written some poorly styled code to reduce changes to i2c
> > > > designware
> > > > > > > and reuse its functions by keeping aa always true, for example
> > > > > > > 1.  the implementation of i2c-d w_probe_master() differs only for the
> > two
> > > > > > >         IPs in i2c_dw_set_timits_master(). In order to reuse
> > > > > > > 	i2c_dw_probe_master(), i2c_dw_set_timits_master is declared as
> > > > > > > 	__weak. A better approach is to use a callback function, but using
> > > > > > > 	a callback function requires changing more i2c designware files.
> > > > > > > 	I don't know what the attitude of the community is
> > > > > > > 2.  For the operation of clearing interrupt flags, i2c designware reads
> > > > > > >         and i2c starfive writes. Therefore, in order not to modify the
> > > > > > > 	relevant logic of i2c designware, I added a write operation to
> > > > > > > 	sf_reg_read()
> > > > > > > So I think this version of the code is not allowed to merge, but I don't
> > > > > > > know how to handle this situation because if i2c designware is not
> > changed
> > > > > > >  at all, we will have to write code that is similar to i2c designware.
> > > > > > >  Will this type of IP not be allowed to merge?
> > > > >
> > > > > Thanks for the review.
> > > > >
> > > > > In the future, the designware will be changed to the form of callback
> > functions,
> > > > > and then callback functions will be passed in i2c starry - * and implemented
> > > > > using designware as a library
> > > >
> > > > Why you can't specify your own regmap as it was done in Baikal case? What
> > are
> > > > the obstacles to achieve that?
> > >
> > > The main reasons are as follows
> > > 1.  For high and low level counting settings at different rates, i2c
> > > starfive just use IC_SCL_H/LCNT to set SS, FM, FM+, UFM,
> > > ====> Therefore, it is not possible to directly use the
> > i2c_dew_set_timits_master()
> > >       of designware, Because the definition of registers has changed
> > 
> > So, it's not a DW per se? What the DW databook reflects the register layout and
> > other bits? I.o.w. which version of DW i2c IP is this?
> > 
> > > 2.  Interrupt clearing is achieved by writing 1 to the corresponding
> > > bit of INTR_CLR, while designware reads different clearing
> > > registers
> > > ====> The way of operating registers is different, so it cannot be
> > >       distinguished solely by address or offset, and can only be adapted
> > >       to operations belonging to i2c starfive through callback functions
> > 
> > This can be done in the custom regmap functions. You know that you may
> > redefine the regmap IO accessors and do whatever you want there based on
> > the registers. Yes, what you are probably talking about is a workflow.
> > 
> > But we basically need to see a patch-per-workflow change for each case
> > to understand the differences better. I.o.w. if you need, for instance,
> > separate or special IRQ handling part, create a patch to move existing
> > code to a callback with explanation why it's needed. All the same for
> > the timings and so on. It would be nice to have a datasheet at hand to
> > actually read and see the differences. Without that it's even hard to
> > propose better solutions. But current state is for sure no go.
> > 
> > > 3.  Master and slave require separate probe callbacks and cannot rely
> > > solely on the runtime mode switching provided by i2c_dw_set_mode()
> > > ====> There are host and slave IP addresses separately, unlike designware
> > >       where one IP supports two roles, because the logic of switching roles
> > >       cannot be distinguished by address and offset
> > 
> > This feature should be left at last, but altogether it smells like either
> > a completely new i2c DW design (like they did for DMA and SSI at some
> > point) and most likely will need a brand new driver explaining all of this
> > with a link to a datasheet.
> > 
> > > 4.  The value of FIFO depth is not obtained through registers, but
> > > written through DTS
> > > ====> The register does not have information on the depth of FIFO,
> > >       and manual writing of register settings is required
> > >
> > > In addition to the above four points, the initialization, transmission, and
> > interrupts
> > > of i2c Starfive are basically the same as i2c Desirware. Therefore, we hope to
> > reuse
> > > i2c designware instead of re implementing the i2c Starfive driver, otherwise
> > the code repetition will be high
> > 
> > These sounds like candidates for i2c-designware-lib.c, indeed.
> > But the rest most likely shouldn't be intervened at all. I.o.w.
> > please provide a detailed analysis (something like [1]) in
> > the cover letter, or just send an RFC on the driver design
> > before even starting considering actual coding.
> > 
> > > Hope I can answer your question, thank you
> > 
> > [1]: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi")
> 
> Okay, based on the format of e539f435cb9c, I have compiled the differences in 
> register offsets and the differences between registers IC_CTRL and IC-INTR_CLR.
> Looking forward to your reply

Thank you for this information, it makes much more easier to see the big picture.
With the given information I think you most likely need a brand new driver.
No callbacks for sure. The only thing that may be done is to split really common
code and data structures in i2c-designware-lib.[ch] between two. This will
require quite a bit of refactoring (as you most likely don't want to inherit
all quirked and hacked fields from struct dw_i2c_dev, meaning you want to
have something just very basic and common between two there. means that
the current struct dw_i2c_dev will be morphed to something like

drivers/i2c/busses/i2c-designware-lib.h:

	struct dw_i2c_common {
		...
	};

drivers/i2c/busses/i2c-designware-core.h:

	struct dw_i2c_dev {
		struct dw_i2c_common icom;
		...
	};

and in your new driver

	struct dw_adv_i2c_dev {
		struct dw_i2c_common icom;
		...
	};

And in the drivers/i2c/busses/i2c-designware-lib.c:

	... dw_i2c_common_...(struct dw_i2c_common *icom, ...)
	{
		...
	}

for the shared APIs.

With that I predict a series out of ~10 patches (or more).

The brand new driver is also a solution, but to go there you need to at least
have a PoC of the above to justify that the shared code makes little sense.

> DWC_ADV_i2c is the enhanced version of DW_apb_i2c (corresponding to existing i2c designware driver), 
> Most of their registers are similar, but the bit fields of key registers 
> (e.g. IC_CTRL/IC_CON, IC_TAR, IC_ENABLE) are different, and DWC_ADV_i2c has 
> additional registers for mission critical features and newer protocol version support.
> 
> DWC_ADV_i2c has additional features compared to DW_apb_i2c. Major enhancements
> in DWC_ADV_i2c are:
> - Support for I2C Bus Specification V7.0 (October 2021) and SMBus Specification V3.2 (January 2022),
>   while DW_apb_i2c supports I2C V6.0 (April 2014) and SMBus V3.1 (March 2018)
> - Support for SMBus Non-ARP Command Code Decoding and Advanced Block Read/Write
> - Support for dynamic target address update (IC_DYNAMIC_TAR_UPDATE=1)
> - Support for Ultra-Fast Mode (up to 5 MB/s) with dedicated timing registers
> - Both DWC_ADV_i2c and DW_apb_i2c are APB slave devices, supporting APB2/APB3/APB4
>   interfaces with configurable data width (8/16/32 bits).
> 
> Register offset (base address 0x0 for both, DWC_ADV_i2c uses separate address blocks for
> operational, I2C and SMBus registers, DW_apb_i2c uses a unified register map)
>                         DWC_ADV_i2c          DW_apb_i2c
> IC_HCI_VERSION            0x00                    N/A
> IC_ENABLE                 0x04                    0x6c
> IC_RESET_CTRL             0x08                    N/A
> IC_CAPABILITIES             0x0c                    N/A
> IC_I2C_CAPABILITIES         0x10                    N/A
> IC_SMBUS_CAPABILITIES      0x18                    0x9c
> IC_SMBUS_BLOCK_OFFSET     0x1c                    0xa0
> IC_CTRL                   0x04 (I2C block)         0x00 (IC_CON)
> IC_TAR                    0x08 (I2C block)        0x04
> IC_DAR                    0x0c (I2C block)        0x08 (IC_SAR)
> IC_HS_CADDR               0x10 (I2C block)        0x0c (IC_HS_MADDR)
> IC_DATA_CMD               0x58 (I2C block)        0x10
> IC_UFM_TBUF_CNT           0x20 (I2C block)        N/A
> IC_SCL_HCNT               0x24 (I2C block)        0x1c (IC_FS_SCL_HCNT)
> IC_SCL_LCNT               0x28 (I2C block)        0x20 (IC_FS_SCL_LCNT)
> IC_HS_SCL_HCNT            0x2c (I2C block)        0x24
> IC_HS_SCL_LCNT            0x30 (I2C block)        0x28
> IC_SDA_HOLD               0x34 (I2C block)        0x7c
> IC_SDA_SETUP              0x38 (I2C block)        0x94
> IC_SPKLEN                 0x3c (I2C block)        0xa0 (IC_FS_SPKLEN)
> IC_HS_SPKLEN              0x40 (I2C block)        0xa4
> IC_DMA_RDLR               0x6c (I2C block)        0x90
> IC_INTR_STAT              0x74 (I2C block)         0x2c
> IC_INTR_MASK              0x78 (I2C block)        0x30
> IC_RAW_INTR_STAT          0x7c (I2C block)        0x34
> IC_DAR4                   0xb8 (I2C block)        0x108 (IC_SAR4)
> IC_SFTY_CTRL              0xc0 (I2C block)         N/A
> IC_SMBUS_CTRL             0x04 (SMBus block)      N/A
> IC_SMBUS_ARP_CTRL         0x08 (SMBus block)      N/A
> IC_SMBUS_INTR_STAT        0x28 (SMBus block)      0xc8
> IC_SMBUS_INTR_MASK        0x2c (SMBus block)      0xcc
> IC_SMBUS_INTR_RAW_STAT    0x30 (SMBus block)      0xd0
> 
> Register configuration - IC_CTRL (DWC_ADV_i2c) vs IC_CON (DW_apb_i2c)
>                         DWC_Adv_i2c          DW_apb_i2c
>   IC_OP_MODE               bit[0]            bit[0] (MASTER_MODE)
>   IC_SPEED                  bit[5:4]           bit[2:1] (SPEED)
>   IC_10BITADDR_TGT          bit[8]            bit[3] (IC_10BITADDR_SLAVE)
>   IC_10BITADDR_CTRLR        bit[9]            bit[4] (IC_10BITADDR_MASTER)
>   BUS_CLEAR_FEATURE_CTRL    bit[14]           bit[11]
> 
> Register configuration - IC_INTR_CLR
>                         DWC_ADV_i2c              DW_apb_i2c
>   CLR_INTR               bit[0] (write)      IC_INTR_CLR       bit[0] (read)
>   CLR_RX_UNDER          bit[1] (write)      IC_CLR_RX_UNDER  bit[0] (read)
>   CLR_RX_OVER           bit[2] (write)      IC_CLR_RX_OVER    bit[0] (read)
>   CLR_TX_OVER            bit[3] (write)      IC_CLR_TX_OVER   bit[0] (read)
>   CLR_RD_REQ             bit[4] (write)      IC_CLR_RD_REQ    bit[0] (read)
>   ......
> 
> The documents used are
> [1] DesignWare ® Cores Advanced I2C/SMBus Controller and Target Device Databook, Product Code H464-0, I2C Bus Spec V7.0, 
> [2] DesignWare ® DW_apb_i2c Databook, Version 2.03a, December 2020, I2C Bus Spec V6.0

-- 
With Best Regards,
Andy Shevchenko


