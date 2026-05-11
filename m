Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3336404B;
	Mon, 11 May 2026 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542940; cv=none; b=AnOduxT9+OOjdbbz5nTIOWtpdCrn3aDAPWm4ONptpKfEi+kM6HxblqxMlGJH9xgjLHiOys6zcxpKimfZr7aGOdcpiuLJIfB1iJCd+khrHxDu3dwwZ3VN+3R71nkt7XKCtO+wY84lhsGo5Y1jMZ2kKFT8wiv8jC6RKwGQXUaXl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542940; c=relaxed/simple;
	bh=laBEYaNKfM7jgcWqjWGUNtWf8onOxjtzyhlXSvrloco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcnR+cMIpSokCiQz+vBCPH8LKBMW+rMyjpTiKcciJYMAWBJ2Tyw/PRS7L6edA9300GWYHxOFBK5ORfLRXDm98OqZA4iXtl/+h83v1rbX8G+EwafD0c+MGoKUyDt3YVTF9EatMAgVZTNkRDUv4rKEd+23xWdMkzKpcVoUt8GLkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9EBkTTl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9EBkTTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542939; x=1810078939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=laBEYaNKfM7jgcWqjWGUNtWf8onOxjtzyhlXSvrloco=;
  b=b9EBkTTlLbAt89kFsEvLgh4Br1tMAG+KAalsmreC6daDEW7JFtpiP4nW
   WGhHQZE50pZd0PMoj84vY4/eQhPpdtNFAV6xvdNqo25gksoV6/NHVXOSW
   Y0NlFdPbQH8W6EAFONgzCXRQqhJoGkqm4Rmp+H+EnOpN4OBRJ6rXKf7Ap
   eh74xFMeltIL5V4ALq2KRbG6kkN+APmVhmTRcyYL/BegNbmOBzNs7t2La
   bgNDEh3KCiRq0fupO1AUNbpou8y0dIwaFvJiUyH03dYC31wRB/iPAT7/J
   TYS8D+t4SdiWjnS4bzqh2hWqBDgtqt6jdoaihaLCwnFH9w1rgRhj+xjZn
   g==;
X-CSE-ConnectionGUID: 8ym2PMmARjaQkR8Yx+Sf3w==
X-CSE-MsgGUID: XN7o/TAJTT6b7EzlkWoP6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83314825"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83314825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:42:18 -0700
X-CSE-ConnectionGUID: UWL9er0pR9Sy4KW+D1NhHQ==
X-CSE-MsgGUID: rYl2DJKyTL2duLg31f8TVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="233278432"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 11 May 2026 16:42:16 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMaGM-0000000085Z-02oO;
	Mon, 11 May 2026 23:42:14 +0000
Date: Tue, 12 May 2026 01:42:09 +0200
From: kernel test robot <lkp@intel.com>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>, andi.shyti@kernel.org,
	wsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: convert davinci i2c to dt-schema
Message-ID: <202605120133.lQ1F3qlY-lkp@intel.com>
References: <20260505102626.5726-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505102626.5726-1-chaitanya.msabnis@gmail.com>

Hi Chaitanya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on andi-shyti/i2c/i2c-host]
[also build test WARNING on brgl/gpio/for-next robh/for-next linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaitanya-Sabnis/dt-bindings-i2c-convert-davinci-i2c-to-dt-schema/20260511-231255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20260505102626.5726-1-chaitanya.msabnis%40gmail.com
patch subject: [PATCH] dt-bindings: i2c: convert davinci i2c to dt-schema
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260512/202605120133.lQ1F3qlY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605120133.lQ1F3qlY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/how-to.rst references a file that doesn't exist: Documentation/xxx/xxx.rst
   Warning: Documentation/translations/zh_CN/networking/xfrm_proc.rst references a file that doesn't exist: Documentation/networking/xfrm_proc.rst
   Warning: Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst references a file that doesn't exist: Documentation/Configure.help
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-platform-ayaneo
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/i2c/i2c-davinci.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
   Warning: drivers/net/ethernet/smsc/Kconfig references a file that doesn't exist: file:Documentation/networking/device_drivers/ethernet/smsc/smc9.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/virtual/lguest/lguest.c
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,\b(\S*)(Documentation/[A-Za-z0-9

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
