Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B091A682E;
	Fri, 15 May 2026 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807506; cv=none; b=DFL204wULDnvxzQVMDFBNeBS0euPVqGvslBPml9yLFVirUiydQSIYz2VRBKb694jhIHUGrm2Dtai35X3SuYhHtA1fS9Lfj346EoogRgjf/O7hts+ZTRLufXzKfDFOu0w1cxa7FStotm9vbO0v/3Zwe0Rl9xHItm0h9GzhRg18Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807506; c=relaxed/simple;
	bh=2Ep3W60mHhmYSuhahrCqVqoyCeU7AD4+P5ivdqcV0s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXV/xQCLSaYl+16cfhwFlo4lfJOtD0TP+pRkHrugQFY+eon7ANt1kzTscNuqDfWxzOsBQgf5hDTC0uFWiXoSDMER+VVDlZzoPxH2zaAqmN1UKrmLq7qJCsK/pNrdXw7/KnOnLay8xaDew/imNUPqdE5nwXqrP5zeQ9Il65XuLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfEXqONT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfEXqONT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778807503; x=1810343503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Ep3W60mHhmYSuhahrCqVqoyCeU7AD4+P5ivdqcV0s8=;
  b=mfEXqONTFBcXsPetmvh884g6U74bbp8Ug002nV4wZmyHEVXAT7JV46ot
   QCp4f8Iox594tcks2hyEF6D0Iz1F3IH6KcUnfz55dkH2IdQ9W4kQqS7D0
   0yKBiBZYSme5wfg23ZB4ccuiFATG4a1+RBa/2nYofZBqbPQkrKKPw18B0
   bgw+jto/QyT535VaWBorxM3h2P8F003/ghgMzwaTgQ6Hpr4e16pHh+wZq
   4ZgMHYpF7qPvjzs5JEaUiGJdD4oBdjljpR6YBbxZ6l5Y+02kOX0jwdmno
   fe317hl5/ZRwgF+1TeEOVBUS7ZeYky23YWTBCnaYF0iucRCx9sMFc8lNP
   w==;
X-CSE-ConnectionGUID: w2B7RadURZKwQsgHCku2vQ==
X-CSE-MsgGUID: bemoTsOtQR6oySaFbcZIcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79717709"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79717709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 18:11:43 -0700
X-CSE-ConnectionGUID: pkO8VmqkTLynUmFPRZYBWQ==
X-CSE-MsgGUID: /YqF+AY4QaeVXnmt7X2mKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="268892620"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2026 18:11:41 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNh5V-000000000WT-3vRQ;
	Fri, 15 May 2026 01:11:37 +0000
Date: Fri, 15 May 2026 09:08:38 +0800
From: kernel test robot <lkp@intel.com>
To: w15303746062@163.com, jdelvare@suse.com, andi.shyti@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH] i2c: i801: fix hardware state machine corruption in
 error path
