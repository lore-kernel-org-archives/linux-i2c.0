From: kbuild test robot <lkp@intel.com>
Subject: Re: [patch 2/2] i2c: mux: mellanox: add driver
Date: Thu, 25 Aug 2016 14:50:30 +0800
Message-ID: <201608251408.feJ5zXcz%fengguang.wu@intel.com>
References: <1472046988-111956-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472046988-111956-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

Hi Vadim,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.8-rc3 next-20160824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/vadimp-mellanox-com/i2c-add-master-driver-for-mellanox-systems/20160824-200057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/i2c/muxes/i2c-mux-mlxcpld.c:329:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
