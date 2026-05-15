Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BE4C043A
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861176; cv=none; b=QHgDBq2s6Sxcjpf1weqq86YLssHfoRCNWH0PTp8Nr7nvp5L+bn5jvIcE5TVrvwSEWotKVV8+ZaDPCzu3hnLy6JOxvTMf4KhhBcZ3d0dQj+EYmFiGRsvwftjPg11CV4d9dfQHJ069YpXxm4reYFlVq+eDXT55xylz2q3TVP847xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861176; c=relaxed/simple;
	bh=Has4ss4k1lj4VClif8P2Lo72o6dHquvJA7zVIUbAgDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcUg4AZb3LZzUIpUi/hUO2QotQbDByB4cyOcxUZNKCJnsni4HlZgAeXI2jMHd6evvtkFc69inqGLHcNHdXiowvEjjOp23+qfW0yHaQab8IevuL4zUreSf1YSqvoP3AiMmx6PLJgZvvZB/bxbDpNKgJpL80vGX5ZY9nrkmbrUntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grhWynM5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grhWynM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778861176; x=1810397176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Has4ss4k1lj4VClif8P2Lo72o6dHquvJA7zVIUbAgDw=;
  b=grhWynM5IrFEWgNF5jw4FiN0hq4sIe5ODy3CPVTvyap+2l20C9EUPoDU
   oMMStby53CFZMsmnwmLG1FdYWWhkV0y5YKzdisqg4CaxBqTFb9qrlVnJn
   GFLjHsYnHf8AUqqlDqR1qlv3d6BoEk+Bao3wE2cUgSBzLwE0EYs9SpSKH
   IdvxAe21PqoEYH9J9f7AmtQf2AfsNr6/CPM0wl+qHqxNWAcpJ6rtpYEX5
   8vPwgw+8Lel+2G+EFaIIK7OEORwwK6w0mKinbP/Rn0x/E8JGbu591hx0W
   Bz2aRppBluy4UQHtmuauRmjMeyixnJLlb54qoCGVQqR0s7ctBQZ+bHkph
   Q==;
X-CSE-ConnectionGUID: GIGzyYzMRzip2w26SytSZg==
X-CSE-MsgGUID: Gk2gtLUTSgCXrg9T5cuyJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79989194"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79989194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:06:16 -0700
X-CSE-ConnectionGUID: OGxksiCJTI2I/LCBm9autA==
X-CSE-MsgGUID: VU0JTttNTZS/dAzdNhRVeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237868331"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 15 May 2026 09:06:13 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNv3D-00000000933-0GiA;
	Fri, 15 May 2026 16:06:11 +0000
Date: Fri, 15 May 2026 18:05:55 +0200
From: kernel test robot <lkp@intel.com>
To: Peter Bohner <peter@bohner.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Peter Bohner <peter@bohner.me>
Subject: Re: [PATCH] i2c: i2c-stub: support for I2C_FUNC_I2C
Message-ID: <202605151757.fT8a2zYC-lkp@intel.com>
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
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Bohner/i2c-i2c-stub-support-for-I2C_FUNC_I2C/20260515-113705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
patch link:    https://lore.kernel.org/r/20260514081100.381043-1-peter%40bohner.me
patch subject: [PATCH] i2c: i2c-stub: support for I2C_FUNC_I2C
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260515/202605151757.fT8a2zYC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151757.fT8a2zYC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151757.fT8a2zYC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/i2c/i2c-stub.c:157:5: error: call to undeclared function 'krelloc_array'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     157 |                                 krelloc_array(chip->i2c_rw_data, msg->len, 1,
         |                                 ^
>> drivers/i2c/i2c-stub.c:156:15: error: incompatible integer to pointer conversion assigning to 'u8 *' (aka 'unsigned char *') from 'int' [-Wint-conversion]
     156 |                         new_rw_mem =
         |                                    ^
     157 |                                 krelloc_array(chip->i2c_rw_data, msg->len, 1,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     158 |                                               GFP_KERNEL | __GFP_ZERO);
         |                                               ~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/krelloc_array +157 drivers/i2c/i2c-stub.c

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
