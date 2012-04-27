From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2] i2c: Add generic I2C multiplexer using pinctrl API
Date: Fri, 27 Apr 2012 15:39:45 -0600
Message-ID: <4F9B1221.8090002@wwwdotorg.org>
References: <1335289664-21383-1-git-send-email-swarren@wwwdotorg.org>	<20120424200929.GC30172@pengutronix.de>	<4F9714F4.2060400@wwwdotorg.org> <CACRpkdYaVT+tSUT8LPxMzrvncdxjqfg60m5__6cb2OC+MCw_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdYaVT+tSUT8LPxMzrvncdxjqfg60m5__6cb2OC+MCw_Ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/25/2012 05:09 AM, Linus Walleij wrote:
> On Tue, Apr 24, 2012 at 11:02 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 04/24/2012 02:09 PM, Wolfram Sang wrote:
>>>
>>> From what I know, compatible-properties should not be linux-specific
>>> since devicetrees are OS independent. pinctrl-i2cmux sounds
>>> linux-specific to me.
>>>
>>> So, is such a binding acceptable meanwhile?
>>
>> To my mind, "pinctrl" has two meanings: (1) is the Linux internal API
>> (2) is the pinctrl bindings in
>> Documentation/devicetree/bindings/pinctrl, which were admittedly
>> developed strongly based on Linux's pinctrl API needs, but I believe
>> should be completely agnostic to the pinctrl API, SW, OS, etc., and
>> hence can be considered a pure representation of hardware.
>>
>> As such, the "pinctrl" in "pinctrl-i2cmux" above refers to (2) above,
>> and can be considered a pure HW/binding term.
> 
> I second Stephens statement.
> 
> Now every OS in the world must start to think about these things
> as pin controllers. But tt's not like there is competing terminology
> anyway, so let's define this before we get into committee meetings...

Rob, Grant, could you please take a look at the binding at the start of
this thread and say if you're OK with the compatible naming, and the
binding in general? Thanks.
