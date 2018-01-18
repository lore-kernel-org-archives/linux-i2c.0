From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v1 08/15] drm/i2c: tda998x: Remove duplicate NULL check
Date: Thu, 18 Jan 2018 17:21:09 +0200
Message-ID: <20180118152109.GW10981@intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-8-andriy.shevchenko@linux.intel.com>
 <20171031170343.GG9463@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbeARPVN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 10:21:13 -0500
Content-Disposition: inline
In-Reply-To: <20171031170343.GG9463@n2100.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Airlie <airlied@linux.ie>, linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, Wolfram Sang <wsa@the-dreams.de>

On Tue, Oct 31, 2017 at 05:03:43PM +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 31, 2017 at 04:21:42PM +0200, Andy Shevchenko wrote:
> > Since i2c_unregister_device() became NULL-aware we may remove duplicate
> > NULL check.
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

commit 7b43dd19c9b1 ("i2c: Make i2c_unregister_device() NULL-aware")
seems to be the thing that makes this possible. So these three
patches lgtm -> pushed to drm-misc-next.

> 
> Thanks.
> 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> > index 4d1f45acf2cd..7a349e85f964 100644
> > --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > @@ -1602,8 +1602,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
> >  	/* if encoder_init fails, the encoder slave is never registered,
> >  	 * so cleanup here:
> >  	 */
> > -	if (priv->cec)
> > -		i2c_unregister_device(priv->cec);
> > +	i2c_unregister_device(priv->cec);
> >  	return -ENXIO;
> >  }
> >  
> > -- 
> > 2.14.2
> > 
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel OTC
