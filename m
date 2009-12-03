From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help: Watchdog-driver over smbus (i2c)
Date: Thu, 3 Dec 2009 23:17:02 +0100
Message-ID: <20091203231702.039106c5@hyperion.delvare>
References: <4B14395F.4070608@anduras.de>
	<20091201103120.6ba0f7e0@hyperion.delvare>
	<4B18261B.8070507@anduras.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B18261B.8070507-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 03 Dec 2009 21:56:59 +0100, Sven Anders wrote:
> Jean Delvare schrieb:
> > Hallo Sven,
> > 
> > On Mon, 30 Nov 2009 22:30:07 +0100, Sven Anders wrote:
> >
> >> Moreover the w83793g hardware sensors driver may already
> >> accessing the same chip. What is the normal way to deal with this?
> > 
> > Do not write a separate driver for the watchdog functionality. Instead,
> > add the functionality to the existing hwmon/w83793.c driver. Otherwise
> > both features will be mutually exclusive.
> > 
> > An example of how this can be done is in hwmon/fschmd.c [1] if you want
> > to take a look. This is an I2C/SMBus device driver as well, so your code
> > should be very similar in the end.
> > 
> > [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/fschmd.c
> > 
> > Hope this helps,
> 
> Yes, thanks! This was the hint I needed.
> Now I finished the watchdog driver and it's working!

Cool. When it's ready, please send it over to the lm-sensors list so
that it gets merged.

-- 
Jean Delvare
