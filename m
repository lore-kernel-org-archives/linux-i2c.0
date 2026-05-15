Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141D266581
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849653; cv=none; b=k60VI3Gv6HaHD0sZwj5O+Z1j6v/Xom8wjhzRtt8sLwVFAuyCt0mg6qEuToZiF+V8vlTHtZ7KwjtN2fFJPX/EEmfgcAZx8ATByMy5KzouYr0G8LFmOCwovJM1AKlnxM5njE2G0RphiIcMFkY5uJdIe6APnop4pbFJ3IH2w7Ombio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849653; c=relaxed/simple;
	bh=lf4nQpl2lugu/5vox4NgWs4bDh/LZjVUxiKgsvwxyqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3EYj1ImTWN10pDf0qJ2Bz5D5+6aA2TGxisCzJg7opDCtdlPWzTYTuH0AC39EriuFEdJ/1SvnFPMc7rcoRuPH7+09/7D0a9U5rt5LDUaNNuUk5Fkujx7CMp9RRYsaswm+fzDN0K9Om7KeBRzu9dq6sKBeu0zjPHyE43a5OrYAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbwNMu1U; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbwNMu1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778849652; x=1810385652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lf4nQpl2lugu/5vox4NgWs4bDh/LZjVUxiKgsvwxyqY=;
  b=DbwNMu1UGwqajeFTj0fEi4GVAe0opjdnV0TfX7uUolAZDCjSg0yO/fL1
   Oy1Pn2vKx7IfTu6sUvnY7dFUwLK0xs/aKsv1ob4RZFhK/008GcXnVBmiX
   5QbiYAy65px0erbtwZymIa7GfngfvfuvtHNfF8c231ofYjmZMlrctBSgs
   Jv51kuQBWuIAsj09b5t6HV5z4kssUvAlpG9+z93D4k1DwXi4qujR4VAGD
   wNDC37pQuFVYbA/8Yx1uaXMl3x2U360aEDZINqO+sHqRZITnPmuPsP5qp
   GKIW6AgZ0ELHQu85++5xNBJkdoVTPH9DSaTIcO/8GsXaz7ww0ahr/35sB
   Q==;
X-CSE-ConnectionGUID: Kdy6AfsfQ9OKvhdcnsBlBQ==
X-CSE-MsgGUID: scWbWRJRQ5Gk2O/2LgMynQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79764298"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79764298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:54:11 -0700
X-CSE-ConnectionGUID: YCyjl2a7T+63kW7QuH0xTA==
X-CSE-MsgGUID: y19sN5l6QOu1ozfMev332w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232286734"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 15 May 2026 05:54:10 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNs3L-000000008zh-3gST;
	Fri, 15 May 2026 12:54:07 +0000
Date: Fri, 15 May 2026 14:53:28 +0200
From: kernel test robot <lkp@intel.com>
To: Peter Bohner <peter@bohner.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Bohner <peter@bohner.me>
Subject: Re: [PATCH] i2c: i2c-stub: support for I2C_FUNC_I2C
Message-ID: <202605151418.JKwPcs0v-lkp@intel.com>
References: <20260514081100.381043-1-peter@bohner.me>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514081100.381043-1-peter@bohner.me>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on linus/master v6.16-rc1 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Bohner/i2c-i2c-stub-support-for-I2C_FUNC_I2C/20260515-113705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
patch link:    https://lore.kernel.org/r/20260514081100.381043-1-peter%40bohner.me
patch subject: [PATCH] i2c: i2c-stub: support for I2C_FUNC_I2C
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260515/202605151418.JKwPcs0v-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151418.JKwPcs0v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151418.JKwPcs0v-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/i2c/i2c-stub.c: In function 'stub_xfer':
>> drivers/i2c/i2c-stub.c:157:33: error: implicit declaration of function 'krelloc_array'; did you mean 'krealloc_array'? [-Wimplicit-function-declaration]
     157 |                                 krelloc_array(chip->i2c_rw_data, msg->len, 1,
         |                                 ^~~~~~~~~~~~~
         |                                 krealloc_array
>> drivers/i2c/i2c-stub.c:156:36: error: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     156 |                         new_rw_mem =
         |                                    ^


vim +157 drivers/i2c/i2c-stub.c

   140	
   141	static s32 stub_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
   142	{
   143		int i;
   144		u8 *new_rw_mem;
   145		struct stub_chip *chip = NULL;
   146		struct i2c_msg *msg;
   147	
   148		for (i = 0; i < num; i++) {
   149			msg = msgs + i;
   150			chip = stub_addr_to_chip(msg->addr);
   151			if (!chip)
   152				return -ENODEV;
   153	
   154			/* len is guaranteed to be <= 8192 by i2cdev_ioctl_rdwr */
   155			if (chip->i2c_rw_size < msg->len) {
 > 156				new_rw_mem =
 > 157					krelloc_array(chip->i2c_rw_data, msg->len, 1,
   158						      GFP_KERNEL | __GFP_ZERO);
   159				if (!new_rw_mem)
   160					return -ENOMEM;
   161				chip->i2c_rw_data = new_rw_mem;
   162				chip->i2c_rw_size = msg->len;
   163			}
   164	
   165			/* read, size determined by slave */
   166			if ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN)) {
   167				/* i2cdev_ioctl_rdwr expects this as a maximum, even
   168				 * though 0xff would be the theoretically possible
   169				 */
   170				msg->len = min(chip->i2c_rw_size, I2C_SMBUS_BLOCK_MAX);
   171				msg->buf[0] = msg->len - 1;
   172				dev_dbg(&adap->dev,
   173					"i2c read with RECV_LEN - addr 0x%02x, read %u bytes\n",
   174					msg->addr, msg->len);
   175				memcpy(msg->buf + 1, chip->i2c_rw_data, msg->len - 1);
   176			} else if (msg->flags & I2C_M_RD) {
   177				dev_dbg(&adap->dev,
   178					"i2c read - addr 0x%02x, read %u bytes\n",
   179					msg->addr, msg->len);
   180				memcpy(msg->buf, chip->i2c_rw_data, msg->len);
   181			} else {
   182				dev_dbg(&adap->dev,
   183					"i2c write - addr 0x%02x, wrote %u bytes\n",
   184					msg->addr, msg->len);
   185				memcpy(chip->i2c_rw_data, msg->buf, msg->len);
   186			}
   187		}
   188		return num;
   189	}
   190	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
