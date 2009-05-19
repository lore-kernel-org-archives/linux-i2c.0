From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Limit core locking to the necessary sections
Date: Tue, 19 May 2009 08:51:42 +0200
Message-ID: <20090519065141.GA9809@enneenne.com>
References: <20090514210436.45171424@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090514210436.45171424-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 14, 2009 at 09:04:36PM +0200, Jean Delvare wrote:
> The i2c-core code tends to hold the core lock for longer than it
> should. Limit locking to the necessary sections for both performance
> and clarity. This is also a requirement to support I2C multiplexers in
> the future.

These seem ok to me. :)

> Testing was successful on my system but I would love to hear from other
> testers. This kind of thing is easy to get wrong.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> ---
> Rodolfo, this should solve the deadlocks you had been encountering
> while working on I2C multiplexing support. I would like you to give a

Yes it does.

> try to my current stack of i2c patches:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c.tar.gz
> 
> If it works OK, please rebase your multiplexing patches on top of it.
> Then I'll review them. I'd like to have initial multiplexing support in
> kernel 2.6.31, which doesn't leave us too much time.

Sorry for the long delay in reply but I was very busy in these
days... however I'll try to give a test at whole patchset ASAP!

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
