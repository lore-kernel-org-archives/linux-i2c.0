From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Wed, 7 Jan 2009 16:27:09 +0100
Message-ID: <20090107162709.755982c0@hyperion.delvare>
References: <1231177261.13443.20.camel@localhost.localdomain>
	<20090107142426.4be04d4d@hyperion.delvare>
	<9ae48b020901070722l77bebc6boc8fa2fd0bcc8da28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9ae48b020901070722l77bebc6boc8fa2fd0bcc8da28-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ed,

On Wed, 7 Jan 2009 07:22:12 -0800, Ed Swierk wrote:
> On Wed, Jan 7, 2009 at 5:24 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Are you certain the nForce2 controllers can't do it? The i2c-nforce2
> > driver doesn't implement it, but this doesn't mean the hardware can't
> > do it. I don't have any datasheet for these chips, but I know their
> > SMBus implementation is very similar to those of the AMD 8111, and
> > i2c-amd8111 has support for I2C block reads and writes. I think it
> > would be worth giving it a try, by copying the i2c-amd8111
> > implementation into the i2c-nforce2 driver and seeing if it happens to
> > just work. If it works, that would be more elegant than your proposed
> > hack to the rtc-ds1307 driver.
> 
> I checked the datasheet and also tried every possible SMBus command
> value to try to discover any supported commands that the i2c-nforce2
> driver happens not to use, to no avail. The nVidia SMBus is pure
> SMBus.

Did you try 0x4a (as i2c-amd8111 is using)?

So, you have the datasheet... Is this something you would be allowed to
share with me?

> I could change the ds1307 driver to check whether the controller
> supports i2c block commands and fall back to emulation only if they
> are not available. Would that address your concerns?

Yes, that would. Same thing the eeprom or lm93 drivers are doing, to
only name a few of them. Should be fairly easy.

-- 
Jean Delvare
