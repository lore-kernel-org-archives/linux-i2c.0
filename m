From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
Date: Thu, 5 Feb 2009 09:18:04 -0600
Message-ID: <ed82fe3e0902050718w1c7bfff3r883eea185b66299@mail.gmail.com>
References: <49889CFA.7070308@freescale.com> <4989F3F4.7070207@consentry.com>
	 <20090205115100.GD422@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090205115100.GD422-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 5, 2009 at 5:51 AM, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:

> This is exactly the problem for users that caused Timur to run into this
> - further up the stack we're trying to do cleanup that involves writing
> via I2C but the I2C writes error out due to the signal.

Well, there's not much discussion on this issue, so I'm going to make
the change to an uninterruptible wait and see if it fixes my problem.
If so, I'll post a patch for i2c-mpc.c and see how far I get.

-- 
Timur Tabi
Linux kernel developer at Freescale
