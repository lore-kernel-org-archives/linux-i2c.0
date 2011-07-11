From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Mon, 11 Jul 2011 20:29:15 +0200
Message-ID: <20110711202915.5f4cb17a@endymion.delvare>
References: <20110709092334.566e6dcd@endymion.delvare>
	<2607557.175.1310405514456.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2607557.175.1310405514456.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Mon, 11 Jul 2011 12:31:54 -0500 (CDT), Tim Nelson wrote:
> ----- Original Message -----
> > Yes. For whatever reason your SMBus misbehaves severely. Maybe a
> > hardware problem. You should try a few dumps from your other device at
> > 0x4c to confirm that this is a bus-wide issue and not only the
> > W83L604G
> > device.
> > 
> > Note that there exists an alternative driver for the I2C bus on
> > SCx200,
> > named scx200_i2c. I seem to remember that it is needed in some cases
> > where the scx200_acb driver doesn't work. Maybe this is your case.
> 
> When attempting a dump of the device at 0x4c, I do *not* get any 'XX' output. What is interesting is that when running 'i2cdetect -y 0', the device at 0x19 shows up only sporadically. It is not present in every run of i2cdetect.

This is consistent with the many XX's in the dump: the W83L604G device
sometimes doesn't ack its slave address (or fails in some other way.)
Did you check the kernel logs for error messages?

> The other device at 0x4c shows up every time, and does not contain 'XX' output. Is it safe to assume there is a problem with the Winbond controller? Or, it's usage on this board (hardware problem?) ?

I would indeed suspect an incorrect wiring of the W83L604G. You should
double check the SCLK, SDAT, VSS and 3VDD connections of the chip. Do
you have a second system to test on? This would rule out a hardware
sample error.

> I attempted to load the scx200_i2c module but I'm greeted with:
> 
> FATAL: Error inserting scx200_i2c (/lib/modules/2.6.26-2-486/kernel/drivers/i2c/busses/scx200_i2c.ko): No such device
> 
> I've tried with and without having the scx200_acb module loaded.
> 
> Thoughts?

You would indeed need to unload the scx200_acb driver first, but also
to load the scx200_gpio driver and maybe to pass the proper scl and sda
module parameters. But anyway, I don't think you have to do this. If
the device at 0x4c works fine, it's most probably not a problem with
the SMBus controller nor with the scx200_acb driver, so using
scx200_i2c instead would most certainly not help.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
