From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dts: keystone: Change "ti,davinci-i2c" compatible to
 "ti,keystone-i2c"
Date: Mon, 24 Aug 2015 09:17:15 +0200
Message-ID: <55DAC4FB.9010201@nokia.com>
References: <55D6F39A.2030402@nokia.com> <20150821182500.GA2000@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150821182500.GA2000@svinekod>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Mark,

On 21/08/15 20:25, ext Mark Rutland wrote:
>> Now as "i2c-davinci" driver has special handling for Keystone it's time to switch
>> > the device tree to use new "compatible" property.
>> > 
>> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> > ---
>> >  arch/arm/boot/dts/keystone.dtsi |    6 +++---
>> >  1 files changed, 3 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
>> > index 72816d6..a846597 100644
>> > --- a/arch/arm/boot/dts/keystone.dtsi
>> > +++ b/arch/arm/boot/dts/keystone.dtsi
>> > @@ -106,7 +106,7 @@
>> >  		};
>> >  
>> >  		i2c0: i2c@2530000 {
>> > -			compatible = "ti,davinci-i2c";
>> > +			compatible = "ti,keystone-i2c";
>>From what I understand of the previous patch, this is effectively an
> optimisation, and things worked to some extent with the "ti,davinci-i2c"
> string.

Indeed this is an optimization.

> So could you leave that as a fallback, i.e. have:
> 
> 	compatible = "ti,keystone-i2c", "ti,davinci-i2c";

And I have no problem leaving fallback compatible.

> That way an old kernel still functions with this DT, which among other things
> makes debugging and bisecting far easier.

I've just thought, that we do not care about backwards-compatibility for the DT in
the kernel tree, because one always have the correct one linked to the kernel.
And this evaluation module never has it flashed to some persistent storage outside
of kernel image, so version mismatch is impossible.

> Or are things actually broken with the "ti,davinci-i2c" string?

No, not in this case.

-- 
Best regards,
Alexander Sverdlin.
