From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Q: Where to initialize class attribute of adapter
Date: Tue, 14 Apr 2009 09:41:50 +0200
Message-ID: <49E43E3E.1020200@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

on update to kernel to 2.6.29 I've run into the issue that I2C adapter's
class attribute in struct i2c_adapter wasn't set and so no client driver
could be loaded.
Currently I initialize .class in the struct declaration part, but this
is main code for all boards that use this adapter :-( I'm now searching
for a place where to do it in a board specific way like device tree.
Any suggestions?

-- 
Kind Regards,
Michael
