From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Winbond W83L604G
Date: Tue, 5 Jul 2011 09:46:17 -0500 (CDT)
Message-ID: <30480104.171.1309877177809.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Greetings-

I've got a board with a Winbond W83L604G GPIO controller and I'd like to use it with Debian 6.x for controlling attached LEDs. However, using i2cdetect, I'm not seeing any I2C busses on the system, nor any I2C devices. Does this controller require a specific kernel module for operation? Any tips or pointers on how to make it available for control using I2C?

I've not found a current kernel module for this chip, nor found any reference when grep'ing through the current source tarball. Maybe there simply isn't a module available to use it?

Thanks!

--Tim