Message-ID: <202605150921.HPErQGU3-lkp@intel.com>
References: <20260507114356.247525-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507114356.247525-1-w15303746062@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on andi-shyti/i2c/i2c-host]
[also build test WARNING on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/w15303746062-163-com/i2c-i801-fix-hardware-state-machine-corruption-in-error-path/20260514-165009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260507114356.247525-1-w15303746062%40163.com
patch subject: [PATCH] i2c: i801: fix hardware state machine corruption in error path
config: loongarch-randconfig-002-20260514 (https://download.01.org/0day-ci/archive/20260515/202605150921.HPErQGU3-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150921.HPErQGU3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150921.HPErQGU3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-i801.c:934:1: warning: unused label 'out' [-Wunused-label]
     934 | out:
         | ^~~~
   1 warning generated.


vim +/out +934 drivers/i2c/busses/i2c-i801.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  889  
97140342e69d479 David Brownell    2008-07-14  890  /* Return negative errno on error. */
^1da177e4c3f415 Linus Torvalds    2005-04-16  891  static s32 i801_access(struct i2c_adapter *adap, u16 addr,
^1da177e4c3f415 Linus Torvalds    2005-04-16  892  		       unsigned short flags, char read_write, u8 command,
^1da177e4c3f415 Linus Torvalds    2005-04-16  893  		       int size, union i2c_smbus_data *data)
^1da177e4c3f415 Linus Torvalds    2005-04-16  894  {
a3989dc0b059a51 Heiner Kallweit   2023-02-16  895  	int hwpec, ret;
0cd96eb0a74791c David Woodhouse   2010-10-31  896  	struct i801_priv *priv = i2c_get_adapdata(adap);
^1da177e4c3f415 Linus Torvalds    2005-04-16  897  
cfc69c2e6c699c9 Charles Haithcock 2026-02-27  898  	mutex_lock(&priv->acpi_lock);
cfc69c2e6c699c9 Charles Haithcock 2026-02-27  899  	if (priv->acpi_reserved) {
cfc69c2e6c699c9 Charles Haithcock 2026-02-27  900  		mutex_unlock(&priv->acpi_lock);
a7ae81952cdab56 Mika Westerberg   2016-06-09  901  		return -EBUSY;
cfc69c2e6c699c9 Charles Haithcock 2026-02-27  902  	}
a7ae81952cdab56 Mika Westerberg   2016-06-09  903  
a7401ca5596e246 Jarkko Nikula     2016-03-10  904  	pm_runtime_get_sync(&priv->pci_dev->dev);
a7401ca5596e246 Jarkko Nikula     2016-03-10  905  
1f760b87e54cf56 Heiner Kallweit   2023-02-16  906  	ret = i801_check_pre(priv);
1f760b87e54cf56 Heiner Kallweit   2023-02-16  907  	if (ret)
e67d702846114f6 Mingyu Wang       2026-05-07  908  		goto out_err;
1f760b87e54cf56 Heiner Kallweit   2023-02-16  909  
0cd96eb0a74791c David Woodhouse   2010-10-31  910  	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
e8aac4a9b417643 Jean Delvare      2005-10-26  911  		&& size != I2C_SMBUS_QUICK
e8aac4a9b417643 Jean Delvare      2005-10-26  912  		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
^1da177e4c3f415 Linus Torvalds    2005-04-16  913  
ca8b9e32a11a7cb Oleg Ryjkov       2007-07-12  914  	if (hwpec)	/* enable/disable hardware PEC */
4a3f77ea77013d8 Heiner Kallweit   2025-03-12  915  		iowrite8(ioread8(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
ca8b9e32a11a7cb Oleg Ryjkov       2007-07-12  916  	else
4a3f77ea77013d8 Heiner Kallweit   2025-03-12  917  		iowrite8(ioread8(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
0cd96eb0a74791c David Woodhouse   2010-10-31  918  		       SMBAUXCTL(priv));
e8aac4a9b417643 Jean Delvare      2005-10-26  919  
6ff9d46cd36fbd0 Heiner Kallweit   2024-02-02  920  	if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_BLOCK_PROC_CALL)
6ff9d46cd36fbd0 Heiner Kallweit   2024-02-02  921  		ret = i801_smbus_block_transaction(priv, data, addr, command, read_write, size);
6ff9d46cd36fbd0 Heiner Kallweit   2024-02-02  922  	else if (size == I2C_SMBUS_I2C_BLOCK_DATA)
6ff9d46cd36fbd0 Heiner Kallweit   2024-02-02  923  		ret = i801_i2c_block_transaction(priv, data, addr, command, read_write, size);
7edcb9abb594a8f Oleg Ryjkov       2007-07-12  924  	else
24592482d235107 Heiner Kallweit   2023-02-16  925  		ret = i801_simple_transaction(priv, data, addr, command, read_write, size);
^1da177e4c3f415 Linus Torvalds    2005-04-16  926  
de461a2607c69c4 Heiner Kallweit   2023-02-16  927  	ret = i801_check_post(priv, ret);
de461a2607c69c4 Heiner Kallweit   2023-02-16  928  
c79cfbaccac0ef8 Jean Delvare      2006-04-20  929  	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
63fd342fd121c3e Heiner Kallweit   2023-02-16  930  	 * time, so we forcibly disable it after every transaction.
63fd342fd121c3e Heiner Kallweit   2023-02-16  931  	 */
63fd342fd121c3e Heiner Kallweit   2023-02-16  932  	if (hwpec)
4a3f77ea77013d8 Heiner Kallweit   2025-03-12  933  		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
1f760b87e54cf56 Heiner Kallweit   2023-02-16 @934  out:
4f7275fc7e570df Heiner Kallweit   2021-12-04  935  	/*
4f7275fc7e570df Heiner Kallweit   2021-12-04  936  	 * Unlock the SMBus device for use by BIOS/ACPI,
4f7275fc7e570df Heiner Kallweit   2021-12-04  937  	 * and clear status flags if not done already.
4f7275fc7e570df Heiner Kallweit   2021-12-04  938  	 */
4a3f77ea77013d8 Heiner Kallweit   2025-03-12  939  	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
065b6211a87746e Heiner Kallweit   2021-06-06  940  
e67d702846114f6 Mingyu Wang       2026-05-07  941  out_err:
a7401ca5596e246 Jarkko Nikula     2016-03-10  942  	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
cfc69c2e6c699c9 Charles Haithcock 2026-02-27  943  	mutex_unlock(&priv->acpi_lock);
a7401ca5596e246 Jarkko Nikula     2016-03-10  944  	return ret;
^1da177e4c3f415 Linus Torvalds    2005-04-16  945  }
^1da177e4c3f415 Linus Torvalds    2005-04-16  946  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
