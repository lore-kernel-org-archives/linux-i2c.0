Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16889233949;
	Wed, 29 Jul 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313442; cv=none; b=LFU0nWWT8JV/zDRLWQPxWKZ8ClzvEfZnUFt7lxEjdj7VMiNOh1QxWKsbhHKn3hFCN512ezBvV5hOzgnqWiHICcHcwWTP/h6oSaz0n0BtKc5TdJb2x3pc99LDzNihxPTcslQwm/bMqGB9iS5HPArQVXlpYRlZM9XhE35LLa7AqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313442; c=relaxed/simple;
	bh=tq9vrjtTvviLiTiJWodCEXWw658FXyeV3V9zaHJ3TWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLal16xthcTXcOKPAxuhcitTHdPGG0nUJqLSft22cHpVkMSQjSqrj1OHsNdAUWpav5ZBpmwsbzzxWla/78HZrQPM43+KZujHUjo2BFYYy25dhjgiN3DQV4enliHTR0TZvK+AEyO9ON/qavCCMYgLwBQow0IvfkuD/jmuKfbs6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU6YkGDK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU6YkGDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785313437; x=1816849437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tq9vrjtTvviLiTiJWodCEXWw658FXyeV3V9zaHJ3TWA=;
  b=AU6YkGDKXA6aRcA4EfMEnRAW3Fc9v4ZlO0Ukk81WyapNMN1mOywydL3N
   jQHlAsY8obKXNnxMwvRUnib8n3T5MtP1FxJ0YRkelCCCJlpBxPaT0GqGf
   T/VdJl0r/Tixq6B5ovfdm/Dw6hqWtE9FQhP+Sy5Dl/EoXF72mvoCtT22z
   EG5S6RluElXZyuWC19v0zHc5kos2MG+SWqRo2/zM1Us8dfpUZBvt/JMIR
   //aYZ0H/5e1gaOCNfv6ol0l655UyvfjHykFZi59ZGZ0Y/XNqdBhSkwcn8
   TAQ6t6bJh3u9z87esZjiVaE14gA/8iAOuxluZt9yt9V1Rou5ZDlakIxWO
   g==;
X-CSE-ConnectionGUID: gaLYpLZiT5u0AtPeErXo/Q==
X-CSE-MsgGUID: vGWo1kv5TECyiTVjVt3miQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86103448"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86103448"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 01:23:49 -0700
X-CSE-ConnectionGUID: H65rOXbXSOCubY5zfAe9NQ==
X-CSE-MsgGUID: /I8oDHGVQWWODkE8Rq9NHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258179306"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 29 Jul 2026 01:23:46 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wozZn-00000000fC3-4BbB;
	Wed, 29 Jul 2026 08:23:44 +0000
Date: Wed, 29 Jul 2026 16:22:57 +0800
From: kernel test robot <lkp@intel.com>
To: Simone Chifari <simone.chifari@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Stefan Schaeckeler <schaecsn@gmx.net>,
	Simone Chifari <simone.chifari@gmail.com>
Subject: Re: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus
 adapter
Message-ID: <202607291626.TnSyWh0f-lkp@intel.com>
References: <20260728122423.358416-2-simone.chifari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728122423.358416-2-simone.chifari@gmail.com>

Hi Simone,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8cd9520d35a6c38db6567e97dd93b1f11f185dc6]

url:    https://github.com/intel-lab-lkp/linux/commits/Simone-Chifari/i2c-imc-skylake-add-Intel-Skylake-X-iMC-SMBus-adapter/20260729-033603
base:   8cd9520d35a6c38db6567e97dd93b1f11f185dc6
patch link:    https://lore.kernel.org/r/20260728122423.358416-2-simone.chifari%40gmail.com
patch subject: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
config: um-randconfig-r133-20260729 (https://download.01.org/0day-ci/archive/20260729/202607291626.TnSyWh0f-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260729/202607291626.TnSyWh0f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607291626.TnSyWh0f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/i2c/busses/i2c-imc-skylake.c:49:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/i2c/busses/i2c-imc-skylake.c:331:28: warning: implicit conversion from 'unsigned long' to 'u32' (aka 'unsigned int') changes value from 18446744073171697664 to 3757113344 [-Wconstant-conversion]
     331 |                 u32 mask = i == c->idx ? ~COMMAND_OUR_BITS : ~0U;
         |                     ~~~~                 ^~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +331 drivers/i2c/busses/i2c-imc-skylake.c

   317	
   318	/*
   319	 * Detect a second master.  Compare the command registers against what this
   320	 * driver left in them: for the channel it drove, only the bits it does not own;
   321	 * for the other channel, all of them.  A difference means firmware, a BMC or
   322	 * CLTT touched the engine while the transfer was in flight, so the result
   323	 * cannot be trusted.
   324	 */
   325	static int imc_check_interference(struct imc_smbus *s, const struct imc_chan *c,
   326					  const struct imc_xfer_state *state)
   327	{
   328		int i;
   329	
   330		for (i = 0; i < ARRAY_SIZE(imc_chans); i++) {
 > 331			u32 mask = i == c->idx ? ~COMMAND_OUR_BITS : ~0U;
   332			u32 expect = state->command[i] & COMMAND_KEEP_MASK;
   333			u32 now = imc_reg(s, imc_chans[i].data);
   334	
   335			if (!((now ^ expect) & mask))
   336				continue;
   337	
   338			dev_warn_ratelimited(s->dev,
   339					     "ch%d command changed under us (0x%08x -> 0x%08x): another master is using the engine\n",
   340					     i, expect, now);
   341			return -EAGAIN;
   342		}
   343	
   344		return 0;
   345	}
   346	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
