Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA013BAD84
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266126; cv=none; b=VIHf+H4G6MNjA4ANPWM9GNQFy9DgitpL0sj8qgmjFc/8QQtXb8jOe3Q3o3xe1lUu4XJmY0LQqFUWOURJGZCiRAlNzg1lMGBROaPQfvsspMspAO1/s0O9XRvpdW2+sWDZTkM9AARWtqUYEYfCILArJpsIEAUuDPvMN0dOCA2KsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266126; c=relaxed/simple;
	bh=PkzvHbrNTDZ17MXaHSWQaIqklFjFamgd0ik0JLfkS2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj1ouaOrvqY9OkYXJbL69Vy3MF09/kDQBRLyk1BVU8ygI6ae09/oRNT4Tv+vN2tSE4d2pOMDpo+yDqgccqDgATdnzPPw4fu5kM4+m9CF73eQcrXm/7Myj+sjAC15hMP0tr59u+RInDT3DaZ9ryNHtnbgwXAconvCSIRzzviYi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4lTMJUp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4lTMJUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779266124; x=1810802124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkzvHbrNTDZ17MXaHSWQaIqklFjFamgd0ik0JLfkS2s=;
  b=b4lTMJUphkq6PV3WIN8C5GYPvbX+ktvuRSjZpes9ANf4xdPTfW1nerE1
   SqdtwG4GOzmuSzcqXjblpM4gotEB+3nhZg+7pEbnICofKT7tS/uf52QbH
   cgWB0hO7+aPAtlXWtYNShn17Dd58VAW95u27xTLTKymzokf9GVP9zN3Zc
   Qawkj+DUFNOKV2V0dt1xtpMFwgslFn7tLy/1taKnALI+7hmsqgpkNvaU5
   sxvsUzmiiar6wctvARMD1QOheRD3H+/kVXT+9SAiZA4Q86eIkxyioRt6q
   jbhiDb3vxl5oFep4dWkNAvzsI83hwSFIowemwpwhh/hjOQU3CKOAt4iyK
   g==;
X-CSE-ConnectionGUID: xR+HkOWaQPSnWZIo0zbzIg==
X-CSE-MsgGUID: bZZJa4YeTgG3geXYi29eXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84040904"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="84040904"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:35:23 -0700
X-CSE-ConnectionGUID: 9aD/ZDHlSYaHpgW6YSFdZA==
X-CSE-MsgGUID: uqV8PCUjTRe/54HVv9vCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237091483"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 01:35:21 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPcO5-000000002p3-1Tqz;
	Wed, 20 May 2026 08:34:51 +0000
Date: Wed, 20 May 2026 16:32:21 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Pasternak <vadimp@nvidia.com>, peda@lysator.liu.se
Cc: oe-kbuild-all@lists.linux.dev, wsa@the-dreams.de,
	linux-i2c@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>
Subject: Re: [PATCH i2c-mux next 1/1] i2c: mux: Add register map based mux
 driver
Message-ID: <202605201604.3O39wIat-lkp@intel.com>
References: <20260519174310.1128423-1-vadimp@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519174310.1128423-1-vadimp@nvidia.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260519]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Pasternak/i2c-mux-Add-register-map-based-mux-driver/20260520-014530
base:   next-20260519
patch link:    https://lore.kernel.org/r/20260519174310.1128423-1-vadimp%40nvidia.com
patch subject: [PATCH i2c-mux next 1/1] i2c: mux: Add register map based mux driver
config: hexagon-randconfig-r061-20260520 (https://download.01.org/0day-ci/archive/20260520/202605201604.3O39wIat-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201604.3O39wIat-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201604.3O39wIat-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/muxes/i2c-mux-regmap.c:121:44: warning: variable 'mux' is uninitialized when used here [-Wuninitialized]
     121 |         i2c_mux_regmap_notify_probe_abandon(pdev, mux, muxc, parent, ret,
         |                                                   ^~~
   drivers/i2c/muxes/i2c-mux-regmap.c:72:28: note: initialize the variable 'mux' to silence this warning
      72 |         struct i2c_mux_regmap *mux;
         |                                   ^
         |                                    = NULL
   1 warning generated.


vim +/mux +121 drivers/i2c/muxes/i2c-mux-regmap.c

    67	
    68	/* Probe/remove functions */
    69	static int i2c_mux_regmap_probe(struct platform_device *pdev)
    70	{
    71		struct i2c_mux_regmap_platform_data *pdata = dev_get_platdata(&pdev->dev);
    72		struct i2c_mux_regmap *mux;
    73		struct i2c_adapter *parent;
    74		struct i2c_mux_core *muxc = NULL;
    75		bool user_notify_called = false;
    76		int num, ret;
    77	
    78		if (!pdata)
    79			return -EINVAL;
    80	
    81		parent = i2c_get_adapter(pdata->parent);
    82		if (!parent)
    83			return -EPROBE_DEFER;
    84	
    85		muxc = i2c_mux_alloc(parent, &pdev->dev, pdata->num_adaps, sizeof(*mux), 0,
    86				     i2c_mux_regmap_select_chan, i2c_mux_regmap_deselect);
    87		if (!muxc) {
    88			ret = -ENOMEM;
    89			goto err_put_parent;
    90		}
    91	
    92		mux = i2c_mux_priv(muxc);
    93		memcpy(&mux->pdata, pdata, sizeof(*pdata));
    94		platform_set_drvdata(pdev, muxc);
    95		mux->last_val = -1; /* force the first selection */
    96	
    97		/* Create an adapter for each channel. */
    98		for (num = 0; num < pdata->num_adaps; num++) {
    99			ret = i2c_mux_add_adapter(muxc, 0, pdata->chan_ids[num]);
   100			if (ret)
   101				goto err_i2c_mux_add_adapter;
   102		}
   103	
   104		/* Notify caller when all channels' adapters are created. */
   105		if (pdata->completion_notify) {
   106			ret = pdata->completion_notify(pdata->handle, muxc->parent,
   107						       muxc->adapter);
   108			user_notify_called = true;
   109			if (ret)
   110				goto err_i2c_mux_add_adapter;
   111		}
   112	
   113		return 0;
   114	
   115	err_i2c_mux_add_adapter:
   116		i2c_mux_regmap_notify_probe_abandon(pdev, mux, muxc, parent, ret,
   117						    user_notify_called);
   118		i2c_mux_del_adapters(muxc);
   119		goto put_parent;
   120	err_put_parent:
 > 121		i2c_mux_regmap_notify_probe_abandon(pdev, mux, muxc, parent, ret,
   122						    user_notify_called);
   123	put_parent:
   124		i2c_put_adapter(parent);
   125	
   126		return ret;
   127	}
   128	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
