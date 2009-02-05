From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
Date: Thu, 5 Feb 2009 11:51:00 +0000
Message-ID: <20090205115100.GD422@sirena.org.uk>
References: <49889CFA.7070308@freescale.com> <4989F3F4.7070207@consentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4989F3F4.7070207-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 04, 2009 at 12:00:52PM -0800, Mike Ditto wrote:
> Timur Tabi wrote:
> > However, it appears that this is not common behavior for I2C driver.  In
> > fact, only these six drivers ever call wait_event_interruptible_timeout():

> > i2c-cpm.c

> I don't know about the others, but in i2c-cpm.c the use of interruptible
> wait seems incorrect.  Maybe it could be made correct, but as is, it
> does not correctly clean up the hardware state or return a useful
> value when interrupted by a signal.  It's not clear what to do, anyway -

This is exactly the problem for users that caused Timur to run into this
- further up the stack we're trying to do cleanup that involves writing
via I2C but the I2C writes error out due to the signal.

> handling (one second delay in the unlikely worst case for i2c-cpm).

Ditto for the Freescale PowerPC I2C driver.
