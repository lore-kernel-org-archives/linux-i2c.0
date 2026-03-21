Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5C14AD20;
	Sat, 21 Mar 2026 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134406; cv=none; b=CF8cNPDJbHq7JWqwJAYOe4kOhxhea6M6wnCMzDAfT8HgOX5siqLTnsCf7pz3I8NeG8kL2Qp8cMci7Zvl+syYImM7FApAs35A+kKpYxy8uhNoJX8AQPY0Tls3dtanTwOeSXGkRxom+5Nz6ysioMNS1DmyanE6EdB4xZlcWn/OQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134406; c=relaxed/simple;
	bh=nE5LWGwV2y/S17RyreD+NQzQfwzt9cqThVbWtoq/HIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miNuZEyfA9pk1hRtm1rwi4DIxwBzgK3bAXOiX2eHdBBgeVvvceUzWxEZbTsjhibivk1VQ4tHLl5hnoDO1KTaWdvV1Lim6KMJLqP73eXk39S359IrSfsHFeEBC16g07RRmDtCPhyAhlrbvEUArqlofbX3jbe4UC8XFxtykAuYafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxcxHxCk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxcxHxCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774134405; x=1805670405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nE5LWGwV2y/S17RyreD+NQzQfwzt9cqThVbWtoq/HIU=;
  b=AxcxHxCk7voHpRbK2+hvXlZFU3FmUOxQTFt++04f/+tLNsVwHqTF7Uab
   n0Bp2USUDiK4Xrr3rX+LKsMH48sQa3aQFlRTe/OWjU5gEUTkHWgliB5nM
   o1rL2aQJRN8XaPJBHDG+G9fY1xrmRpWNfCl7ZsTzgc2vKp00y15VADjEW
   8EsVngc+1YJv8vdkjh2QxWlg+Q0drMdrGWmeXhtRuSug9gyoa0XWtj5mM
   ZkjNai533VLNBko3BxrAWvzAHBEkGHIB6fBCgfk8iPEreXJbjXmI/9o+Y
   0viaTu+UZ6jp2M2T73tF5jDfyW683hhoiDQ7xpKqdHPw58yv+ttIxz3pV
   A==;
X-CSE-ConnectionGUID: tsS0oC++QyyA/1C44dsXBw==
X-CSE-MsgGUID: kcg3KB7qRZWOJyb/pXHgtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="62742721"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="62742721"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 16:06:44 -0700
X-CSE-ConnectionGUID: LX6qAGG7RZG1Sw+Pp5hVPA==
X-CSE-MsgGUID: BOUO6qRyTZ2vpT9e1J4pDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="223680244"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2026 16:06:41 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w45Ow-000000001MX-3B74;
	Sat, 21 Mar 2026 23:06:38 +0000
Date: Sun, 22 Mar 2026 07:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jovin Basil <jovin555@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jovin555@gmail.com,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: gpio: replace printk with dev_err in probe
Message-ID: <202603220606.UKyjPueP-lkp@intel.com>
References: <20260320150144.432345-1-jovin555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320150144.432345-1-jovin555@gmail.com>

Hi Jovin,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on wsa/i2c/for-next linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jovin-Basil/i2c-gpio-replace-printk-with-dev_err-in-probe/20260322-012109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260320150144.432345-1-jovin555%40gmail.com
patch subject: [PATCH] i2c: gpio: replace printk with dev_err in probe
config: riscv-randconfig-001-20260322 (https://download.01.org/0day-ci/archive/20260322/202603220606.UKyjPueP-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603220606.UKyjPueP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603220606.UKyjPueP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:854:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     854 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:110:53: note: expanded from macro 'insl'
     110 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/i2c/busses/i2c-gpio.c:11:
   In file included from include/linux/i2c-algo-bit.h:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:863:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     863 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:122:55: note: expanded from macro 'outsb'
     122 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/i2c/busses/i2c-gpio.c:11:
   In file included from include/linux/i2c-algo-bit.h:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:872:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     872 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:123:55: note: expanded from macro 'outsw'
     123 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/i2c/busses/i2c-gpio.c:11:
   In file included from include/linux/i2c-algo-bit.h:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:881:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     881 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:124:55: note: expanded from macro 'outsl'
     124 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/i2c/busses/i2c-gpio.c:11:
   In file included from include/linux/i2c-algo-bit.h:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/i2c/busses/i2c-gpio.c:493:12: error: use of undeclared identifier 'pdev'
     493 |                 dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
         |                          ^~~~
   7 warnings and 1 error generated.


vim +/pdev +493 drivers/i2c/busses/i2c-gpio.c

   486	
   487	static int __init i2c_gpio_init(void)
   488	{
   489		int ret;
   490	
   491		ret = platform_driver_register(&i2c_gpio_driver);
   492		if (ret)
 > 493			dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
   494	
   495		return ret;
   496	}
   497	subsys_initcall(i2c_gpio_init);
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
