Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F92FFDE1;
	Thu, 21 May 2026 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353235; cv=none; b=YuszTp32/VWCWMZJLv6aeCD31aJDlAksldcJv6q2r3h177p+teXEWTAi6Y1V/F1+cU7vb7mNMZMepS5hFOvlzA1I3SMRZJvoRNxm5TMnLvo3OEKq4M/aHb+NwQtt3eKY/vnbA/vKzD+YdrxpBxffk/2Vf1LLYaMAd4MwlwiR8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353235; c=relaxed/simple;
	bh=4HsFpS1k2c/85J/YnhXRBGpckKnhnSfX/iEZNq8eSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3qG5t/f/TJM5ZriSQDxy0voy2efQo98SWjMNCqHvz9wf7nn1gPtbthKR6wog8d69e9M9C8x7yb+VB1GtJ9Mi88uLPclTflmAZQUdbcvGvQHvy3GKUDNxHoYluH9bShScIZ+q+ETdPX45VLu3e1IifKOu+scVnGUMkj+i7d7KB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak8ClmlO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak8ClmlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779353233; x=1810889233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4HsFpS1k2c/85J/YnhXRBGpckKnhnSfX/iEZNq8eSXo=;
  b=ak8ClmlOr6Pujn1rkFhIR9/CeFjZKTkhd81Ju2ST9qsGILEwsnwJhLnm
   5/eLdrL7Gy1qVZ0otYx+DI8K3HKFFs23BOaFGVCI413esOpKFpSDoqqbc
   XZnKdXb6IHMW1weVgIjBwbV87cdjXyTfS2kkgUH5QBkUQsgo0j2Gkqy7j
   oLYRmzKcOl1EJbhiH6EvU36U4Kg/Bqu7AJs+9j7lVkaT6EwOgDH36dKCh
   U3pk4BL5nVasatq3iChUHYObsbQAIuRA+y1ArMN+EQQA3FijEcusBSM7a
   N0jtPNYOQEOroJhKYTFjF2FGltweNXthOlgOlrNHbnc4kKsT1ACvzY+Q/
   w==;
X-CSE-ConnectionGUID: 3kzNyfl9RtavlDU1WiGM7g==
X-CSE-MsgGUID: CwfbKTKaSxmdEDcXGF1Fng==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80388118"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80388118"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:47:12 -0700
X-CSE-ConnectionGUID: 5+WlMUKVQAG1AN7ong6/Dw==
X-CSE-MsgGUID: bvKlZgfOQ6KcBhgShCNJBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="240705560"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2026 01:47:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 15D0E95; Thu, 21 May 2026 10:47:09 +0200 (CEST)
Date: Thu, 21 May 2026 10:47:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMC8z?= =?utf-8?Q?=5D_i2c?=
 =?utf-8?Q?=3A?= dwc: Add I2C DWC master/slave support for StarFive JHB100
Message-ID: <20260521084709.GG8580@black.igk.intel.com>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
 <20260521045508.GF8580@black.igk.intel.com>
 <ZQ0PR01MB1269C16B272683144F824FC5820E2@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQ0PR01MB1269C16B272683144F824FC5820E2@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>

Hi,

