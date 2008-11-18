From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RESEND patch 2.6.28-rc4] isp1301_omap build fixes
Date: Tue, 18 Nov 2008 09:09:49 +0100
Message-ID: <20081118090949.12654a6a@hyperion.delvare>
References: <200811141228.35262.david-b@pacbell.net>
	<20081117213615.57c3d494@hyperion.delvare>
	<200811172007.11217.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811172007.11217.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Dave,

On Mon, 17 Nov 2008 20:07:11 -0800, David Brownell wrote:
> On Monday 17 November 2008, Jean Delvare wrote:
> > I think that this kind of issue would probably be avoided if the
> > isp1301_omap driver lived somewhere under arch/arm/plat-omap. Where it
> > lives now (drivers/i2c/chips) it doesn't get the attention it deserves,
> > or when it does, that's not from the right persons. Could you please
> > work on this? Directory drivers/i2c/chips will be deleted "soon"
> > anyway, so all the drivers it contains will need a new home.
> 
> I expect drivers/usb/otg will be a better place for this.  There's
> some other code which looks like it'll need to land there "soon".

Fine with me.

> Once you merge these build fixes I'll probably cons up a patch which
> moves this over there.  Unless you'd rather handle it, I'll probably
> push that through Greg.

I'm totally OK with it going through Greg.

Thanks,
-- 
Jean Delvare
