From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH] of: i2c: Add DT bindings for idle states to PCA954x mux
 driver
Date: Tue, 16 Dec 2014 21:13:47 +0100
Message-ID: <5490927B.1010705@nsn.com>
References: <548E387E.2020502@nsn.com> <5722849.lDq3gpSIfD@avalon> <54902A49.7030804@nsn.com> <3857435.mVCtkYnmde@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3857435.mVCtkYnmde@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Laurent!

On 16/12/14 14:38, ext Laurent Pinchart wrote:
>>> I understand the use cases of the idle-disconnect property. What do you
>>> > > use idle-state for, when the idle state is different from disconnecting
>>> > > the bus ?
>> >
>> > We do not have a use case for that. It was done only for the sake of
>> > completeness. Because other MUXes actually offer user this possibility. I
>> > was initially thinking about providing this on i2c-mux level for all of
>> > them, but unfortunately they all use deselect callback in different way and
>> > pinctrl is the worst case, as idle state cannot be represented with an int,
>> > but should be a pointer.
>> > 
>> > Anyway, if you think there is no use-case for this, I can drop this part.
> Adding a DT property without a clear use case usually makes me a bit wary. I 
> would thus prefer going for either idle-disconnect alone, or for an idle-state 
> property that would allow selecting disconnection as one of the possible 
> values.

I thought about this, but this would require some magic value for idle-state
property, which would not be obvious for the readers of .dts file without
consulting the documentation. So, I would prefer to drop the idle channel selection
completely...

-- 
Best regards,
Alexander Sverdlin.
