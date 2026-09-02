Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947F4772AA;
	Wed,  2 Sep 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349337; cv=none; b=Sm1RIyRBL103rbwgZInqjPleuq4j1cc8a4PyVJv3mYiYW6sY/NLOl11syUbQjZVSmQiJdh7fJhrpSCpdFwwyez4crx24/cbHeFVlgi20s2gck1xt/3BsZjxn9MzNbD3dH3HHzxBJ7Mr5jqI5fdMohPB0ChZCuHc6pdEhmUTQXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349337; c=relaxed/simple;
	bh=AKUnfdhcTKHUJXot2dXdtcpFnmAAQLkTtfgBy/UsLGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFdz/IPySMVO1UVkVcXxou+BtZGka1/NOvmmc/VJF9zNqnoeZ3ZA41aUNI9O2Ezjxc+YpUUxK+CmrofDYnRnuhDJEzoSudPEYeKfuhHpsdZSJP5Rjl5ioG3A0mAZ1yLZpD3W27X5Srqymr0cOhP++9rC8+eC2cs9hmqKOPKMMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3udpVzc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3udpVzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788349333; x=1819885333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKUnfdhcTKHUJXot2dXdtcpFnmAAQLkTtfgBy/UsLGQ=;
  b=L3udpVzc8kUiW9buVNsDWDXx6ZjNrvzdDZv2sYgGehAXjK6tOu6qygpb
   8PdYhmANl7kx58zfkmeHoV+7cd1zY4Ipqjy3ph4isUjRbIVjYsOScjx99
   CRdFbKV7IRK9DaJLrejmh9WamKcDROR14QnWrXEbT8cTtzvtKB8pE0MU1
   kDscZgEPaDXPm9zMmVZ6l8XJ2jJevlR+6u2gTtrJzQ+OR4vkWe+Ui95Wk
   ibnqbHGG0OLzpmIi0V8fZ8eWaYy5TLsnhQMP+jkbm/izKkUs8CbduXDKv
   2139EJuiFebhkCbCUk7eISkoynnheoW67LAztO/fARiWtzOsfMiPNUDu7
   w==;
X-CSE-ConnectionGUID: ZknQff7/SgikOblBqkGFmw==
X-CSE-MsgGUID: l9q+ONUsQu26FHIwEI1DEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88562027"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88562027"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:42:09 -0700
X-CSE-ConnectionGUID: kmkujtPYRVmiDJ3O91nOow==
X-CSE-MsgGUID: 3S70Y/nwTLGcaoS1NGpj7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268840869"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2026 04:42:06 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1jLv-000000002XK-31kx;
	Wed, 02 Sep 2026 11:42:03 +0000
Date: Wed, 2 Sep 2026 19:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bowen Yu <yubowen8@huawei.com>, linuxarm@huawei.com,
	liudingyuan@h-partners.com, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhanjie9@hisilicon.com,
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com,
	xuwei5@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com
Subject: Re: [PATCH v2] i2c: hisi: Add I2C bus recovery support
Message-ID: <202609021937.s2FqKDO3-lkp@intel.com>
References: <20260901063116.3438094-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063116.3438094-1-yubowen8@huawei.com>

