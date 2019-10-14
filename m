From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/4] i2c: smbus: Add a way to instantiate SPD EEPROMs
 automatically
Date: Mon, 14 Oct 2019 16:55:52 +0200
Message-ID: <20191014165552.1e8ddedc@endymion>
References: <20191014113950.1f989ba6@endymion>
        <201910141823.bXxWHSkl%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201910141823.bXxWHSkl%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Oct 2019 18:21:50 +0800, kbuild test robot wrote:
> Hi Jean,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.4-rc3 next-20191011]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Jean-Delvare/Instantiate-SPD-EEPROMs-at-boot-on-x86/20191014-174252
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/i2c/i2c-core-base.c:24:0:
>    include/linux/i2c-smbus.h: In function 'i2c_register_spd':
> >> include/linux/i2c-smbus.h:52:9: warning: 'return' with a value, in function returning void  
>      return 0;
>             ^
>    include/linux/i2c-smbus.h:50:13: note: declared here
>     static void i2c_register_spd(struct i2c_adapter *adap)
>                 ^~~~~~~~~~~~~~~~
>    In file included from drivers/i2c/i2c-core-base.c:24:0:
>    At top level:
>    include/linux/i2c-smbus.h:50:13: warning: 'i2c_register_spd' defined but not used [-Wunused-function]
> 
> vim +/return +52 include/linux/i2c-smbus.h
> 
>     46	
>     47	#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_DMI)
>     48	void i2c_register_spd(struct i2c_adapter *adap);
>     49	#else
>     50	static void i2c_register_spd(struct i2c_adapter *adap)
>     51	{
>   > 52		return 0;  
>     53	}
>     54	#endif
>     55	

Fixed, thanks Elliot.

-- 
Jean Delvare
SUSE L3 Support
