From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2] of: i2c: Add idle-disconnect DT property to PCA954x mux driver
Date: Thu, 15 Jan 2015 16:40:12 +0200
Message-ID: <2086954.CPkjLx72cS@avalon>
References: <5494599A.8050803@nsn.com> <54B7BBF5.4010001@nsn.com> <20150115131935.GE2549@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115131935.GE2549@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thursday 15 January 2015 14:19:35 Wolfram Sang wrote:
> On Thu, Jan 15, 2015 at 02:09:09PM +0100, Alexander Sverdlin wrote:
> > On 15/01/15 13:32, ext Wolfram Sang wrote:
> >> On Fri, Dec 19, 2014 at 06:00:10PM +0100, Alexander Sverdlin wrote:
> >>> of: i2c: Add idle-disconnect DT property to PCA954x mux driver
> >>> 
> >>> Add idle-disconnect device tree property to PCA954x mux driver. The new
> >>> property forces the multiplexer to disconnect child buses in idle
> >>> state. This is used, for example, when there are several multiplexers
> >>> on the same bus and the devices on the underlying buses might have
> >>> same I2C addresses.
> >> 
> >> Basically OK. Question to DT maintainers: "idle-disconnect",
> >> "i2c-mux-idle-disconnect", or is there another existing binding we could
> >> use?
> >> 
> >>> At the same time old (and not used in the tree) platform data binding
> >>> deselect_on_exit is removed to simplify the implementation. Old binding
> >>> has different (per-channel) semantics and doesn't fit well in the new
> >>> concept.
> >> 
> >> I'd prefer to keep it. It should be only one || more. It is not really
> >> in the way IMO.
> > 
> > It complicates the implementation 3x times :) This is part of our
> > discussion with Laurent:
>
> Does it? I don't want DT and platform_data to behave equally. I just
> want to keep being backwards compatible. So, I'd suggest:
> 
> (pdata && pdata->modes[num].deselect_on_exit) || idle_disconnect ?
> pca954x_deselect_mux : NULL);
>
> >> I'm not keen to brake out-of-tree code (if any), but may be it will be
> >> decided to drop this per-channel deselect_on_exit, because it's not used
> >> at least in the kernel tree...
> 
> I couldn't find a user of the platform_data, at all. But removing
> platform_data support is a seperate patch, and deprecating platform_data
> is a seperate and general issue IMO.

Sure, but it could be a preliminary patch on top of which to add idle-
disconnect DT support :-)

-- 
Regards,

Laurent Pinchart
