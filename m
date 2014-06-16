From: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C Slave monitor mode support
Date: Mon, 16 Jun 2014 15:27:26 +0530
Message-ID: <CAD6G_RRa9C0umBrR6CUF3zb5cSKKfZO7y7UPUKHjJOx41A0aJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Few of the I2C interfaces are [operated] with slave monitor mode, when
there is a requirement for
a particular slave may need to wait some time to get the ADDR before
sending an ACK.

In slave monitor mode, the I2C interface is set up as a master and
continues to attempt a transfer to
a particular slave until the slave device responds with an ACK.

This feature is an optional and defined in few of the controllers, Can
anyone tell me is this support is
added already in kernel, if yes please point to the respective driver
or code link.

thanks!
-- 
Jagan.
