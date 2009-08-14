From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: "I2C_RDWR" ioctl returning EINVAL on Freescale mxc
Date: Fri, 14 Aug 2009 16:09:21 -0500
Message-ID: <528f13590908141409g4b2556e5m10aec0dc15429457@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

In my userspace driver for a temp sensor on a i2c bus, i am using the
/dev interface.  When i use plain read/write syscalls , they seem to
work just fine. But when i use a combined read/write using the IOCTL
"I2C_RDWR", i get a return of invalid argument i.e EINVAL from the
kernel space i2c dev/bus driver.

int rest  = ioctl(_fd, I2C_RDWR,  trans );

So basically res gets a value<1 on execution. I am putting in the
correct slave address. i have double checked on it. What could be the
other obvious reasons? Could endian ness be an issue as well although
the userspace is really invisible and if that had been the case i
would not have got acks from the slave for a i2c scan on the bus.
i checked the kernel bus driver code for the reason, but cannot figure
out just by reading the code at this point  as i have a broken h/w.
iam using the freescale  mxc i2c bus driver on the kernel side.

Any clues?
Thanks in advance.
-Alfred.
