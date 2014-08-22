From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Trickle charging for rtc-bq32k
Date: Fri, 22 Aug 2014 16:38:53 +0200
Message-ID: <20140822143853.GA28820@amd>
References: <20140822131150.GA26724@amd>
 <20140822142852.GA1545@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140822142852.GA1545@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri 2014-08-22 09:28:52, Wolfram Sang wrote:
> 
> > _But_ this should probably be enabled using device tree entry, right?
> > Unfortunately, the driver is i2c driver, not platform one, so I don't
> > see how to do that easily...
> 
> Trickle charging is usually depending on the hardware setup, so
> devicetree is actually a good place to put it. We'd just need generic
> bindings so that they could be applied to various RTC. Just guessing,
> resistor value would probably be one such property? We would not need
> putting plain register values into DT.

Well, for bq32000 there's selection between "no charging", "diode +
resistor", "different resistor".

> There should be no difference regarding DT between i2c and platform
> drivers.

Do you have example how to acces of_ from i2c driver?

Platform drivers do:

static int palmas_rtc_probe(struct platform_device *pdev)
{
        struct palmas *palmas = dev_get_drvdata(pdev->dev.parent);
        struct palmas_rtc *palmas_rtc = NULL;
	int ret;
        bool enable_bb_charging = false;
        bool high_bb_charging;

        if (pdev->dev.of_node) {
	   enable_bb_charging =
	   of_property_read_bool(pdev->dev.of_node,
                                        "ti,backup-battery-chargeable");
					        high_bb_charging =
	   of_property_read_bool(pdev->dev.of_node,
                                        "ti,backup-battery-charge-high-current");

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
