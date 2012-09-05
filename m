From: "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: multiple slave addresses for single I2C chip
Date: Wed, 5 Sep 2012 04:50:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88B9367A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I'm new to Linux I2C community. So let me say "Hello!" here.

We are trying to drive some sensors on Linux. The sensors are connected to the board as I2C slaves.
I noticed the i2c_board_info can be used to register i2c slaves for the embedded platforms.
I noticed there's also "address_list" member in the i2c_driver which can be used to detect the I2C slaves.
The first question is: Which one shall I use to draft my sensor codes?

If i2c_board_info is used to register platform i2c slaves, there is another issue for me:
One of the sensors has 2 slave addresses. I noticed only one slave address can be declared in one i2c_board_info.
The second question is: Shall I register the sensor's resource using 2 i2c_board_info? By doing this, shall I draft a single .c file containing 2 "i2c_driver" for them?

Best regards/Lv Zheng
