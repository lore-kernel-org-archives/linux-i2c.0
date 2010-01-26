From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Tue, 26 Jan 2010 17:34:09 +0100
Message-ID: <20100126173409.54f32259@hyperion.delvare>
References: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100125111055.05ccedf2@hyperion.delvare>
	<20100126143830.GC12774@fluff.org.uk>
	<20100126162515.230bdf36@hyperion.delvare>
	<20100126153759.GF4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100126153759.GF4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 26 Jan 2010 16:37:59 +0100, Wolfram Sang wrote:
> > So I see no objection to a mass move of all embedded/system i2c bus
> > drivers to a separate sub-directory.
> 
> And with the PCA9xxx-controllers? The ISA-driver into non-embedded and the
> platform-driver into embedded? Hmmm...

Ideally the ISA driver would go to the trash can ;) and having both on
separate directories doesn't strike me as being a problem. We have
i2c-algo-bit-based drivers in many places and this has never been a
problem.

> And (in 80 years ;)) there might be just one I2C-maintainer taking care of them
> all? Then, why the split?

That's a more valid argument. But then again, MAINTAINERS can be edited
again later as needed, with split entries getting merged or the other
way around. What matters is that MAINTAINERS reflects the reality of
who is doing what.

> I am all for taking the embedded-burden away from you, just I am not too fond
> of this idea.

I'm not forcing anyone, and I would welcome alternative solutions.

-- 
Jean Delvare
