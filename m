From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/3] i2c: Add Qualcomm CCI I2C driver
Date: Thu, 5 Mar 2020 14:25:21 +0800
Message-ID: <202003051425.OOtmUt0n%lkp@intel.com>
References: <1583340776-27865-1-git-send-email-loic.poulain@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583340776-27865-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, wsa@the-dreams.de, vkoul@kernel.org, bjorn.andersson@linaro.org, robert.foss@linaro.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>, Todor Tomov <todor.tomov@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Hi Loic,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on robh/for-next v5.6-rc4 next-20200304]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Loic-Poulain/i2c-Add-Qualcomm-CCI-I2C-driver/20200305-051618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-qcom-cci.c:261:49-50: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
