From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Tue, 19 Apr 2011 14:24:37 +0200
Message-ID: <20110419142437.5eaac154@endymion.delvare>
References: <4DA4250A.3060907@fuckner.net>
	<20110412132611.045ace21@endymion.delvare>
	<4DA44B05.906@fuckner.net>
	<20110412155345.4644e51c@endymion.delvare>
	<4DA53F22.5020105@gmx.de>
	<20110413103952.68bdb6fa@endymion.delvare>
	<4DA575C3.1050100@fuckner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DA575C3.1050100-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Wed, 13 Apr 2011 12:06:59 +0200, Michael Fuckner wrote:
> On 04/13/2011 10:39 AM, Jean Delvare wrote:
> 
> >> The challenge will be to detect which of the 8 supported devices (
> >> pca_9540, pca_9542, pca_9543, pca_9544, pca_9545, pca_9546, pca_9547,
> >> pca_9548) is actually to be used.
> >
> > In Michael's case it is irrelevant anyway, as the information he found
> > meanwhile clearly indicates that bus multiplexing is achieved by GPIOs
> > (most certainly on the ICH10) and not an PCA954x chip. The chip at 0x70
> > is probably the Intel 5500 IOH.
> 
> 
> Supermicro just gave me the following information:
> 
> To access all SPDs, you have to pull low GPIO49 (IO_0x528 bit 17) first. 
> Then pull low GPIO52 (IO_0x528 bit 20) to access first CPU 
> memory(0x50~0x55); pull high GPIO52 to access 2nd CPU memory(0x50~0x55).
> 
> 
> I can't find anything about GPIO49/52,53 in Datasheet for 5500/5520 chipset
> http://www.intel.com/assets/pdf/datasheet/321328.pdf
> 
> So it is probably connected to ICH10
> http://www.intel.com/Assets/PDF/datasheet/319973.pdf
> 
> but I don't know how to use this information

I've written a kernel driver to gain access to the GPIO pins of the
ICH10 (and previous ICH chips too.) It's available here:
http://khali.linux-fr.org/devel/misc/i801_gpio/

Generic instructions for standalone drivers are here:
http://khali.linux-fr.org/devel/misc/INSTALL

I would appreciate if you could give it a try on your system and report
everything in the kernel log after loading the driver. By default it
won't change the GPIO values so it should be totally safe.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
