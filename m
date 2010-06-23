From: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pca953x GPIO
Date: Wed, 23 Jun 2010 14:02:04 +0200
Message-ID: <AANLkTik5ICmrrsX0m9qzPr7TzF44HKIr5FMC4eKeGkzZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all...

  I'm new to I2c and I'm in trouble trying to get GPIO works on an
Advantech PCM-3362 motherboard.

manufacturer says that GPIO controller is an NXP PCA9555PW chip,
attached to the i2c BUS; the chip has the addresses 40 (read) and 41
(write) but, if I'm not wrong, in his linux libsusi library
manufacturer access GPIO via BIOS calls and not via linux i2c.

CPU is an intel Atom N450 with ICH8M chipset and it seems that SMBUS
controller is correctly recognized by the kernel as dmegs reports
something like:
i801_smbus 0000:00:1f.3: PCI INT C -> GSI 17 (level, low) -> IRQ 17

actually I've configured the latest 2.6.34 kernel with i2c and pca953x
drivers, but /sys/class/gpio reports only import / export entries,
with no GPIO chips at all...

I've read Documents/gpio.txt but still don't understand if I have to
do something more to enable GPIO: as I want to access it from kernel
space, I think I'll need to write my own driver (calling
gpio_request() etc) but still miss info about GPIO numbers... and I'm
not even sure GPIO is currently detected.

Ive try also registering a new GPIO device using generic gpiolib &
sysfs support (eg: echo GPIO-RD 0x40 >
/sys/bus/i2c/devices/i2c-0/new_device) but with no success.


   thanks a lot for any ideas

             Giampaolo Bellini
