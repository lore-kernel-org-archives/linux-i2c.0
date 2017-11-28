From: kbuild test robot <fengguang.wu@intel.com>
Subject: [wsa:i2c/for-next 3/20] drivers/i2c/i2c-core-base.c:162:19: error:
 implicit declaration of function 'gpio_to_desc'
Date: Wed, 29 Nov 2017 04:43:10 +0800
Message-ID: <201711290402.Q8Ys7S5A%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27892 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbdK1UpM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 15:45:12 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
head:   41493dd4c8b67a3e9857b84f4e59460d09005963
commit: 3991c5c80beaf7eb9bce61e0b2f8f449e351a38e [3/20] i2c: Switch to using gpiod interface for gpio bus recovery
config: m32r-m32104ut_defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3991c5c80beaf7eb9bce61e0b2f8f449e351a38e
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

Note: the wsa/i2c/for-next HEAD 41493dd4c8b67a3e9857b84f4e59460d09005963 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers/i2c/i2c-core-base.c: In function 'get_scl_gpio_value':
   drivers/i2c/i2c-core-base.c:137:9: error: implicit declaration of function 'gpiod_get_value_cansleep' [-Werror=implicit-function-declaration]
     return gpiod_get_value_cansleep(adap->bus_recovery_info->scl_gpiod);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c: In function 'set_scl_gpio_value':
   drivers/i2c/i2c-core-base.c:142:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
     gpiod_set_value_cansleep(adap->bus_recovery_info->scl_gpiod, val);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c: In function 'i2c_get_gpios_for_recovery':
>> drivers/i2c/i2c-core-base.c:162:19: error: implicit declaration of function 'gpio_to_desc' [-Werror=implicit-function-declaration]
     bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
                      ^~~~~~~~~~~~
>> drivers/i2c/i2c-core-base.c:162:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
                    ^
   drivers/i2c/i2c-core-base.c:171:18: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);
                     ^
   cc1: some warnings being treated as errors

vim +/gpio_to_desc +162 drivers/i2c/i2c-core-base.c

   133	
   134	/* i2c bus recovery routines */
   135	static int get_scl_gpio_value(struct i2c_adapter *adap)
   136	{
 > 137		return gpiod_get_value_cansleep(adap->bus_recovery_info->scl_gpiod);
   138	}
   139	
   140	static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
   141	{
 > 142		gpiod_set_value_cansleep(adap->bus_recovery_info->scl_gpiod, val);
   143	}
   144	
   145	static int get_sda_gpio_value(struct i2c_adapter *adap)
   146	{
   147		return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
   148	}
   149	
   150	static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
   151	{
   152		struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
   153		struct device *dev = &adap->dev;
   154		int ret = 0;
   155	
   156		ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
   157				GPIOF_OUT_INIT_HIGH, "i2c-scl");
   158		if (ret) {
   159			dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
   160			return ret;
   161		}
 > 162		bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
   163	
   164		if (bri->get_sda) {
   165			if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
   166				/* work without SDA polling */
   167				dev_warn(dev, "Can't get SDA gpio: %d. Not using SDA polling\n",
   168						bri->sda_gpio);
   169				bri->get_sda = NULL;
   170			}
   171			bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);
   172		}
   173	
   174		return ret;
   175	}
   176	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--6TrnltStXW4iwmi0--
