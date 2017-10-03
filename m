From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Tue, 3 Oct 2017 16:49:25 -0500
Message-ID: <20171003214925.353u7l35jvnergsr@rob-hp-laptop>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
 <87377fmbpw.fsf@free-electrons.com>
 <1506289460890.34765@alliedtelesis.co.nz>
 <87lgl1ishv.fsf@free-electrons.com>
 <5376f24bf4c540088ce6432097b5cb51@svr-chch-ex1.atlnz.lc>
 <87efqsiok3.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87efqsiok3.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, Kalyan Kinthada <Kalyan.Kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 27, 2017 at 09:33:00AM +0200, Gregory CLEMENT wrote:
> Hi Chris,
>  
>  On mer., sept. 27 2017, Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> 
> > Hi Gregory,
> >
> > On 27/09/17 00:56, Gregory CLEMENT wrote:
> >> Hi Kalyan,
> >> 
> >> Please try avoid top-posting.
> >> 
> >>   On dim., sept. 24 2017, Kalyan Kinthada <Kalyan.Kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> >> 
> >>> Hi Gregory,
> >>>
> >>> I got this information from Armada-38x functional errata document.
> >> 
> >> OK but in any case just adding a new compatible was not enough you have
> >> to update the driver in the same time, however for this case we won't
> >> need it, see below.
> >> 
> >>>
> >>> I can add the "marvell,mv78230-i2c" compatible string to the appropriate  device tree files
> >>> but the i2c-mv64xxx driver enables an additional  feature (offload i2c transactions)
> >>> based on the compatible string "marvell,mv78230-i2c".
> >>>
> >>> I am not sure if this feature (offload i2c transactions) should be enabled for Armada-38x devices.
> >>> That is the reason I felt for the need of a new compatible string
> >>> specifically for Armada-38x SoCs.
> >> 
> >> Indeed the Armada-38x SoCs does not support hardware offloading (at
> >> least according the datasheet). But it happens that in the earlier
> >> version of the Armada XP the hardware offloading was buggy, so we
> >> introduced a compatible for this case: marvell,mv78230-a0-i2c. This
> >> compatible enable the errata fix but not the offloading feature. That
> >> means that it is exactly the compatible you need for Armada 38x (and
> >> Armada 39x and 375 I think).
> >
> > The "mv78230-a0-i2c" dt-binding has the following note
> >
> >    Note: Only use "marvell,mv78230-a0-i2c" for a
> >    very rare, initial version of the SoC which
> >    had broken offload support.  Linux
> >    auto-detects this and sets it appropriately.
> >
> > If we are going to re-use this binding for armada-38x we should probably 
> > remove this note. Personally my preference would be an armada-38x
> 
> Updating the documentation is the right thing to do yes.
> 
> 
> > compatible string (or 370 if that's the common base of these SoCs). But 
> > of course we'll go with whatever your preference is as maintainer.
> 
> If the IP is compatible then there is no reason to add a new one, else
> we will end with a compatible for each SoC and the compatible property
> will just loose its meaning.

If you all had added compatibles for each SoC in the first place, then 
we wouldn't be having this dicussion.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
