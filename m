Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598350;
	b=kq4VdkWxZZB6wpJDn12Et+Wxtn2d0/bmtGanvnQL1sPIPcnVMbEahlpfOVNqGGB9jZMr
	 5iCKfv6AuyUV/CoIJ0DoOUo/GY5XFMhEze6ArDQRqJ+Srke5/H44nyx3ggLwsMApGW+v0
	 I0dK79sS5Oy79eaIZ/MwFkJIv51+JyLGSCjJ1Dz3pCthBn1jkcnEKaklcQAxJKY8Ns5gF
	 KohjMIh25BfyvCdDsvAJBO0OHbo6RKaZjw9OsBm5X84RnfuMMLgoHlEVaKrpsrzJfVs38
	 CT9I6i39bNcdbi3epVkww9bHX5XhzVhaKoudLwyA1Ndqtj/6n/RGtlB+UXuKcSEtAGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U6jYZ+Xb2RUTQwwnMpQL3qOxWFKiJS39xLrqJeDZ5fA=;
	b=4dR0JoNvLxNhLNmPFiquyGrV0MYiLKPN6BP+mClidPFjBx3A1Ed7kCtRdZLA6aDpnHCq
	 d11yIS6fEwhyCCuqPWkQFnU2hDnbphjvs2OIrtesSX5A3fzD9nDWfQx8A8MMOaXUTlY6c
	 PRqHmiCokCCJlLTayo4MhvVZXIc7is3XZ58CUO9ydLb7DP1mAtzOcadf0TVB/uq4dHzd6
	 r9SE/4wU9RdFvu4eApNaiFX1tc8wlDNa2wnSNcq7EMrhUpwse6uZGDcwUFTfK5ZB2psJ5
	 Ofr3KXXGetWpQIHyQfKlgiij48AqC4JszZpG7mbU73ZbOQDbYBg8cYIImLYzuArZd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NsPUYV1G;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782A606A333;
	Fri, 13 Nov 2026 19:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7782A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NsPUYV1G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794598349; x=1826134349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C16sG7RV76XLEk2qA+4C2ckJRlKBWDd3KFO09Alt5n4=;
  b=NsPUYV1GUS3JXTTSwc3YSJ5jwFLGAOJR6NwSF+Pz/0NKiWhpzE5S+L/R
   PeZil3MS+pbSEXlZjlXyD6iVMpelpM89ylxIKysUdWnKaRTCqPyXG7+4O
   myP9Roj7Fu1c67ehkNAAsqaV5b6HrKY3OwWXm8jOK85wR1oEw1SWTSa13
   lX3ZeOBXl7uD3A/HrLfF4Rcxtx3P4V6O/eF1x5wnVuS6ssDNianERImNx
   bVY+1FaSYXF9DjlUTOOGA0s1u7vvfBn4u5PdkBDpz10x1M2k+c2SM1+wH
   5JDjcpnriOWCGnIYrVaIvr6zRHIeAPenhqsi6e3oSkDENCqC9+AWjfKs4
   w==;
X-CSE-ConnectionGUID: tqYZ6CGjTcOvVOkYjaBviw==
X-CSE-MsgGUID: N9OB8YGGTeuJgXnHUX9tkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3412651"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3412651"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:32:28 -0800
X-CSE-ConnectionGUID: vuBoyPenQ9GazlmpB0O6zA==
X-CSE-MsgGUID: WCFSVtONQaugQB+cZYtX7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="10784803"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 13 Nov 2026 11:32:23 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRx0W-000000013o9-39fS;
	Fri, 13 Nov 2026 19:32:20 +0000
Date: Sat, 14 Nov 2026 03:31:43 +0800
From: kernel test robot <lkp@intel.com>
To: John Crispin <john@phrozen.org>, Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, lei.dong@airoha.com,
	Linqi.zhang@airoha.com, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Rajeev.kumar@airoha.com,
	upstream@airoha.com, Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: Re: [PATCH v2 3/3] i2c: mt7621: add support for Airoha AN7589
Message-ID: <202611140348.p9TnfxBF-lkp@intel.com>
References: <20261112185820.1315718-4-john@phrozen.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112185820.1315718-4-john@phrozen.org>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on andi-shyti/i2c/i2c-host linus/master v7.4-rc2 next-20261112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Crispin/dt-bindings-i2c-mt7621-add-Airoha-AN7589/20261112-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20261112185820.1315718-4-john%40phrozen.org
patch subject: [PATCH v2 3/3] i2c: mt7621: add support for Airoha AN7589
config: sparc-randconfig-1000-20261113 (https://download.01.org/0day-ci/archive/20261114/202611140348.p9TnfxBF-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611140348.p9TnfxBF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611140348.p9TnfxBF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'mtk_i2c_init',
       inlined from 'mtk_i2c_probe' at drivers/i2c/busses/i2c-mt7621.c:364:2:
>> include/linux/compiler_types.h:702:38: error: call to '__compiletime_assert_437' declared with attribute error: clamp() low limit div_min greater than high limit div_max
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:683:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
     ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
     __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
     ^~~~~~~~~~~~
   include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
    #define clamp(val, lo, hi) __careful_clamp(auto, val, lo, hi)
                               ^~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-mt7621.c:308:17: note: in expansion of macro 'clamp'
     i2c->clk_div = clamp(rate / i2c->bus_freq - 1, div_min, div_max);
                    ^~~~~


vim +/__compiletime_assert_437 +702 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  689  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  690  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  691  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  692  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  693   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  694   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  695   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  696   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  698   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  699   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  700   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  701  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @702  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  703  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
