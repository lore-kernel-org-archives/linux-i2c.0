Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B973FA5E7;
	Mon, 21 Sep 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989122; cv=none; b=QxiRBf9G5+17cbXMQG1blRQ5nxszsdlafAgOhz4Gh07kVAYd2YORT9XLW1JVAJzHtmq7F0G4IwLirBN30E2ABeLL4punkJ2RYdJbu5ec0Kw05FDbxIvCX8Qxvm48HFaUFR+z2WMnSKOp3WApdOuW7rkYkR3BS7dFY0beb49Rdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989122; c=relaxed/simple;
	bh=ZpOzhi3uqjsVA09CdLCYdKwIisDUR2UPCXVHY+SOHG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tghI82uN+ubqJEb2a5nf0YhJYl12RumEbHvO88hpTVN4OTYwKl6xfa7Ui3y/kqvu64Z200d3zRPrIg9Ib/sE3/VdhK+QA1NixrX90u/M8MMf9ez6WDrZvlqvJTa0Sm/VikHPV7EfbfQ5futS3A6jumKWf59ur6MLXB3x4FCozkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JALHxyPC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JALHxyPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789989120; x=1821525120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZpOzhi3uqjsVA09CdLCYdKwIisDUR2UPCXVHY+SOHG4=;
  b=JALHxyPC1juqrt2P5kOAFzCk7A0aTAeexeVVLvTir9lSBUHBZcdhdUx1
   2pWkJPx/V0nU5NSnM3Ir4dHMpyhFwWtjGGboIlEFNdOzCX2muWh9xy81V
   SesYHyow5Zx89ZjpF4gx86sq4DalYp8JofQS8cj5rNcsIKpwYCA8472wE
   oYTlKn5JQsdNfoB0QCk84FgbqXYUNsagGapoYu7D2+3nupc9iAkkx/U+E
   wgvXcg9DMzZycPXZFy5cQnPyf/4JK4IQwvSzA2MDx3FFWjQCkLaqr2EsD
   rx1X19MCZ/a9npC9Sxnca3/EI0PjGmkSICGEq10qk7YknRHz5+kupHDAU
   g==;
X-CSE-ConnectionGUID: 6Zf/WbzzSdiBtjTAASPBQA==
X-CSE-MsgGUID: Lv1W/YOvTS69a6J3Q7h1VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89629614"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89629614"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:11:57 -0700
X-CSE-ConnectionGUID: m0SDz/J4Qcy0askJRTm3LQ==
X-CSE-MsgGUID: APE+PFb/RlSCKy5wDda8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="269124151"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2026 04:11:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A863599; Mon, 21 Sep 2026 13:11:48 +0200 (CEST)
Date: Mon, 21 Sep 2026 13:11:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com
Subject: Re: [PATCH 2/3] i2c: designware: Introduce per-variant register
 offset and bit-layout tables
Message-ID: <20260921111148.GT106095@black.igk.intel.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>

Hi,

