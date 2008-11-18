From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RESEND patch 2.6.28-rc4] isp1301_omap build fixes
Date: Mon, 17 Nov 2008 20:07:11 -0800
Message-ID: <200811172007.11217.david-b@pacbell.net>
References: <200811141228.35262.david-b@pacbell.net> <20081117213615.57c3d494@hyperion.delvare>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081117213615.57c3d494-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 17 November 2008, Jean Delvare wrote:
> Sorry about that, I thought this patch would go through the omap tree.
> But I've picked it and applied it now and will send it to Linus in the
> next i2c batch.

Thanks ... it wouldn't go through the OMAP tree unless it were in
the arch/arm/*omap* directories, as a rule.  And that's for low
level board support; drivers belong somewhere in drivers/* code.


> I think that this kind of issue would probably be avoided if the
> isp1301_omap driver lived somewhere under arch/arm/plat-omap. Where it
> lives now (drivers/i2c/chips) it doesn't get the attention it deserves,
> or when it does, that's not from the right persons. Could you please
> work on this? Directory drivers/i2c/chips will be deleted "soon"
> anyway, so all the drivers it contains will need a new home.

I expect drivers/usb/otg will be a better place for this.  There's
some other code which looks like it'll need to land there "soon".

Once you merge these build fixes I'll probably cons up a patch which
moves this over there.  Unless you'd rather handle it, I'll probably
push that through Greg.

- Dave
