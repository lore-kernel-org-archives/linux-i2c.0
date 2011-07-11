From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Mon, 11 Jul 2011 12:31:54 -0500 (CDT)
Message-ID: <2607557.175.1310405514456.JavaMail.root@zmail.rockbochs.com>
References: <20110709092334.566e6dcd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110709092334.566e6dcd-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> Yes. For whatever reason your SMBus misbehaves severely. Maybe a
> hardware problem. You should try a few dumps from your other device at
> 0x4c to confirm that this is a bus-wide issue and not only the
> W83L604G
> device.
> 
> Note that there exists an alternative driver for the I2C bus on
> SCx200,
> named scx200_i2c. I seem to remember that it is needed in some cases
> where the scx200_acb driver doesn't work. Maybe this is your case.
> 

Greetings Jean-

When attempting a dump of the device at 0x4c, I do *not* get any 'XX' output. What is interesting is that when running 'i2cdetect -y 0', the device at 0x19 shows up only sporadically. It is not present in every run of i2cdetect. The other device at 0x4c shows up every time, and does not contain 'XX' output. Is it safe to assume there is a problem with the Winbond controller? Or, it's usage on this board (hardware problem?) ?

I attempted to load the scx200_i2c module but I'm greeted with:

FATAL: Error inserting scx200_i2c (/lib/modules/2.6.26-2-486/kernel/drivers/i2c/busses/scx200_i2c.ko): No such device

I've tried with and without having the scx200_acb module loaded.

Thoughts?

--Tim