On Sat, Sep 19, 2026 at 02:36:07PM +0530, Aniket Limaye wrote:
> Every DW_IC_* register offset and CON-register bit position is currently
> baked in as a compile-time constant, which only works while there is a
> single register layout. Introduce a logical register-ID enum (enum
> dw_i2c_reg_idx) plus a per-variant offset table (dev->regs[]) and a
> per-variant CON-register bit-layout descriptor (dev->con_bits), selected
> at probe time via the new i2c_dw_select_variant().
> 
> Replace every direct DW_IC_* offset/bit-position reference with a lookup
> through dev->regs[]/dev->con_bits. Also fold the read-to-clear
> interrupt-acknowledgment pattern into a new i2c_dw_ack_intr() helper,
> driven by a per-variant dev->intr_clr[] table.
> 
> Only one variant exists at this point (DW_apb_i2c), so this is a
> mechanical, behavior-preserving change: the values in
> dw_i2c_reg_offsets[] and dw_i2c_con_bits match the DW_IC_* macros
> exactly. It lays the groundwork for adding a second register layout
> (DWC_i2c) without duplicating the whole driver.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>  drivers/i2c/busses/i2c-designware-amdisp.c  |   1 +
>  drivers/i2c/busses/i2c-designware-common.c  | 158 ++++++++++++++++++++++------
>  drivers/i2c/busses/i2c-designware-core.h    | 108 ++++++++++++++++++-
>  drivers/i2c/busses/i2c-designware-master.c  | 125 +++++++++++-----------
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |   2 +
>  drivers/i2c/busses/i2c-designware-platdrv.c |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c   |  42 ++++----
>  7 files changed, 318 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
> index 9f0ec0fae6f2..f7aa075c9977 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -46,6 +46,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
>  	isp_i2c_dev->flags |= ACCESS_POLLING;
>  	platform_set_drvdata(pdev, isp_i2c_dev);
>  
> +	i2c_dw_select_variant(isp_i2c_dev);
>  	isp_i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(isp_i2c_dev->base))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(isp_i2c_dev->base),
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index a1eca6cd4b75..a21aeb7f415a 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -72,6 +72,95 @@ static const char *const abort_sources[] = {
>  		"incorrect slave-transmitter mode configuration",
>  };
>  
> +/* "snps,designware-i2c" flat register layout */
> +static const u32 dw_i2c_reg_offsets[DW_REG_IDX_MAX] = {
> +	[DW_REG_IDX_CON]			= DW_IC_CON,
> +	[DW_REG_IDX_TAR]			= DW_IC_TAR,
> +	[DW_REG_IDX_SAR]			= DW_IC_SAR,
> +	[DW_REG_IDX_DATA_CMD]		= DW_IC_DATA_CMD,
> +	[DW_REG_IDX_SS_SCL_HCNT]		= DW_IC_SS_SCL_HCNT,
> +	[DW_REG_IDX_SS_SCL_LCNT]		= DW_IC_SS_SCL_LCNT,
> +	[DW_REG_IDX_FS_SCL_HCNT]		= DW_IC_FS_SCL_HCNT,
> +	[DW_REG_IDX_FS_SCL_LCNT]		= DW_IC_FS_SCL_LCNT,
> +	[DW_REG_IDX_HS_SCL_HCNT]		= DW_IC_HS_SCL_HCNT,
> +	[DW_REG_IDX_HS_SCL_LCNT]		= DW_IC_HS_SCL_LCNT,
> +	[DW_REG_IDX_INTR_STAT]		= DW_IC_INTR_STAT,
> +	[DW_REG_IDX_INTR_MASK]		= DW_IC_INTR_MASK,
> +	[DW_REG_IDX_RAW_INTR_STAT]		= DW_IC_RAW_INTR_STAT,
> +	[DW_REG_IDX_RX_TL]			= DW_IC_RX_TL,
> +	[DW_REG_IDX_TX_TL]			= DW_IC_TX_TL,
> +	[DW_REG_IDX_CLR_INTR]		= DW_IC_CLR_INTR,
> +	[DW_REG_IDX_CLR_RX_UNDER]		= DW_IC_CLR_RX_UNDER,
> +	[DW_REG_IDX_CLR_RX_OVER]		= DW_IC_CLR_RX_OVER,
> +	[DW_REG_IDX_CLR_TX_OVER]		= DW_IC_CLR_TX_OVER,
> +	[DW_REG_IDX_CLR_RD_REQ]		= DW_IC_CLR_RD_REQ,
> +	[DW_REG_IDX_CLR_TX_ABRT]		= DW_IC_CLR_TX_ABRT,
> +	[DW_REG_IDX_CLR_RX_DONE]		= DW_IC_CLR_RX_DONE,
> +	[DW_REG_IDX_CLR_ACTIVITY]		= DW_IC_CLR_ACTIVITY,
> +	[DW_REG_IDX_CLR_STOP_DET]		= DW_IC_CLR_STOP_DET,
> +	[DW_REG_IDX_CLR_START_DET]		= DW_IC_CLR_START_DET,
> +	[DW_REG_IDX_CLR_GEN_CALL]		= DW_IC_CLR_GEN_CALL,
> +	[DW_REG_IDX_ENABLE]			= DW_IC_ENABLE,
> +	[DW_REG_IDX_STATUS]			= DW_IC_STATUS,
> +	[DW_REG_IDX_TXFLR]			= DW_IC_TXFLR,
> +	[DW_REG_IDX_RXFLR]			= DW_IC_RXFLR,
> +	[DW_REG_IDX_SDA_HOLD]		= DW_IC_SDA_HOLD,
> +	[DW_REG_IDX_TX_ABRT_SOURCE]		= DW_IC_TX_ABRT_SOURCE,
> +	[DW_REG_IDX_ENABLE_STATUS]		= DW_IC_ENABLE_STATUS,
> +	[DW_REG_IDX_SMBUS_INTR_MASK]	= DW_IC_SMBUS_INTR_MASK,
> +	[DW_REG_IDX_COMP_PARAM_1]		= DW_IC_COMP_PARAM_1,
> +	[DW_REG_IDX_COMP_VERSION]		= DW_IC_COMP_VERSION,
> +	[DW_REG_IDX_COMP_TYPE]		= DW_IC_COMP_TYPE,
> +};
> +
> +static const struct dw_i2c_con_bits dw_i2c_con_bits = {
> +	.master			= DW_IC_CON_MASTER,
> +	.speed_std		= DW_IC_CON_SPEED_STD,
> +	.speed_fast		= DW_IC_CON_SPEED_FAST,
> +	.speed_high		= DW_IC_CON_SPEED_HIGH,
> +	.speed_mask		= DW_IC_CON_SPEED_MASK,
> +	.bit10_slave		= DW_IC_CON_10BITADDR_SLAVE,
> +	.bit10_master		= DW_IC_CON_10BITADDR_MASTER,
> +	.restart_en		= DW_IC_CON_RESTART_EN,
> +	.slave_disable		= DW_IC_CON_SLAVE_DISABLE,
> +	.stop_det_ifaddressed	= DW_IC_CON_STOP_DET_IFADDRESSED,
> +	.tx_empty_ctrl		= DW_IC_CON_TX_EMPTY_CTRL,
> +	.rx_fifo_full_hld_ctrl	= DW_IC_CON_RX_FIFO_FULL_HLD_CTRL,
> +	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
> +};
> +
> +/* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
> +static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
> +	[DW_INTR_IDX_ALL]       = DW_REG_IDX_CLR_INTR,
> +	[DW_INTR_IDX_RX_UNDER]  = DW_REG_IDX_CLR_RX_UNDER,
> +	[DW_INTR_IDX_RX_OVER]   = DW_REG_IDX_CLR_RX_OVER,
> +	[DW_INTR_IDX_TX_OVER]   = DW_REG_IDX_CLR_TX_OVER,
> +	[DW_INTR_IDX_RD_REQ]    = DW_REG_IDX_CLR_RD_REQ,
> +	[DW_INTR_IDX_TX_ABRT]   = DW_REG_IDX_CLR_TX_ABRT,
> +	[DW_INTR_IDX_RX_DONE]   = DW_REG_IDX_CLR_RX_DONE,
> +	[DW_INTR_IDX_ACTIVITY]  = DW_REG_IDX_CLR_ACTIVITY,
> +	[DW_INTR_IDX_STOP_DET]  = DW_REG_IDX_CLR_STOP_DET,
> +	[DW_INTR_IDX_START_DET] = DW_REG_IDX_CLR_START_DET,
> +	[DW_INTR_IDX_GEN_CALL]  = DW_REG_IDX_CLR_GEN_CALL,
> +};
> +
> +/**
> + * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
> + * layout and interrupt-ack mapping matching this device's IP variant
> + * @dev: device private data
> + *
> + * Must be called after dev->flags has been populated from
> + * device_get_match_data()/ACPI id data, and before any register access
> + * (including i2c_dw_init_regmap()).
> + */
> +void i2c_dw_select_variant(struct dw_i2c_dev *dev)
> +{
> +	dev->regs = dw_i2c_reg_offsets;
> +	dev->con_bits = &dw_i2c_con_bits;
> +	dev->intr_clr = dw_i2c_intr_clr;
> +}
> +EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
> +
>  static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct dw_i2c_dev *dev = context;
> @@ -147,7 +236,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
>  		.disable_locking = true,
>  		.reg_read = dw_reg_read,
>  		.reg_write = dw_reg_write,
> -		.max_register = DW_IC_COMP_TYPE,
> +		.max_register = dev->regs[DW_REG_IDX_COMP_TYPE],
>  	};
>  	u32 reg;
>  	int ret;
> @@ -163,7 +252,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
>  	if (ret)
>  		return ret;
>  
> -	reg = readl(dev->base + DW_IC_COMP_TYPE);
> +	reg = readl(dev->base + dev->regs[DW_REG_IDX_COMP_TYPE]);
>  	i2c_dw_release_lock(dev);
>  
>  	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
> @@ -365,17 +454,17 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
>  {
>  	switch (mode) {
>  	case DW_IC_MASTER:
> -		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
> -		regmap_write(dev->map, DW_IC_RX_TL, 0);
> -		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], dev->tx_fifo_depth / 2);
> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->master_cfg);

Instead of all this. Can't you do this inside the regmap so that here and
elsewhere in the driver we continue to do:

	regmap_write(dev->map, DW_IC_RX_TL, 0);

but internally, depending on the hardware it then maps this into the
corresponding register offset.
