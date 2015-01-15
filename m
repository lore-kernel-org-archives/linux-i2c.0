From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] of: i2c: Add idle-disconnect DT property to PCA954x
 mux driver
Date: Thu, 15 Jan 2015 09:48:54 -0600
Message-ID: <CAL_Jsq+=D8=-nUjX6LB6HQGQtc4QH_5H69xttaVbg+e4az+0_g@mail.gmail.com>
References: <5494599A.8050803@nsn.com> <20150115123237.GC2549@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115123237.GC2549@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 15, 2015 at 6:32 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Fri, Dec 19, 2014 at 06:00:10PM +0100, Alexander Sverdlin wrote:
>> of: i2c: Add idle-disconnect DT property to PCA954x mux driver
>>
>> Add idle-disconnect device tree property to PCA954x mux driver. The new property
>> forces the multiplexer to disconnect child buses in idle state. This is used, for
>> example, when there are several multiplexers on the same bus and the devices on
>> the underlying buses might have same I2C addresses.
>
> Basically OK. Question to DT maintainers: "idle-disconnect",
> "i2c-mux-idle-disconnect", or is there another existing binding we could
> use?

Not that I'm aware of. If this is specific to i2c-mux's then I'd go
with the latter. Either way, this should go in a common i2c or i2c-mux
binding doc.

Alternatively, couldn't the kernel do this automatically when the
above conditions happen?

Rob