On Thu, May 21, 2026 at 07:01:08AM +0000, Lianfeng Ouyang wrote:
> 
> Hi, Mika
> 
> Thank for the comments
> 
> > -----邮件原件-----
> > 发件人: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 发送时间: 2026年5月21日 12:55
> > 收件人: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> > 抄送: Andi Shyti <andi.shyti@kernel.org>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Jan Dabros <jsd@semihalf.com>;
> > linux-i2c@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH v1 0/3] i2c: dwc: Add I2C DWC master/slave support for
> > StarFive JHB100
> > 
> > Hi,
> > 
> > On Thu, May 21, 2026 at 11:43:37AM +0800, lianfeng.ouyang wrote:
> > > From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> > >
> > > The Synopsys DesignWare Core (DWC) I2C controller is a variant of the
> > > widely-used DesignWare I2C IP, with a distinct register layout and
> > > enhanced features such as SMBus Alert and programmable FIFO depths.
> > 
> > I wonder why they did shuffle the registers... :(
> 
> Let's first discuss using i2c StarFive
> 
> the colleague who was responsible for the i2c starfive driver earlier cannot be reached, 
> so I compared the databook of i2c designware and i2c starfive, and it seems that the versions are different
> The homepage information of the two databooks is as follows
> 
> i2c designware:
> DesignWare DW_apb_i2c Databook
> 1.16a
> October 2011

This has evolved. My databook is 2.03a which also includes additional
features such as SMBus alert and the like. I suggest at least to get a
recent version from Synopsys.

> i2c starfive:
> DesignWare  ®  Cores Advanced I2C/SMBus Controller and Target Device Databook
> Version 1.01a-lca00
> July 2023
> 
> > 
> > > This patch series introduces support for this controller as implemented
> > > on the StarFive JHB100 platform, which utilizes it for both master and
> > > slave operations (e.g., for MCTP over I2C).
> > >
> > > The series is structured as follows:
> > > 1.  Adds the device tree binding document for the snps,dwc-i2c compatible.
> > > 2.  Prepares the existing i2c-designware-core by exporting and making
> > >     certain key functions overridable, allowing code reuse.
> > > 3.  Introduces the new i2c-dwc-core driver, with separate modules for
> > >     master and slave functionality, based on the 2023-07 revision of the
> > >     Synopsys IP manual.
> > >
> > > Key differences from the Existing i2c-designware Driver
> > > 1.  The DWC IP's offsets for all key registers are redefined. The driver
> > >     maps to the correct addresses by overriding macros from the core
> > >     header file in a new header (i2c-dwc-core.h).
> > 
> > Instead of this, can you provide a regmap that internally maps to these
> > shuffled registers?
> 
> It seems that regmap cannot solve this difference completely, because
> 1. The i2c designware register and i2c starfive register are not offset by the same amount, and even have different orders, for example
> 	offset		I2c designware 	i2c starfive
> DW_IC_DATA_CMD 	0x10 				0x78
> DW_IC_ENABLE   		0x6c 				0x4

This is fine, internally you should be able to map DW_IC_ENABLE to the
correct offset.

Of course if the content is different then this may not work.

> ......
> 
> 2. I2c starfive has some registers with new bit definitions, which i2c designware does not have,
> resulting in the inability to directly use i2c designware functions when accessing these registers, such as
> DW_IC_ENABLE, i2c designware only defines bit0, while i2c starfive defines bit0~bit19

My databook defines DW_IC_ENABLE (offset 0x6c) bits from 0 to 22.

> ......
> 
> Difference point 1 should be solved by defining a register conversion table from i2c designware to i2c starfive, 
> and then using this conversion table for reg_read and regw_write callback. 
> However, difference point 2 seems to be solved only by overwriting weak functions?

We have regmap for that so if possible at all that should be used instead.

> > 
> > > 2.  The host and slave of DWC IP need to perform probe callbacks
> > >     separately, so they cannot be directly set through i2c_dew_set_mode
> > > 3.  Interrupts are cleared by writing​ to the corresponding bits in the
> > >     INTR_CLRregister (write-1-to-clear).
> > > 4.  The DWC controller's IC_ENABLEregister contains an additional
> > >     TX_CMD_BLOCKcontrol bit. When enabling the controller, the driver
> > must
> > >     ensure this bit is cleared. When disabling, only the ENABLEbit is
> > >     cleared, preserving other configurations.
> > >
> > > Lianfeng Ouyang (3):
> > >   dt-bindings: i2c: snps,dwc-i2c: Add StarFive JHB100 bindings
> > >   i2c: designware: Export symbols and add __weak for DWC I2C driver
> > >   i2c: dwc: Add StarFive JHB100 I2C master/slave support
> > >
> > >  .../devicetree/bindings/i2c/snps,dwc-i2c.yaml | 120 +++++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/i2c/busses/Kconfig                    |  34 ++
> > >  drivers/i2c/busses/Makefile                   |   3 +
> > >  drivers/i2c/busses/i2c-designware-common.c    |  57 ++-
> > >  drivers/i2c/busses/i2c-designware-core.h      |  25 +
> > >  drivers/i2c/busses/i2c-designware-master.c    |  14 +-
> > >  drivers/i2c/busses/i2c-designware-platdrv.c   |   6 +
> > >  drivers/i2c/busses/i2c-designware-slave.c     |   4 +-
> > >  drivers/i2c/busses/i2c-dwc-core.h             | 192 ++++++++
> > >  drivers/i2c/busses/i2c-dwc-master.c           | 441
> > ++++++++++++++++++
> > >  drivers/i2c/busses/i2c-dwc-slave.c            | 180 +++++++
> > 
> > Also the naming is confusing so if you need any glue code I recommend
> > calling it i2c-starfive-* instead.
> 
> Considering that the IP was designed by Synopsys instead of StarFive, i2c DWC was used. 
> If there are any requirements, I will change it to i2c StarFive in the next version

Yes but i2c-dwc- is confusing to say the least. If StarFive is the first
one to use this IMHO this can be called i2c-starfive-platdrv.c which then
provides that regmap and calls into i2c-designwware- library where needed.

I don't have strong opinnion about this though, just my 2c.

> > 
> > >  12 files changed, 1068 insertions(+), 15 deletions(-)
> > >  create mode 100644
> > Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
> > >  create mode 100644 drivers/i2c/busses/i2c-dwc-core.h
> > >  create mode 100644 drivers/i2c/busses/i2c-dwc-master.c
> > >  create mode 100644 drivers/i2c/busses/i2c-dwc-slave.c
> > >
> > > --
> > > 2.43.0
