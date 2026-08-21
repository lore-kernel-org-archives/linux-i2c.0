Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BF480953;
	Fri, 21 Aug 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310696; cv=none; b=OM4cdFr+1sdXB7DZBkQS4Nym8GHTBm4T87O2BVjSLarJx4kFmm4zw75HpNwiT9up0zulwpLSJdNeI+WkQN9QPEHb1tsUjGzEnSeYSgE+Dvg3d/8ZBmQrUXkDf6+obDHyJ9BGjaV7zIoJqUx36ct5Hp0mOmPH7J205T5nW7a3mnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310696; c=relaxed/simple;
	bh=G4qsN+t5UgXO9pKDlrGNxXYn6SnistljpZuq4z5UJsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVkD45c+zgjiCqVwnNd4o5760wu4al2x1JvW+jreNu1T5AieZt1WfuOPelMKovtw++P9WLRGSnDZcEAcKAp9zbeOC8kcAtFEcDWd3q2L6gOadtXcBk5W+BQHtYOV6Kxb7GxBni7jkm7blqR/AyJimqTRjzpTOFO9eYV+alXWiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsC3ufmj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsC3ufmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787310695; x=1818846695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G4qsN+t5UgXO9pKDlrGNxXYn6SnistljpZuq4z5UJsc=;
  b=gsC3ufmjxgEsFe/CzgboKjJhVFHpUxlNUnsqoR3f+uqFxgTYwR3/V+Bz
   1K/5X+9cXlKM3sD/fOLBzwETlsAkHJbHTTxxIznzKm+e59/9xtPdmfK/A
   fpo9DYVGPd1qDgeK4CghxT60h1flm/sOPB38z4PXdHxCSNAtKUEiMV1uC
   YjEEEyBjLPzXsWn2N8KmlUTaftEVlc0q+Wwj3kHhr+/Mqj9yRhJtaTCnz
   7SVrKbDmLhyUU85wRMRT0gBZs29FVO2aeQ22C9lN/vflxgk/Fch0j2P5E
   C0Jyjgxd21QmRlU7MC+9ZNinixytL5/UkLHLh7s9zPzvED3x3hIFyJrkZ
   A==;
X-CSE-ConnectionGUID: XHGae6VbTNOu1DLOnOgdWw==
X-CSE-MsgGUID: T07R57PqTcKCIoL7dJSSrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87776346"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87776346"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 04:11:34 -0700
X-CSE-ConnectionGUID: /pKJlKLZQBS+cJSz6ZSKFw==
X-CSE-MsgGUID: I0Z0KE3kQI2pfkI7eWmRew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289846566"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2026 04:11:31 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxN9k-00000000pmz-2UIv;
	Fri, 21 Aug 2026 11:11:28 +0000
Date: Fri, 21 Aug 2026 19:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Michal Simek <monstr@monstr.eu>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: Re: [PATCH v5] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Message-ID: <202608211944.Zpc0ks4e-lkp@intel.com>
References: <20260820-i2c-xiic-restore-runtime-pm-teardown-v5-1-ca5db9605508@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-i2c-xiic-restore-runtime-pm-teardown-v5-1-ca5db9605508@nexthop.ai>

Hi Abdurrahman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d58772d8520c7ef247c4b95c9bd76d3a25da9ff5]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdurrahman-Hussain/i2c-xiic-restore-non-managed-runtime-PM-to-fix-clk-WARN-flood/20260820-052507
base:   d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
patch link:    https://lore.kernel.org/r/20260820-i2c-xiic-restore-runtime-pm-teardown-v5-1-ca5db9605508%40nexthop.ai
patch subject: [PATCH v5] i2c: xiic: restore non-managed runtime PM to fix clk WARN flood
config: openrisc-randconfig-r072-20260821 (https://download.01.org/0day-ci/archive/20260821/202608211944.Zpc0ks4e-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.4.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608211944.Zpc0ks4e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608211944.Zpc0ks4e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/i2c/busses/i2c-xiic.c:106 struct member 'irq' not described in 'xiic_i2c'
>> Warning: drivers/i2c/busses/i2c-xiic.c:106 struct member 'irq' not described in 'xiic_i2c'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
