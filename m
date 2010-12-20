From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Encourage move to dev_pm_ops by warning on use of
	legacy methods
Date: Mon, 20 Dec 2010 21:59:58 +0000
Message-ID: <20101220215958.GB1126@trinity.fluff.org>
References: <1292881260-31987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1292881260-31987-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 20, 2010 at 09:41:00PM +0000, Mark Brown wrote:
> Since the PM core wishes to transition away from the legacy suspend
> and resume methods and since removing them makes using PM core features
> like runtime PM much easier start warning when a driver is registered
> using the legacy methods.
> 
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
> 
> Clearly this is going to generate reams of warnings when lots of stuff
> is built in - I'm willing to work on fixing up drivers - so it should
> only be applied after the next merge window to give a chance for an
> active effort at migrating drivers before we spam everyone's logs.

Ok, it'll generate warnings at load-time, maybe move it to when the
drive is actually bound to a device?

Otherwise looks ok to me.

I'll look at pm-ops for the bus drivers after christmas, once the
pre-emptive house spring-clean has finished...

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
