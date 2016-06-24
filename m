From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v9 2/2] Input: synaptics-rmi4 - add SMBus support
Date: Sat, 25 Jun 2016 05:47:31 +0800
Message-ID: <201606250504.23UjMfXF%fengguang.wu@intel.com>
References: <1466779303-8658-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466779303-8658-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.7-rc4 next-20160624]
[cannot apply to input/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/i2c-i801-add-support-of-Host-Notify/20160624-224821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/rmi4/rmi_smbus.c:448:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
