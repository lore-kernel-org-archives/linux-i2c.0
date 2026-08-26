Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107611DD0EF;
	Wed, 26 Aug 2026 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704001; cv=none; b=sVqKIhrqvf4kqprL18e4kaRVSAkfEsIk4lDtcbP9oxi2Hl6U9uadgzKxPrEXeXCQyBb0gcmXbt8SCYfrsl3mwXcNXoWbHf6sNGG5JkyA17mjoEm3rvfmrCLyp8PJGaipOgNHzKaHJjWZ0IouYRrZZVZa+9XVG+fPsnE7NWS/spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704001; c=relaxed/simple;
	bh=ShqDjoWcq+I6QJKftXtNyFZBp+J2PeVZrGP/36klpY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGRmC6PxtFztqrre1sIiM59jQ5vyVuEx5D4yUzyf7PoHjRGGEvoOwkU8HKNhqxCf9HzwY5hkjP+8A1UHtmYdIf25pEu9CX3mPaAZjA99AZfsKyifFfriSI43vPJXopBmKuRy1n7gXPrH8kHZVuSfFP164kQsn7kd+glHWLB+tS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmlPqTY8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmlPqTY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787704000; x=1819240000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShqDjoWcq+I6QJKftXtNyFZBp+J2PeVZrGP/36klpY8=;
  b=hmlPqTY8wlSMTQejeg8wJWM5TTFN4DmUftpCxmCT+3TS5ICD5HF1Onfm
   f9IKIksYuwwreImqV+wU/NOtozuGuuF6Jo+Nq7SiW702PA1XmuGM697Zy
   JlZ5Q+wjB+IEwGplHDShn6DUpcevgNQNIreAoZdarSQ5ZfJZFk5umHi/G
   lvPe7OMH9GlPVD0tTVpOOpkOIAwfJFORhEa+bzRYkJvZQCaDQc403jxI+
   /AKoa4rb99s+CLtL355gLFt9RHUdxC/aCcdVkHoaOgAXXkGcNaIfuIu2k
   1Mp0A9Ebljrn+K1o1T/pnD6cX7YDlMv1x97LbSum9uVMUoXpK1+ehxKar
   Q==;
X-CSE-ConnectionGUID: MrgZ9PBRRC+islbmBkvhoQ==
X-CSE-MsgGUID: U6JvhKE2ThGiIFZ8UK+7ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99704143"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99704143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 17:26:40 -0700
X-CSE-ConnectionGUID: ZKXGshlLQG6FRcNyJvTLWg==
X-CSE-MsgGUID: eM+SggEGRpSxBfq3RV50iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264815669"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 17:26:37 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz1TO-000000006dz-28ka;
	Wed, 26 Aug 2026 00:26:34 +0000
Date: Wed, 26 Aug 2026 08:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bowen Yu <yubowen8@huawei.com>, linuxarm@huawei.com,
	liudingyuan@h-partners.com, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, yubowen8@huawei.com
Subject: Re: [PATCH] i2c: hisi: Add I2C bus recovery support
Message-ID: <202608260816.YagBXzlX-lkp@intel.com>
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
config: arm-randconfig-003-20260826 (https://download.01.org/0day-ci/archive/20260826/202608260816.YagBXzlX-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 771bdfdab2d66a4eb85b8ea7673cfa30152718b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608260816.YagBXzlX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608260816.YagBXzlX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-hisi.c:236:27: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     236 |         if (ctlr->acpi_handle && acpi_has_method(ctlr->acpi_handle, "_RST")) {
         |                                  ^
   drivers/i2c/busses/i2c-hisi.c:236:27: note: did you mean 'acpi_has_watchdog'?
   include/linux/acpi.h:1528:20: note: 'acpi_has_watchdog' declared here
    1528 | static inline bool acpi_has_watchdog(void) { return false; }
         |                    ^
   1 error generated.


vim +/acpi_has_method +236 drivers/i2c/busses/i2c-hisi.c

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
