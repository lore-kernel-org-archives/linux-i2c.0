From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Fri, 13 Jan 2017 11:14:46 +0100
Message-ID: <1484302486.30810.26.camel@pengutronix.de>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
         <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
         <1480514806.2258.68.camel@pengutronix.de>
         <f259bd4b-788c-0bc2-25b8-7e0a735af859@mleia.com>
         <1480586832.17003.28.camel@pengutronix.de>
         <f50333f5-906b-fe9a-3e5b-e74522472d06@mleia.com>
         <20161211221622.GJ2552@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46907 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751363AbdAMKbG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Jan 2017 05:31:06 -0500
In-Reply-To: <20161211221622.GJ2552@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, patchwork-lst@pengutronix.de, linux-i2c@vger.kernel.org, kernel@pengutronix.de

Am Sonntag, den 11.12.2016, 23:16 +0100 schrieb Wolfram Sang:
> Lucas,
> 
> > Shallow review of DTS files and dpaux drivers let me say that the change
> > below has no regressions (the change is untested):
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > index 3e6fe82..f91ade1 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -1020,7 +1020,6 @@ int drm_dp_aux_register(struct drm_dp_aux *aux)
> >  	aux->ddc.class = I2C_CLASS_DDC;
> >  	aux->ddc.owner = THIS_MODULE;
> >  	aux->ddc.dev.parent = aux->dev;
> > -	aux->ddc.dev.of_node = aux->dev->of_node;
> >  
> >  	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
> >  		sizeof(aux->ddc.name));
> 
> Is this an acceptable approach? It makes sense to me from an I2C PoV.
> 
> I have to say that I second Vladimir's arguments. There shouldn't be any
> other I2C devices on DDC, but surely there is somebody somewhere hacking
> this bus to do something.

Yes, I've convinced myself that this is the better way.

Please drop this patch.

Regards,
Lucas
