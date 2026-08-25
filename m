Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5630648C;
	Tue, 25 Aug 2026 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700866; cv=none; b=IGkN6mtsMGVDx+JgI1aw1eXNaQA1f3y//r+Gwwa2bTUFxCgO2P17XU4u8rKxezS4hMrekV436bcit6p5E8gntA74aX5D5zNxaDZNEGlmdsdEE6Qxi9/sgciFMs8lQ18NXqqgHqL0Zxj4RC5FKnWCshbgUBWdKVfjqS5/kTuNTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700866; c=relaxed/simple;
	bh=OerhXMnzRW6ImlqzWcWRaTtqv7c8tQjmkVlC8Cynoxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFwcNQDQApsV/ujJZQTxasjwZNHTzdGxvM5Conb6dTM8NddymDR6drAFoJQThoHITZJa0mw9YrXB0iLICg8bA+KLpEaMeGv/YCVxpGm6zqWzR3xpzhupHcvqCAzRnGefZXx4iMStk9dxoRGyvkmXauQdtnWPU3ICmbuSDLVElMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2foL22d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2foL22d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700863; x=1819236863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OerhXMnzRW6ImlqzWcWRaTtqv7c8tQjmkVlC8Cynoxg=;
  b=J2foL22d8tTQl3Nb575e5Lq2NBemjTgdHDroiAS4/QeuhrSEdQYtsAlc
   IEzosYfVYUXt684G8wJNe4onglj4ejD1LdkhDS9MIjyN+fySCeKLe8gh8
   u4BzcBYhd4lOTd+HoM7xd7JKnzMqHx+82tY3I7qvjg80pC7Dc9wuHY7tu
   sukdN6NMW3wS5a9qfICge+ej3gsb7ju8VaeNm6vqiUqiiL83kYMlSAM5j
   UNwWUkVsY77o8RwyrkkRgH/QsIU7yxUdh7YPgnkJTjlPrktN8M9tVN4uA
   R7f6gcsMuxIlACer9HesHhjv6wqmjYTTwhpP3RZy6rfZZVsTYtfkEoc+a
   A==;
X-CSE-ConnectionGUID: 1d655S/OSNGbDuyCyCcw4A==
X-CSE-MsgGUID: DnBrPqQ2QQ6sw7Db9c/InQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="91858800"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="91858800"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:34:22 -0700
X-CSE-ConnectionGUID: 2reGoFVgTpy3ti4Q87UsSw==
X-CSE-MsgGUID: QXTzkks+SGC/EVLaf4fFMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="270911328"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Aug 2026 16:34:20 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz0en-000000006Xz-2ASB;
	Tue, 25 Aug 2026 23:34:17 +0000
Date: Wed, 26 Aug 2026 07:33:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bowen Yu <yubowen8@huawei.com>, linuxarm@huawei.com,
	liudingyuan@h-partners.com, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhanjie9@hisilicon.com,
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com,
	xuwei5@huawei.com, yubowen8@huawei.com
Subject: Re: [PATCH] i2c: hisi: Add I2C bus recovery support
Message-ID: <202608260721.whmqyiAk-lkp@intel.com>
References: <20260825033125.1893253-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825033125.1893253-1-yubowen8@huawei.com>

Hi Bowen,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on linus/master v7.2 next-20260824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bowen-Yu/i2c-hisi-Add-I2C-bus-recovery-support/20260825-113125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260825033125.1893253-1-yubowen8%40huawei.com
patch subject: [PATCH] i2c: hisi: Add I2C bus recovery support
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260826/202608260721.whmqyiAk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608260721.whmqyiAk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608260721.whmqyiAk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-hisi.c: In function 'hisi_i2c_unprepare_recovery':
>> drivers/i2c/busses/i2c-hisi.c:236:34: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Werror=implicit-function-declaration]
     236 |         if (ctlr->acpi_handle && acpi_has_method(ctlr->acpi_handle, "_RST")) {
         |                                  ^~~~~~~~~~~~~~~
         |                                  acpi_has_watchdog
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from drivers/i2c/busses/i2c-hisi.c:8:
   include/linux/dev_printk.h:154:31: warning: '%s' directive argument is null [-Wformat-overflow=]
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                               ^
   include/linux/dev_printk.h:110:17: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                 ^~~~~~~
   drivers/i2c/busses/i2c-hisi.c:241:25: note: in expansion of macro 'dev_err'
     241 |                         dev_err(ctlr->dev, "_RST method failed: %s\n",
         |                         ^~~~~~~
   drivers/i2c/busses/i2c-hisi.c:241:65: note: format string is defined here
     241 |                         dev_err(ctlr->dev, "_RST method failed: %s\n",
         |                                                                 ^~
   cc1: some warnings being treated as errors


vim +236 drivers/i2c/busses/i2c-hisi.c

   221	
   222	static void hisi_i2c_unprepare_recovery(struct i2c_adapter *adap)
   223	{
   224		struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
   225		u32 reg;
   226	
   227		reg = readl(ctlr->sctrl_addr);
   228		reg &= ~(HISI_I2C_CTRL_SCL_CFG_EN | HISI_I2C_CTRL_DAT_CFG_EN);
   229		writel(reg, ctlr->sctrl_addr);
   230	
   231		/*
   232		 * Invokes the specific ACPI method "_RST" for trigger a soft
   233		 * reset of I2C controller in order to help on I2C controller recover from
   234		 * the abnormal state after bus recovery process.
   235		 */
 > 236		if (ctlr->acpi_handle && acpi_has_method(ctlr->acpi_handle, "_RST")) {
   237			acpi_status status;
   238	
   239			status = acpi_evaluate_object(ctlr->acpi_handle, "_RST", NULL, NULL);
   240			if (ACPI_FAILURE(status))
   241				dev_err(ctlr->dev, "_RST method failed: %s\n",
   242					acpi_format_exception(status));
   243		}
   244	
   245		hisi_i2c_configure_bus(ctlr);
   246	}
   247	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
