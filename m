From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: add support for Diolan DLN-2 devices
Date: Fri, 22 Aug 2014 02:10:40 +0300
Message-ID: <CAE1zotJBB=wxx=v2_e4+O5KjBUhF++ER83rHO1R1zunDs7ksVg@mail.gmail.com>
References: <1408533887-22727-1-git-send-email-daniel.baluta@intel.com>
	<1408533887-22727-2-git-send-email-daniel.baluta@intel.com>
	<20140821080715.GE24090@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140821080715.GE24090@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, matthew-AIaitxs59ERIo2TaICnI/Q@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 21, 2014 at 11:07 AM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Aug 20, 2014 at 02:24:45PM +0300, Daniel Baluta wrote:
>> From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
>> Master Adapter DLN-2. Details about the device can be found here:
>>
<snip>
>
> I think you want to implement this driver as an MFD driver, rather than
> invent your own module registration.
>

Hi Johan,

Thank you for the detailed reviewed. We will rewrite the drivers to
use the MFD interface and address the rest of your comments and we
will resubmit them next week.

Thanks,
Tavi
