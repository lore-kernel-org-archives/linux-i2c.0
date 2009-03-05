From: Brian Dominy <brian.dominy-4y/IbmOpLWVBDgjK7y7TUQ@public.gmane.org>
Subject: LTC4307 automatic stuck bus recovery
Date: Thu, 5 Mar 2009 14:55:17 +0000 (UTC)
Message-ID: <loom.20090305T144259-929@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I am working with a board which has an LTC4307 I2C bus isolator chip,
connected to an MPC8548 processor.  Occasionally under high CPU load,
we see mysterious I2C errors (bad data, ACK errors).

Our theory is that calls to i2c_wait() inside mpc_write() are blocking
for so long that the LTC4307 thinks the bus is locked up, and resets it.
This chip takes action after only 30ms.  There are several workloads where
we see the process doing the I2C writes is not getting rescheduled in time
to write the next byte.

So my question is this: is this something the I2C code should deal with,
or is this something better pushed up to userspace?  Raising the priority
of the process has shown improvements.  It seems like the kernel code could
at least detect the problem and return an error if the hardware imposes
realtime constraints.

Thanks,
Brian Dominy
