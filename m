From: kbuild test robot <lkp@intel.com>
Subject: Re: [RESEND PATCH v1 3/6] i2c: i2c-stm32f7: Add initial SMBus
 protocols support
Date: Tue, 13 Mar 2018 20:52:26 +0800
Message-ID: <201803132034.7iIeYSyJ%fengguang.wu@intel.com>
References: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
List-Id: linux-i2c@vger.kernel.org

Hi Pierre-Yves,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-different-features-for-I2C/20180313-193102


coccinelle warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-stm32f7.c:995:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:944:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:875:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
