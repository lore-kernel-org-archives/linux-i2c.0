From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: i2c-pnx: Improvements and fixes
Date: Tue, 16 Mar 2010 15:55:34 -0700
Message-ID: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


This patch set fixes a stop condition issue with transfers, caps
the maximum computed divider generated from the parent clock,
and disables the I2C peripheral clock when the I2C bus isn't in
use (to save power).

Patch 3 was previously posted a few months ago, but I didn't
follow up on getting it into the driver.

All code is tested on the lpc3250.
