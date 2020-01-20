From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] HID: mcp2221: add usb to i2c-smbus host bridge
 driver
Date: Tue, 21 Jan 2020 02:05:39 +0800
Message-ID: <202001210143.iPz2kWmQ%lkp@intel.com>
References: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, jikos@kernel.org, benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Rishi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.5-rc7 next-20200117]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Rishi-Gupta/HID-mcp2221-add-usb-to-i2c-smbus-host-bridge-driver/20200120-133043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git def9d2780727cec3313ed3522d0123158d87224d
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-131-g22978b6b-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/hid/hid-mcp2221.c:397:5: sparse: sparse: symbol 'mcp_smbus_xfer' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
