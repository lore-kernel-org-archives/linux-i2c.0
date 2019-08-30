From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Date: Fri, 30 Aug 2019 15:06:03 +0200
Message-ID: <20190830130603.GQ21922@piout.net>
References: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
 <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
 <20190829205752.GL21922@piout.net>
 <20190830124554.GB2870@ninjato>
 <20190830125338.GP21922@piout.net>
 <20190830130035.GF2870@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830130035.GF2870@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 30/08/2019 15:00:35+0200, Wolfram Sang wrote:
> 
> > > > I'm confused because I already applied:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=7150710f3084de8d35ce3221eeae2caee8813f92
> > > 
> > > The above was a mass conversion to i2c_new_dummy_device() to make sure
> > > all in-kernel users use the API returning an ERRPTR. Mass conversion to
> > > the devm_ variant of the same function was too troublesome.
> > > 
> > > With another series, I wanted to remove superfluous error checking of
> > > i2c_unregister_device() because it is NULL-ptr safe, like here:
> > > 
> > > > > -	if (info->rtc)
> > > > > -		i2c_unregister_device(info->rtc);
> > > 
> > > But for these two RTC drivers, I figured moving to devm_* is way easier
> > > than fixing up the mass conversion result from coccinelle.
> > > 
> > 
> > Ok so should I drop the previous patches and apply those instead?
> 
> Nope, they should be incremental, aren't they?
> 
No, your patches don't apply on top of rtc-next


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
