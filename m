Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4B1DFFB;
	Mon,  3 Aug 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745739; cv=none; b=MQkuMbwEwg+6i/sGS7MhbgWFErwYLolsOAybfPhVDuOsNpbv00aSoDaYMXyj2Fzru+pml9h0HkCVZ3FLBtS3ZjDFwOsFR4N+egy1C+bo5HB7nTVyeP0b5FgBeeCdg6zGueQeibUtN78wUZYj7foYVNoKpsX6UElf/gESnh2UYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745739; c=relaxed/simple;
	bh=xC3OrNnP/G/fQTfG7vaW1/GEapYnFwmRXLB2yIGlMC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKU4VZZEbNxtk5rP8pGk9/7Wk8moMiYJGzADNEePF2u1tgvGKtCL1zhtBatMhaptR9epb2q50W5NL0RhRi4qT+lqgk8BUnVSc8X2mUtlHf3JS7qvmhCEH7+Ao5jlaRnPA0h2TXLmcfHSlR4EI0aS2OjXMwe0uHiLVMcINVG7mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk7siMCm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk7siMCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785745736; x=1817281736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xC3OrNnP/G/fQTfG7vaW1/GEapYnFwmRXLB2yIGlMC8=;
  b=hk7siMCmiJK1idYtxJqkcQc1JMVSQIxTqCJ33TgFF0Y7f9TW4QvqSW9N
   DvCe7AVy4MOLkMDADxh2RX9TLIawRqqOyP0fKlzkCjFzNeQMxZZpEIJ1E
   VjsJVLoT1dNqKXW5DdDYeeZReOKGKHQ+7lrZ4I09bVnEdpkuntwn2bGZM
   ASnqF2OV59MwR6vnNcBtnbk9sARyBoViHLC+ktNzJbxQ9G8w3dXYZZloT
   dA5gEYYe/+64ixZH8grAkvH/GXQnoYBznB/Zo7IZirhROmPBcm/gLVxS/
   dj1Xzu4fM0xaA3V7kFZE8LpTx3pTPsMwwHbvhMZ872VXE1bTc0vERRQ6V
   w==;
X-CSE-ConnectionGUID: QeA3CivvRVKv2XKuqwh9gw==
X-CSE-MsgGUID: s64aPPsxS9eGb7gExMZdQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="111828634"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="111828634"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 01:28:55 -0700
X-CSE-ConnectionGUID: Ag1Csky0THygb39DjHKQlg==
X-CSE-MsgGUID: Q3rjCMSzRxy8JGh8k8BaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="254882189"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Aug 2026 01:28:53 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqo2U-000000006WT-0ms4;
	Mon, 03 Aug 2026 08:28:50 +0000
Date: Mon, 3 Aug 2026 16:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
	mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
	andi.shyti@kernel.org, sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, naresh.maramaina@oss.qualcomm.com,
	aniket.randive@oss.qualcomm.com
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Message-ID: <202608031643.mPIeogxp-lkp@intel.com>
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>

Hi Aniket,

kernel test robot noticed the following build warnings:

[auto build test WARNING on andi-shyti/i2c/i2c-host]
[cannot apply to linus/master v7.2-rc5 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aniket-Randive/i2c-qcom-geni-Add-dynamic-transfer-timeout-based-on-transfer-length-and-frequency/20260803-151058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260715101805.3615166-1-aniket.randive%40oss.qualcomm.com
patch subject: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260803/202608031643.mPIeogxp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260803/202608031643.mPIeogxp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608031643.mPIeogxp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/i2c/busses/i2c-qcom-geni.c:622 function parameter 'timeout_jiffies' not described in 'geni_i2c_gpi_multi_xfer_timeout_handler'
>> Warning: drivers/i2c/busses/i2c-qcom-geni.c:622 Excess function parameter 'transfer_timeout_msecs' description in 'geni_i2c_gpi_multi_xfer_timeout_handler'
>> Warning: drivers/i2c/busses/i2c-qcom-geni.c:622 function parameter 'timeout_jiffies' not described in 'geni_i2c_gpi_multi_xfer_timeout_handler'
>> Warning: drivers/i2c/busses/i2c-qcom-geni.c:622 Excess function parameter 'transfer_timeout_msecs' description in 'geni_i2c_gpi_multi_xfer_timeout_handler'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
