From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 07/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
Date: Mon, 6 Feb 2017 15:22:17 -0600
Message-ID: <CAL_JsqLfDE-VG01E6ptyL1zXtLDn-zDRmNE9PTsxMqrRzbrXfA@mail.gmail.com>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-8-git-send-email-peda@axentia.se> <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
 <835415bf-77af-6131-d018-d0bc7d8233b0@axentia.se> <CAL_JsqLVrzm4BEv3kpOGRoaRq+cqvSm+A6weZfU8H8i9dc=tcA@mail.gmail.com>
 <cdc958c3-2496-be52-6407-bf9aefdfa965@axentia.se> <CAL_JsqLCdM5s8FYqys-m5wpr4QeeE-rQaRXCt+rjQz3qm+E2qA@mail.gmail.com>
 <5dc05e28-45c7-1dfe-3cd2-53e55490b48a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5dc05e28-45c7-1dfe-3cd2-53e55490b48a-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 3, 2017 at 2:25 AM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
> On 2017-02-02 17:08, Rob Herring wrote:
>> On Tue, Jan 31, 2017 at 1:36 AM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>>> If you see this new driver as something that is superseding the existing
>>> i2c-mux-gpio driver, I'm sad to inform you that the code is not simply
>>> not there. i2c-mux-gpio has acpi support and users may provide platform
>>> data from code. The existing i2c-mux-gpio driver also has the below
>>> mentioned locking heuristic. Adding all those things to the new driver
>>> would make it big and unwieldy and having even more unwanted tentacles
>>> into other subsystems. And why should it be only i2c-mux-gpio that is
>>> merged into this new i2c-mux driver? Why not implement a mux-pinctrl
>>> driver for the new mux subsustem and then merge i2c-mux-pinctrl as well?
>>> I say no, that way lies madness.
>>
>> Sounds like a good idea to me. I'm not saying you need to merge any of
>> them right now though (that's Wolfram's call).
>
> If we're pedantic I probably have some stake in it too, being the i2c-mux
> maintainer and all. But, agreed, I arrived quite late to the Linux kernel
> party and my opinion might perhaps not carry all that much weight...
>
>> None of this has anything to do with the binding though. Compatible
>> strings should be specific. That's not up for debate. Whether the
>
> Ok, I'm going to focus on the compatible string for a minute and leave
> the implementation details for some other discussion.
>
>> driver bound to a compatible string is common or specific to that
>> compatible string is completely up to the OS. That decision can change
>> over time, but the binding should not.
>
> So, there's the existing compatible "i2c-mux-gpio" ("i2c-gpio-mux" is
> wrong) that you seem to suggest is what I should stick to. I object to
> that.
>
> As you say, the bindings and compatible strings should describe hardware,
> and you also state they should be specific. I agree. But, why are you
> then apparently suggesting (by implication) that for this (hypothetical)
> hardware...
>
>     .----.
>     |SDA0|-----------.
>     |SCL0|---------. |
>     |    |         | |
>     |    |      .-------.
>     |    |      |adg792a|
>     |    |      |       |
>     |ADC0|------|D1  S1A|---- signal A
>     |    |      |    S1B|---- signal B
>     |    |      |    S1C|---- signal C
>     |    |      |    S1D|---- signal D
>     |    |      |       |
>     |SDA1|---+--|D2  S2A|---- i2s segment foo A
>     |SCL1|-. |  |    S2B|---- i2s segment foo B
>     '----' | |  |    S2C|---- i2s segment foo C
>            | |  |    S2D|---- i2s segment foo D
>            | |  |       |
>            | '--|D3  S3A|---- i2s segment bar A
>            |    |    S3B|---- i2s segment bar B
>            |    |    S3C|---- i2s segment bar C
>            |    |    S3D|---- i2s segment bar D
>            |    '-------'
>            |                  A B C D   A B C D  (feed SCL1 to each of
>            |                  | | | |   | | | |   the 8 muxed segments)
>            '------------------+-+-+-+---+-+-+-'
>
> ...the devicetree should be like below?
>
> &i2c0 {
>         mux: mux-controller@50 {
>                 compatible = "adi,adg792a";
>                 reg = <0x50>;
>                 #mux-control-cells = <1>;
>         };
> };
>
> adc-mux {
>         compatible = "io-channel-mux";
>         io-channels = <&adc 0>;
>         io-channel-names = "parent";
>
>         mux-controls = <&mux 0>;
>
>         ...
> };
>
> i2c-mux-foo {
>         compatible = "i2c-mux-gpio";
>         i2c-parent = <&i2c1>;
>
>         mux-controls = <&mux 1>;
>
>         ...
> };
>
> i2c-mux-bar {
>         compatible = "i2c-mux-gpio";
>         i2c-parent = <&i2c1>;
>
>         mux-controls = <&mux 2>;
>
>         ...
> };
>
> There must be some disconnect, because those "i2c-mux-gpio" compatible
> strings are just dead wrong. There simply are no gpio pins involved at
> all and that "gpio" suffix is just totally out of place.

Indeed. In the above case, that makes no sense.

> So, since you are not happy with "i2c-mux-simple", "i2c-mux-generic" or
> "i2c-mux" that I have suggested, can you please come up with something
> that is good enough for the above?

Let's go with just "i2c-mux". I've got nothing better and simple or
generic doesn't add anything.

Rob
