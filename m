From: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Retry count for i2c-mux
Date: Sun,  8 Dec 2013 11:48:19 +0100
Message-ID: <1386499701-5522-1-git-send-email-eliedebrauwer@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

I bumped into an issue where I needed to rely on the retry mechanism. I 
have a master controller and some muxed busses. However when testing
I observed that the retry worked when using the bus attached to the master
controller directly used the retry count set but the same behavior failed
on the muxed bus since the retry count there was zero. The root cause 
was in the creationg of the muxed busses which have their own 
struct i2c_adapter which gets kzalloc in i2c_add_mux_adapter(), my (trivial)
patch to this problem is to also copy the retries field of the parent to 
the i2c_adapter of the muxed bus.

(Obviously the retry count could be set by the I2C_RETRIES ioctl, but I'd
still think it's sensible to have a system initialized in a sane state).

my 2 cents
E. 


Elie De Brauwer (1):
  i2c-mux: Inherit retry count from parent controller for muxed bus.

 drivers/i2c/i2c-mux.c |    1 +
 1 file changed, 1 insertion(+)

-- 
1.7.10.4
