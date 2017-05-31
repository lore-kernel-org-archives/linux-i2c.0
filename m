From: jmondi <jacopo@jmondi.org>
Subject: Re: [PATCH v2] i2c: i2c-mux: Fix channel parent node assignment
Date: Wed, 31 May 2017 16:51:26 +0900
Message-ID: <20170531075126.GC19019@w540>
References: <1496134457-19573-1-git-send-email-jacopo+renesas@jmondi.org>
 <5de6a678-e646-3acb-2346-8a1d76ebbf9d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55604 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaHvh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2017 03:51:37 -0400
Content-Disposition: inline
In-Reply-To: <5de6a678-e646-3acb-2346-8a1d76ebbf9d@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Peter,

On Tue, May 30, 2017 at 01:04:08PM +0200, Peter Rosin wrote:
> On 2017-05-30 10:54, Jacopo Mondi wrote:
> > I2c-mux channels are created as mux siblings while they should be
> > children of the mux itself. Fix it.
>
> Has this received any testing at all?
>

Yes, but on our specific use case, that apparently does not makes use of
i2c_parent_is_i2c_adapter()

> I think it will break various users of i2c_parent_is_i2c_adapter()
> that expect the current situation that a i2c mux child adapter is
> direct child of the parent i2c adapter. I.e. with no intermediate
> device node.

Oh, I know see..

So when walking the devices sitting on an i2c-adapter we should expect to
see mux children adapters as well there. Do you think is there a way to
easily identify them?

Thanks
   j
>
> Cheers,
> peda
>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >
> > Hello,
> >    while inspecting child nodes of an i2c adapter it has been noted that
> > child devices of an i2c-mux are listed as children of the i2c adapter itself,
> > and not of the i2c-mux.
> >
> > The hierarchy of devices looked like
> >
> > -- i2c-04
> > --- eeprom@57
> > --- video_receiver@70
> > --- video_receiver@34
> > --- gmsl-deserializer@0		<-- MUX
> > --- gmsl-deserializer@0/i2c@0	<-- MUX CHANNEL
> >
> > It now looks like
> >
> > -- i2c-04
> > --- eeprom@57
> > --- video_receiver@70
> > --- video_receiver@34
> > --- gmsl-deserializer@0
> > ---- gmsl-deserializer@0/i2c@0
> >
> > v1 -> v2:
> > - change commit message as suggested by Geert
> >
> >  drivers/i2c/i2c-mux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> > index 83768e8..37b7804 100644
> > --- a/drivers/i2c/i2c-mux.c
> > +++ b/drivers/i2c/i2c-mux.c
> > @@ -324,7 +324,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
> >  	priv->adap.owner = THIS_MODULE;
> >  	priv->adap.algo = &priv->algo;
> >  	priv->adap.algo_data = priv;
> > -	priv->adap.dev.parent = &parent->dev;
> > +	priv->adap.dev.parent = muxc->dev;
> >  	priv->adap.retries = parent->retries;
> >  	priv->adap.timeout = parent->timeout;
> >  	priv->adap.quirks = parent->quirks;
> > --
> > 2.7.4
> >
>
