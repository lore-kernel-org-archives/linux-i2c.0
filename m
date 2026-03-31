Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E862673B0;
	Tue, 31 Mar 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937662; cv=none; b=QW900jKqDjXzuVO834UAx5dIBfSXvrch9pxRJ7EyXaw8wHvYAYmZiVjLjr/P7JsZLY2vwUTcQj38BujckBerpwwC5Ze+YhxI1qd9VWPB7VGHmkCR4N+vZe3ReJacnadMQsuXl7cxPn/dchCa643+8n81YAnsIxmGUSnujlvYM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937662; c=relaxed/simple;
	bh=jUfWV5yAI3EAt25n1XzK3t/1tif6YWMIXLxxQVq6Umk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpZt6fXyiE5ckxjALTttst0BQvFW9EsJZ1YHpksY4EK6uho4uHNnFn2C2wd/+HMxd/inrBC0/jImL2ASzh/IDjDPqeRUo88MO9686sUoRvilT6UuMfas9dngEDf3al+vb9fVGQiIkqA+Njv1IeC9mMjhMixcycMJEDv9oVlKQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRbE69MW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRbE69MW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774937659; x=1806473659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUfWV5yAI3EAt25n1XzK3t/1tif6YWMIXLxxQVq6Umk=;
  b=HRbE69MWUZMBc3QB+SgeFExf76fRhaWqeDB+aB4DVsa8eHQ6IrpjKavw
   oabQRB8X55t07jkgoFPjQVOwuaU4VJzuPH7Nz3fcCr1weNN+YQR/mhFRp
   1HAOd/kpskUWed5G+huESJKFkF2zCfAGhbJGZY+o4WfPrx5nX+VLv7Ieb
   lkr2+ooTOG7ImjYZ3klbyrEZmH6rSgNt3qvXLrWjeQh5uvmv2lCzrnvl/
   G6Z5H2QVoHyH9sMEgDFsDZ7I9NWzJQlzzcN1+7qDCbSLr+Bs4G28cRilu
   vNoVaU79dQ5/hqohm7rpCCgeLxk3BxjTThmtlgDxSWqahUzDvk59NQzoy
   g==;
X-CSE-ConnectionGUID: 1vBzA5qLT5mmxvobRq3e1w==
X-CSE-MsgGUID: 0k3ib5hMQf6y5NSmw/yGCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101397822"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="101397822"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:14:18 -0700
X-CSE-ConnectionGUID: UVPdt9mLSE6u4cpV/i95Cg==
X-CSE-MsgGUID: 7BsiN1+kSPeqPYVM1PM73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="227885558"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Mar 2026 23:14:17 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7SMg-000000002In-25qD;
	Tue, 31 Mar 2026 06:14:14 +0000
Date: Tue, 31 Mar 2026 14:14:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jovin Basil <jovin555@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, jovin555@gmail.com,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: gpio: replace printk with dev_err in probe
Message-ID: <202603311422.LqU7rVlM-lkp@intel.com>
References: <20260320122656.430939-1-jovin555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320122656.430939-1-jovin555@gmail.com>

Hi Jovin,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on wsa/i2c/for-next linus/master v7.0-rc6 next-20260330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jovin-Basil/i2c-gpio-replace-printk-with-dev_err-in-probe/20260322-133522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260320122656.430939-1-jovin555%40gmail.com
patch subject: [PATCH] i2c: gpio: replace printk with dev_err in probe
config: x86_64-randconfig-078-20250816-CONFIG_SENSORS_LM75 (https://download.01.org/0day-ci/archive/20260331/202603311422.LqU7rVlM-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311422.LqU7rVlM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603311422.LqU7rVlM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from include/linux/i2c-algo-bit.h:13,
                    from drivers/i2c/busses/i2c-gpio.c:11:
   drivers/i2c/busses/i2c-gpio.c: In function 'i2c_gpio_init':
>> drivers/i2c/busses/i2c-gpio.c:493:26: error: 'pdev' undeclared (first use in this function); did you mean 'cdev'?
     493 |                 dev_err(&pdev->dev, "probe failed :%d\n",ret);
         |                          ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/i2c/busses/i2c-gpio.c:493:17: note: in expansion of macro 'dev_err'
     493 |                 dev_err(&pdev->dev, "probe failed :%d\n",ret);
         |                 ^~~~~~~
   drivers/i2c/busses/i2c-gpio.c:493:26: note: each undeclared identifier is reported only once for each function it appears in
     493 |                 dev_err(&pdev->dev, "probe failed :%d\n",ret);
         |                          ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/i2c/busses/i2c-gpio.c:493:17: note: in expansion of macro 'dev_err'
     493 |                 dev_err(&pdev->dev, "probe failed :%d\n",ret);
         |                 ^~~~~~~


vim +493 drivers/i2c/busses/i2c-gpio.c

   486	
   487	static int __init i2c_gpio_init(void)
   488	{
   489		int ret;
   490	
   491		ret = platform_driver_register(&i2c_gpio_driver);
   492		if (ret)
 > 493			dev_err(&pdev->dev, "probe failed :%d\n",ret);
   494	
   495		return ret;
   496	}
   497	subsys_initcall(i2c_gpio_init);
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
