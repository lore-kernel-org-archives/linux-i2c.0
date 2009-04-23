From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/1] I2C: I2C controller driver for Intel Moorestown
 platform
Date: Thu, 23 Apr 2009 11:29:35 +0200
Message-ID: <20090423112935.306ba11a@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
	<20090416111436.296cdd12@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD6136779F1@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD6136779F1-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wen,

On Thu, 23 Apr 2009 17:00:56 +0800, Wang, Wen W wrote:
> Hi Jean,
> 
> This is a description for the patch:
> 1. Patch for I2C controller driver for Intel low power platform "Moorestown".
> 2. The driver depends on a GPIO driver for Intel Moorestown platform.
> 3. The patch will:
> 	a. Add i2c_mrst.c and i2c_mrst.h to kernel directory "drivers/i2c/busses"

Why such a cryptic name? You know, this isn't MS-DOS, names can be
longer than 8 characters ;)

> 	b. Add items into kernel files "drivers/i2c/busses/Kconfig" and "drivers/i2c/Makefile".
> 	c. Modify i2c-boardinfo.c to export i2c_register_board_info() function and add code to detect if a device is already in i2c_board_list.

This last item should go to a separate patch, so that it can be
discussed. It is not clear to me why you would need to export functions
nobody else needed to export. It will be easier to review and merge
your code if the bus driver itself is in one patch and any required
integration changes are in another.

Thanks,
-- 
Jean Delvare
