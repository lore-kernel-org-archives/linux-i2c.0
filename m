From: =?UTF-8?B?Um9iaW4gTcO8bGxlci1CYWR5?= <mueller-bady-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Subject: Writing I2C Sensor Kernel Modules
Date: Thu, 27 Jun 2013 16:33:34 +0200
Message-ID: <CACRdhnDOKdfFSPKmBZ=BoEfp4Tk3dur539b+eHw_bxm23H0rsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I have a (architectural design) question about I2C drivers in kernel space.
Currently, I'm writing userspace software for using external sensors
on an raspberry pi via bcm2835's I2C bus with the help of
wiringPi/ioctl, e.g. the barometric pressure with the MPL115A2 sensor.

I now had the idea to write the software directly in kernel space,
providing a device, e.g. /dev/mpl115a2, for polling the sensor data.
Does this idea fit into the architectural design of the I2C subsystem
/ the sensors ? Or should code for handling I2C clients stay in
userspace?
Is there any good documentation for writing such drivers except the
kernel Documentation? I found some information in the kernel wiki
which is unfortunately not that detailed.

Regards,

Robin
