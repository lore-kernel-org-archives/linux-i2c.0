Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3F86329;
	Sat, 21 Mar 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131856; cv=none; b=jCmjJ4DkoS/KmGQ9+pqKWODByGfuk1jSNacgmaBY2ysKi2MZKukrLjzK6ntZfVVLpUqnNZkTFP4lMTRr35MP8eFjDSZgl03Vl0r1ZPj0NOUult4dkEhMvANiMbqS24iLLDrSw7q6mjMEAryybfdIbXk9OM6s3dbPO2iqaaL/Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131856; c=relaxed/simple;
	bh=+6LCAcP2Ap2mDAhfU0g8LPq4J+1jMBraG3Dx2Gy3OZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8C01hdzlO9h1r2lMwP8EdUJU5UlUmNLzX1bCy+7iVV8HPY7auD+bCiX1djseo/Yk/skzYL4mzw5QkOAoRTI5yE69J/NBd60sPo5XNv6dF3eFaSTFk94q35pZzTcx9Qa05myH+vo1dweM/lmcK6ZgOErNRY/T8fOFrHmpTpIX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTens8p0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTens8p0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774131854; x=1805667854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+6LCAcP2Ap2mDAhfU0g8LPq4J+1jMBraG3Dx2Gy3OZs=;
  b=QTens8p066nW41RSdt8PKOvFyVtXAUQFNpPVvEY3w/8LGnkbKLfcpHcj
   tUT0NJOUbW0FD0TZ5KRlEbheJ0glV2yi+LrZA6NtT78UOq6MX5bNsW7OS
   z7qrdmQ0VQI/BYCMc56GUMS8SkebBanT2bCwBq0Na9bNMidPm9iyrVYVz
   YY0ADmJ+IjQ76IBm8+xj/ys6memgwQBmT7ZTuXifr0hM8nazhKJ+bCO6z
   6UHjXExJsvjeQ7dzWLzx6wBgKS8zwJ00eaeQ+Q4r+C9AxMeNk1miln+dz
   HPEOcyKuSLBHiNV8tEG3JcPl8NTPzOb6pEKGFXPHrfWi1SnrvjxA1oHWB
   Q==;
X-CSE-ConnectionGUID: 36DxQ2zrQ2CH/smdorDVBA==
X-CSE-MsgGUID: UxatvV5hSDugwwjFtBX37Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75073401"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="75073401"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 15:24:13 -0700
X-CSE-ConnectionGUID: 5YWR4Y/gTWet3GAJDUAO4Q==
X-CSE-MsgGUID: OIRoU6eERRKOV/nuQq2peg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="247580568"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Mar 2026 15:24:11 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w44je-000000001K5-0cHZ;
	Sat, 21 Mar 2026 22:24:01 +0000
Date: Sun, 22 Mar 2026 06:22:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jovin Basil <jovin555@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, jovin555@gmail.com,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: gpio: replace printk with dev_err in probe
Message-ID: <202603220644.6OGhQIXH-lkp@intel.com>
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
config: csky-randconfig-r073-20260322 (https://download.01.org/0day-ci/archive/20260322/202603220644.6OGhQIXH-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603220644.6OGhQIXH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603220644.6OGhQIXH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from include/linux/i2c-algo-bit.h:13,
                    from drivers/i2c/busses/i2c-gpio.c:11:
   drivers/i2c/busses/i2c-gpio.c: In function 'i2c_gpio_init':
>> drivers/i2c/busses/i2c-gpio.c:493:26: error: 'pdev' undeclared (first use in this function); did you mean 'cdev'?
     493 |                 dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
         |                          ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/i2c/busses/i2c-gpio.c:493:17: note: in expansion of macro 'dev_err'
     493 |                 dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
         |                 ^~~~~~~
   drivers/i2c/busses/i2c-gpio.c:493:26: note: each undeclared identifier is reported only once for each function it appears in
     493 |                 dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
         |                          ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/i2c/busses/i2c-gpio.c:493:17: note: in expansion of macro 'dev_err'
     493 |                 dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
         |                 ^~~~~~~


vim +493 drivers/i2c/busses/i2c-gpio.c

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
