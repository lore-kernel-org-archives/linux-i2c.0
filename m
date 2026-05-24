Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795E19CCF5;
	Sun, 24 May 2026 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779587292; cv=none; b=BIK52nABkCaJHoyrm/sB9Gj/QEnVLz23MA6xhrfZ/oms5YIcpzcG5D0xhXP4pf5P2erOMpPnrrKHdOZSnGwKI7V8hjx5tGxaNv7Mwvi3Dym3DsnIbFkMkNnh9nOqJ5rzxu3/RyK/OTYuy0YgjOkVR4HQmbJkLeBkt+Ik9HYXIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779587292; c=relaxed/simple;
	bh=vg/c7TJDu10FRRVuGSAd+E5BQF3Qfcy4XMIuLXw/Hzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BamL/isChlJXtlwCVu5+8/Rw+wT0gEAWTKdXBimcopele8oOPFNZ4tlNiOmCmJPdZ74i890fNlvtk53MFguJdUNnF+K16lc+B0XUMFq6VCwAPpgw0ji/Scok2nsGjpz3p/iEXAB9yucDwkch+wmMaRMEN/E5deCBnoUbXBHypBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mutJeXeY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mutJeXeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779587291; x=1811123291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vg/c7TJDu10FRRVuGSAd+E5BQF3Qfcy4XMIuLXw/Hzo=;
  b=mutJeXeYTyTUVvHIxym5aNj6fVoqa2EiaTs0SlUImseVKfb2evseK0y4
   L6XNIYwHv5bjHiK+Hdxjw3Wnbv1PEfukSam+ZLxwxQ28mTEMmQHirCgQU
   apmPQ4ZkmILuG0L9D7jb1IRHp/0339su38rFiHocuL0rG+T77af3SdVzC
   rao5rht2L564XdSsTsf5kzOFMV5Kd0jxJP0eEDaDSG8/84B93shf9UUzb
   Ca7m4JNwHPEE55LK68imqBdvSyKMF4n/fvVFJChqGa5W7phJpNZINssGU
   xIqJXZGhEkcy86oNOzHeqrWE3vMg8e7q8eTy7r9qr+p3BkQCB8iWzgYba
   w==;
X-CSE-ConnectionGUID: Jy00w5pjQeiZBFKkOa6qFQ==
X-CSE-MsgGUID: DDbWxNGRTO6zgtVuy+NSow==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="79492351"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="79492351"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 18:48:10 -0700
X-CSE-ConnectionGUID: xHQW8v4kQC+22kGGQWAvCg==
X-CSE-MsgGUID: TY0B7MF7Qh+81Zcg9Va5Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="246337968"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 May 2026 18:48:08 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQxwi-000000000Yz-3y4E;
	Sun, 24 May 2026 01:48:04 +0000
Date: Sun, 24 May 2026 09:47:23 +0800
From: kernel test robot <lkp@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-i2c@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, wsa@kernel.org,
	andriy.shevchenko@intel.com, mario.limonciello@amd.com,
	brgl@bgdev.pl, basavaraj.natikar@amd.com, linus.walleij@linaro.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: Re: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <202605240959.Kcf1lIg4-lkp@intel.com>
References: <20260523174440.9629-2-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523174440.9629-2-hardikprakash.official@gmail.com>

Hi Hardik,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3812a9e84265a5cdd90d29fe8d97a023e91fb945]

url:    https://github.com/intel-lab-lkp/linux/commits/Hardik-Prakash/i2c-designware-defer-probe-if-child-GpioInt-controllers-are-not-bound/20260524-014648
base:   3812a9e84265a5cdd90d29fe8d97a023e91fb945
patch link:    https://lore.kernel.org/r/20260523174440.9629-2-hardikprakash.official%40gmail.com
patch subject: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt controllers are not bound
config: x86_64-randconfig-001-20260524 (https://download.01.org/0day-ci/archive/20260524/202605240959.Kcf1lIg4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605240959.Kcf1lIg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-designware-platdrv.c:192:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     192 |         int ret;
         |             ^
   1 warning generated.


vim +/ret +192 drivers/i2c/busses/i2c-designware-platdrv.c

   187	
   188	static int check_child_gpioint(struct acpi_device *adev, void *data)
   189	{
   190		struct gpio_dep_ctx *ctx = data;
   191		struct list_head res_list;
 > 192		int ret;
   193	
   194		INIT_LIST_HEAD(&res_list);
   195	
   196		ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
   197		acpi_dev_free_resource_list(&res_list);
   198	
   199		if (ctx->ret < 0)
   200			return ctx->ret;
   201	
   202		return 0;
   203	}
   204	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
