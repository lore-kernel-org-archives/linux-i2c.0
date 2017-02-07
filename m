From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: move trivial devices out of i2c subdir
Date: Tue, 7 Feb 2017 09:46:36 -0600
Message-ID: <CAL_Jsq+JT1JWEgOB8MeEhHUGB-guYmUCeCCXFU-aP9YXpbiUCA@mail.gmail.com>
References: <20170126225544.5431-1-wsa@the-dreams.de> <20170126225544.5431-3-wsa@the-dreams.de>
 <20170201135045.yass267eakmlpyru@rob-hp-laptop> <20170201183539.GB2557@tetsubishi>
 <20170207110847.iwikyplurumqi6qq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170207110847.iwikyplurumqi6qq@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 7, 2017 at 5:08 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Feb 01, 2017 at 07:35:40PM +0100, Wolfram Sang wrote:
>>
>> > >  .../bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt}         | 0
>> > >  1 file changed, 0 insertions(+), 0 deletions(-)
>> > >  rename Documentation/devicetree/bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt} (100%)
>> >
>> > Just keep the same name. We can use it for SPI too at least.
>>
>> OK, will resend with your requested changes.
>
> Thinking about it some more:
>
> Shall I resend now or won't it be easier if I resend at the end of the
> next merge window to reduce merge conflicts?

Yes, that sounds good.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
