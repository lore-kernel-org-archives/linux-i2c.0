From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/5] mv64xxx updates
Date: Thu, 13 Feb 2014 21:51:00 +0100
Message-ID: <20140213215100.1d714c4b@skate>
References: <20140213094117.GA3934@katana>
	<1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392323793-4125-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

On Thu, 13 Feb 2014 21:36:28 +0100, Wolfram Sang wrote:
> So, this is a series I came up with trying to fix the issue found by Kevin.
> Patches 1+2 are hopefully fixing the bug (in theory, I don't have the HW).
> Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), then 4+5
> are further cleanup possibilities. And there is still more potential, I mainly
> wanted to give some inspiration and awareness that the driver could need some
> more love. Please test at least 1+2, comments to 3-5 very welcome.
> 
> Sorry for the delay, I got distracted by an NMI.

I'm adding Maxime Ripard in Cc, since he is the maintainer of the
Allwinner platform, which also uses this I2C driver. So I guess he
would like to be notified of such changes in order to test that the
driver still works for him.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