Hi Bowen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on andi-shyti/i2c/i2c-host]
[also build test WARNING on linus/master v7.3-rc1 next-20260901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bowen-Yu/i2c-hisi-Add-I2C-bus-recovery-support/20260901-143116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260901063116.3438094-1-yubowen8%40huawei.com
patch subject: [PATCH v2] i2c: hisi: Add I2C bus recovery support
config: csky-randconfig-r064-20260902 (https://download.01.org/0day-ci/archive/20260902/202609021937.s2FqKDO3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021937.s2FqKDO3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021937.s2FqKDO3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-hisi.c:249:12: warning: 'hisi_i2c_get_bus_recovery_res' defined but not used [-Wunused-function]
     249 | static int hisi_i2c_get_bus_recovery_res(struct hisi_i2c_controller *ctlr,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-hisi.c:222:13: warning: 'hisi_i2c_unprepare_recovery' defined but not used [-Wunused-function]
     222 | static void hisi_i2c_unprepare_recovery(struct i2c_adapter *adap)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-hisi.c:210:13: warning: 'hisi_i2c_prepare_recovery' defined but not used [-Wunused-function]
     210 | static void hisi_i2c_prepare_recovery(struct i2c_adapter *adap)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-hisi.c:197:13: warning: 'hisi_i2c_recovery_set_scl' defined but not used [-Wunused-function]
     197 | static void hisi_i2c_recovery_set_scl(struct i2c_adapter *adap, int val)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-hisi.c:189:12: warning: 'hisi_i2c_recovery_get_sda' defined but not used [-Wunused-function]
     189 | static int hisi_i2c_recovery_get_sda(struct i2c_adapter *adap)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-hisi.c:181:12: warning: 'hisi_i2c_recovery_get_scl' defined but not used [-Wunused-function]
     181 | static int hisi_i2c_recovery_get_scl(struct i2c_adapter *adap)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hisi_i2c_get_bus_recovery_res +249 drivers/i2c/busses/i2c-hisi.c

   180	
 > 181	static int hisi_i2c_recovery_get_scl(struct i2c_adapter *adap)
   182	{
   183		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   184		u32 reg = readl(ctlr->iobase + HISI_I2C_TRANS_STATE);
   185	
   186		return !!(reg & HISI_I2C_TRANS_STATE_SCL_LEVEL);
   187	}
   188	
 > 189	static int hisi_i2c_recovery_get_sda(struct i2c_adapter *adap)
   190	{
   191		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   192		u32 reg = readl(ctlr->iobase + HISI_I2C_TRANS_STATE);
   193	
   194		return !!(reg & HISI_I2C_TRANS_STATE_SDA_LEVEL);
   195	}
   196	
 > 197	static void hisi_i2c_recovery_set_scl(struct i2c_adapter *adap, int val)
   198	{
   199		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   200		u32 reg;
   201	
   202		reg = readl(ctlr->sctrl_addr);
   203		if (val)
   204			reg |= HISI_I2C_CTRL_SCL_OUT;
   205		else
   206			reg &= ~HISI_I2C_CTRL_SCL_OUT;
   207		writel(reg, ctlr->sctrl_addr);
   208	}
   209	
 > 210	static void hisi_i2c_prepare_recovery(struct i2c_adapter *adap)
   211	{
   212		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   213		u32 reg;
   214	
   215		reg = readl(ctlr->sctrl_addr);
   216		reg |= HISI_I2C_CTRL_SCL_CFG_EN | HISI_I2C_CTRL_DAT_CFG_EN |
   217			   HISI_I2C_CTRL_CLK_OE | HISI_I2C_CTRL_SCL_OUT;
   218		reg &= ~HISI_I2C_CTRL_DAT_OE;
   219		writel(reg, ctlr->sctrl_addr);
   220	}
   221	
 > 222	static void hisi_i2c_unprepare_recovery(struct i2c_adapter *adap)
   223	{
   224		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   225		u32 reg;
   226	
   227		reg = readl(ctlr->sctrl_addr);
   228		reg &= ~(HISI_I2C_CTRL_SCL_CFG_EN | HISI_I2C_CTRL_DAT_CFG_EN);
   229		writel(reg, ctlr->sctrl_addr);
   230	
   231		/*
   232		 * Invokes the specific ACPI method "_RST" to trigger a soft reset
   233		 * of the I2C controller to help the I2C controller recover from
   234		 * the abnormal state after the bus recovery process.
   235		 */
   236	#ifdef CONFIG_ACPI
   237		if (ctlr->acpi_handle && acpi_has_method(ctlr->acpi_handle, "_RST")) {
   238			acpi_status status;
   239	
   240			status = acpi_evaluate_object(ctlr->acpi_handle, "_RST", NULL, NULL);
   241			if (ACPI_FAILURE(status))
   242				dev_err(ctlr->dev, "_RST method failed: %s\n",
   243					acpi_format_exception(status));
   244		}
   245	#endif
   246		hisi_i2c_configure_bus(ctlr);
   247	}
   248	
 > 249	static int hisi_i2c_get_bus_recovery_res(struct hisi_i2c_controller *ctlr,
   250						 struct platform_device *pdev)
   251	{
   252		struct resource *res0;
   253	
   254		res0 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   255	
   256		if (!res0 || resource_size(res0) != HISI_I2C_RECOVERY_REG_SIZE)
   257			return -ENODEV;
   258	
   259		ctlr->sctrl_addr = devm_ioremap_resource(&pdev->dev, res0);
   260		if (IS_ERR(ctlr->sctrl_addr)) {
   261			ctlr->sctrl_addr = NULL;
   262			return -ENOMEM;
   263		}
   264	
   265		return 0;
   266	}
   267	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
