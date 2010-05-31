From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/4] Clean up address probing and validity checking code
Date: Mon, 31 May 2010 13:22:13 +0200
Message-ID: <20100531132213.65f20b8f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Here comes an update of the patchset I posted on April 9th, 2010. Now
applies cleanly on top of Linus' tree.

[PATCH 1/4] i2c: Share the I2C device presence detection code
[PATCH 2/4] i2c: Check for address validity on client registration
[PATCH 3/4] i2c: Document reserved I2C addresses
[PATCH 4/4] i2c: Rename i2c_check_addr to i2c_check_addr_busy

-- 
Jean Delvare
