From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/6] Add Advantech iManager MFD core driver
Date: Sun, 10 Jan 2016 18:11:21 +0800
Message-ID: <201601101824.AkFMl8i2%fengguang.wu@intel.com>
References: <1452417046-28384-1-git-send-email-richard.dorsch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452417046-28384-1-git-send-email-richard.dorsch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net, wim@iguana.be, jo.sunga@advantech.com, Richard Vidal-Dorsch <richard.dorsch@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Richard,

[auto build test WARNING on hwmon/hwmon-next]
[also build test WARNING on v4.4-rc8 next-20160108]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/richard-dorsch-gmail-com/Add-Advantech-iManager-EC-driver-set/20160110-171635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mfd/imanager-core.c:248:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
