From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Use the Linux I2C subsystem for a two wire interface protocol
Date: Tue, 14 Jul 2009 11:25:56 -0500
Message-ID: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
I was looking at  the implementation of the i2 dev interface and the
bitbanging interface supplied by kernel v 2.6.24.  What i intend to do
is use the i2c kernel subsystem to write a userspace driver(using the
dev - ioctl interface) for a sensor SHT11 which uses a two wire
interface and a protocol with a packet structure which is different
from traditional I2C.

>From the header files and the API's therein, it looks like the
bitbanging interface should allow any  protocol header to be passed
as a "payload"(void *data) to the linux kernel i2c bitbanging driver
using gpio api.  Please let me know if this is a correct approach if
we intend to write a sensore driver with a proprietary 2 wire
interface protocol.

This would allow us to write  a user-space driver which is more
generic for the sensor and that can be changed to a I2C driver if the
GPIOs are later or tied in hardware to a  dedicated I2C controller. We
are using the mx31 pdk

Please let me know.
-Alfred.
