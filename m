From: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] I2C: I2C controller driver for Intel Moorestown platform
Date: Thu, 23 Apr 2009 17:00:56 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD6136779F1@pdsmsx502.ccr.corp.intel.com>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
 <20090416111436.296cdd12@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090416111436.296cdd12-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

This is a description for the patch:
1. Patch for I2C controller driver for Intel low power platform "Moorestown".
2. The driver depends on a GPIO driver for Intel Moorestown platform.
3. The patch will:
	a. Add i2c_mrst.c and i2c_mrst.h to kernel directory "drivers/i2c/busses"
	b. Add items into kernel files "drivers/i2c/busses/Kconfig" and "drivers/i2c/Makefile".
	c. Modify i2c-boardinfo.c to export i2c_register_board_info() function and add code to detect if a device is already in i2c_board_list.

Thanks
Wen
