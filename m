From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Tue, 12 Apr 2011 15:53:45 +0200
Message-ID: <20110412155345.4644e51c@endymion.delvare>
References: <4DA4250A.3060907@fuckner.net>
	<20110412132611.045ace21@endymion.delvare>
	<4DA44B05.906@fuckner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DA44B05.906-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 12 Apr 2011 14:52:21 +0200, Michael Fuckner wrote:
> On 04/12/2011 01:26 PM, Jean Delvare wrote:
> Hi all,
> 
> > Note that you will need a recent enough kernel (>= 2.6.36) to have
> > support for SMBus multiplexing.
> currently I use OpenSUSE11.4 with 2.6.37.1-1.2-default

This is OK then.

> > FWIW, address 0x70 is used by the PCA954x multiplexers, so maybe this
> > is what you have (and a driver is available).
> >
> > At 0x2f is probably a W83793 or W83795 monitoring chip, supported by
> > the w83793 and w83795 drivers, respectively. Only use these dedicated
> > drivers if you do not intend to use the IPMI features of the board.
> >
> >> 18,1a,1c: jc42 temperature sensors
> >> 50,52,54: eeproms
> >
> 
> 
> Now I loaded the module
> 
> test24:/media/i2c-tools/tools # lsmod |grep pca
> pca954x                 3288  0
> i2c_mux                 2672  1 pca954x
> test24:/media/i2c-tools/tools # ll /sys/bus/i2c/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0050 -> 
> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050
> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0052 -> 
> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0052
> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0054 -> 
> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0054
> lrwxrwxrwx 1 root root 0 Apr 12 13:54 i2c-0 -> 
> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0

Loading the pca954x driver doesn't do anything. It needs an
instantiated device with proper platform data before it will do
anything. This can only be done from within the kernel, using some sort
of platform initialization code.

> Seems like this is what I need to know, but I don't know how to 
> interpret it. Is it multiplexed on the GPIO Pin 52 and 53 at the W83795ADG?
> 
> ftp://ftp.supermicro.com/utility/SuperoDoctorINI/AllMEMDIMM.ini

Indeed, good finding. This shows that the vendor is using GPIOs to
switch between the SMBus segments. This rules out the chip at I2C
address 0x70. Unfortunately the document doesn't say of which chip the
GPIO 52 and 53 are used. It's not even clear if "52" means "pin 52" or
"GPIO group 5, pin 2". I'm certain it's not related to the W83795ADG
though, as this chip has only 48 pins and 4 GPIO pins max.

My first suspect would be the Intel ICH south bridge. The ICH10 has
GPIO pins numbered 52 and 53. I don't think there is any driver for
these GPIO pins though, so one will have to be written first. Only
then, board-specific glue code can be written to link between this new
driver, i2c-i801 and gpio-i2cmux.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
