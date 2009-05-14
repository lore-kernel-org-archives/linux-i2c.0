From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/1] I2C: I2C controller driver for Intel Moorestown
 platform
Date: Thu, 14 May 2009 09:52:01 +0200
Message-ID: <20090514095201.577b17c4@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
	<20090416111436.296cdd12@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD613677A65@pdsmsx502.ccr.corp.intel.com>
	<0A882F4D99BBF6449D58E61AAFD7EDD62876816C@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD62876816C-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wen,

On Thu, 14 May 2009 15:35:37 +0800, Wang, Wen W wrote:
> Hi Jean,
> 
> After a long discussion with other engineers, we finally got parsing I2C device info table code out of the I2C controller driver. Here is a description for the patch:
> 
> 1. Patch for I2C controller driver for Intel low power platform "Moorestown".
> 2. The driver depends on a GPIO driver for Intel Moorestown platform.
> 3. Patch is based on Linux 2.6.30-rc5.
> 4. Patch 1 will:
> 	a. Add "i2c_moorestown.c" and "i2c_moorestown.h" to kernel directory
> "drivers/i2c/busses"
> 	b. Add items into kernel files "drivers/i2c/busses/Kconfig" and
> "drivers/i2c/Makefile".
> 
> Code for parsing I2C device info table and register the table into I2C core are moved into a separate platform driver under arch/ directory per your comments.

Very good, thank you.

Any news on the possibility to get me a piece of hardware to test the
code?

-- 
Jean Delvare
