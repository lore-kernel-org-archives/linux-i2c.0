From: Aleksander Dutkowski <aleek998-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: trouble with PCA9555 driver on AIMB 210
Date: Tue, 11 Dec 2012 15:02:58 +0100
Message-ID: <CABkKHSZQqaegLW4Kg8OSh4d30qd5V98JBHtPn7M=Luz1qeTMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hello!

I have AIMB 210 motherboard with PCA9555 gpio chipset:

$ uname -a
Linux 3.4.7 #14 SMP i686 GNU/Linux


I compiled the PCA953x driver, but failed to run it:

# echo pca9555 0x20 > /sys/bus/i2c/devices/i2c-0/new_device
pca953x: 0-0020: failed to request irq 0
pca953x: probe of 0-0020 failed with error -16
i2c i2c-0: new_device: Instantiated device pca9555 at 0x20
# ls /sys/class/gpio
export unexport

I started to dig into the driver, and when disabling interrupt by
seting pca953x_probe variable irq_base to -1:
int irq_base = -1;

I got this:
# echo pca9555 0x20 > /sys/bus/i2c/devices/i2c-0/new_device
gpiochip_add: registered GPIOs 240 to 255 on device: pca9555
i2c i2c-0: new_device: Instantiated device pca9555 at 0x20
# ls /sys/class/gpio/gpiochip240
export gpiochip240 unexport
# ls /sys/class/gpio/gpiochip240
base device label gpio power/ subsystem uevent

There is lack of gpio folder, where I could read/write gpio values. So
it seems like, interrupt code is buggy. I dont use FDT, so I dont have
interrupts property.
Since, I'm not fluent with linux device drivers, I ask for some help.
It seems like, there is a bug in pca953x_irq_setup() (the one for IRQ
enabled)
irq_alloc_descs() from line 498 returns 50, so I suppose, the first
interrupt to allocate should be 50, not 0.

PS: I have kernel 3.4.7, but I copied the driver source from latest git tree:
https://github.com/mirrors/linux-2.6/commit/ca3ffe910f9935d24e02bb5628a8cbcab119fd9a#drivers/gpio/gpio-pca953x.c
https://github.com/mirrors/linux-2.6/blob/6a7b36aa4b0afbe7a9798feac16de47ad856f358/include/linux/i2c/pca953x.h

thanks in advance
Aleksander D.
