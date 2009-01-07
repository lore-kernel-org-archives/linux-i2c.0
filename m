From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Wed, 7 Jan 2009 16:49:23 +0100
Message-ID: <20090107164923.417aaeac@hyperion.delvare>
References: <1231177261.13443.20.camel@localhost.localdomain>
	<20090107142426.4be04d4d@hyperion.delvare>
	<9ae48b020901070722l77bebc6boc8fa2fd0bcc8da28@mail.gmail.com>
	<20090107162709.755982c0@hyperion.delvare>
	<9ae48b020901070743x1a5eaf72k5314cd969dc580ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9ae48b020901070743x1a5eaf72k5314cd969dc580ef-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 7 Jan 2009 07:43:18 -0800, Ed Swierk wrote:
> On Wed, Jan 7, 2009 at 7:27 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Did you try 0x4a (as i2c-amd8111 is using)?
> 
> Yes, it returns an error, as do all the other unsupported commands.

Oh well.

> > So, you have the datasheet... Is this something you would be allowed to
> > share with me?
> 
> Unfortunately not; we acquired it under an NDA.

I expected that :(

By any chance, the datasheet doesn't explain why SMBus block
transactions of size 32 lock the chip, nor how to work around it?

> >> I could change the ds1307 driver to check whether the controller
> >> supports i2c block commands and fall back to emulation only if they
> >> are not available. Would that address your concerns?
> >
> > Yes, that would. Same thing the eeprom or lm93 drivers are doing, to
> > only name a few of them. Should be fairly easy.
> 
> OK, will do.

OK. BTW, designing a system with an SMBus master which is so clearly
inappropriate for the I2C chips that are connected to it wasn't exactly
smart to start with. Whoever did this should be told to think twice
about it next time.

-- 
Jean Delvare
