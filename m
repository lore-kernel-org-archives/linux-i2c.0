From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
Date: Wed, 04 Feb 2009 12:00:52 -0800
Message-ID: <4989F3F4.7070207__31598.9467119381$1233778677$gmane$org@consentry.com>
References: <49889CFA.7070308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49889CFA.7070308-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Timur Tabi wrote:
> However, it appears that this is not common behavior for I2C driver.  In
> fact, only these six drivers ever call wait_event_interruptible_timeout():
> 
> i2c-cpm.c

I don't know about the others, but in i2c-cpm.c the use of interruptible
wait seems incorrect.  Maybe it could be made correct, but as is, it
does not correctly clean up the hardware state or return a useful
value when interrupted by a signal.  It's not clear what to do, anyway -
it's hard to know which messages of the interrupted transaction have
actually taken effect in the hardware.  I think it's better to use
uninterruptible wait here and just live with the delayed signal
handling (one second delay in the unlikely worst case for i2c-cpm).

In general, I think it's best to consider I2C I/O to be uninterruptible,
like disk I/O.  The only reason to make it interruptible is to make
sure you don't end up with an unkillable process due to an I/O error,
and that is adequately handled by a timeout (and re-initialization of
the I2C interface in that case).

					-=] Mike [=-
