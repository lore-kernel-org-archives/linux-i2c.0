From: Robert Johnson <rjohnson-8rzVundTyvFXXTqwWWvqD0EOCMrvLtNR@public.gmane.org>
Subject: Is there anyway to write consecutive back-to-back bytes to an 8 bit
 I2C device from userspace?
Date: Fri, 14 Feb 2014 00:07:54 +0000
Message-ID: <70fea12797ce4ab9ae910c75eabf7fb5@SPIEXCHMAIL01.sierraphotonics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

My Freescale P2020 based embedded single board computer (SBC) uses an NXP PCA9670 I2C 8 line GPIO Expander.  I would like to create an active low pulse (idle high, toggle line low and then immediately back high as fast as possible) on one of the GPIO lines that has a stable and consistent pulse width.  The PCA9670 uses 8 bit data and supports multiple consecutive data bytes following the address.  My thought was that if I could get my system to output the I2C address and two data bytes all consecutively back-to-back, then the pulse width should be stable and consistent.  I have tried using i2c-tools i2c-dev.h as shown below both using a write() call and alternatively using a call to i2c_smbus_write_byte_data().  I did not really see a difference between these two options.  In both cases, t
 he pulse width varies quite a bit from about 100 usec to about 3 msec.  So it appears that the bytes are not all going out the I2C master back-to-back consecutively but one at a time with the chance that the CPU gets busy servicing interrupts, etc. between bytes.

The Gentoo Linux distribution for my SBC uses a 3.0.4 kernel.

Please let me know if there is any way to get multiple data bytes to go out on the I2C bus consecutively back-to-back from userspace.  If this is not possible from userspace, what other options would work as desired.

NOTE: the header file i2c-dev.h used was from i2c-tools version 3.1.0

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include "i2c-dev.h"

#define I2CDEV          "/dev/i2c-0"
#define I2CADDR         0x27

int main(void)
{
        int fd;
        char buf[2] = {0xf7, 0xff};

        if ((fd = open(I2CDEV, O_WRONLY)) < 0)
        {
                printf("ERROR: unable to open I2C device %s\n", I2CDEV);
                exit(-1);
        }
        if (ioctl(fd, I2C_SLAVE_FORCE, I2CADDR) < 0)
        {
                printf("ERROR: ioctl call failed, errno=0x%x\n", errno);
                exit(-1);
        }
        while (1)
        {
	// write(fd, buf, 2);
                i2c_smbus_write_byte_data(fd, buf[0], buf[1]);
                sleep(1);
        }
}
