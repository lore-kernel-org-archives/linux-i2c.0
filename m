From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] misc: eeprom: implement compatible DT probing
Date: Fri, 9 Dec 2016 06:48:17 +0100
Message-ID: <806f55f3-3fed-572d-4859-7c7dc76c5e08@axentia.se>
References: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org>
 <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se>
 <CACRpkda+_0+y6U-gjt2ym45gi=KZ69hixMw6T=tAQGTGy5J37Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkda+_0+y6U-gjt2ym45gi=KZ69hixMw6T=tAQGTGy5J37Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-12-09 00:32, Linus Walleij wrote:
> On Thu, Dec 8, 2016 at 7:23 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>> On 2016-12-08 18:47, Linus Walleij wrote:
> 
>>> Before this patch, the following device tree node does not probe,
>>> which might be considered a bug:
>>>
>>> eeprom@52 {
>>>       compatible = "atmel,at24c128";
>>
>> The way I read it, that should be "atmel,24c128", i.e. w/o the "at" prefix.
> (...)
>> and then lists the compatibles you have added to the match table (but you
>> have this extra "at" prefix for the atmel manufacturer).
>>
>> The way I read the above, you are free to use any manufacturer and still
>> have it work, and indeed, I have success with this node:
>>
>>         eeprom@50 {
>>                 compatible = "nxp,24c02";
>>                 reg = <0x50>;
>>                 pagesize = <16>;
>>         };
>>
>> I fear that your patch will regress this matching on the wildcard
>> manufacturer. I haven't tested that though, but there are enough
>> question marks anyway...
> 
> Bah I probably just screwed up syntactically and now worked around
> a non-existing problem. I will try as you suggest, just "vendor,type"
> and see if it works. It probably does.

But it is a bit strange. Grepping for compatible.*24c finds quite
a few instances of "bad" compatible strings.

Many on the patterns at,24c256 and at24,24c256 (should be probably
be atmel,24c256) but also a few atmel,at24c16 and atmel,at24c128b.
I don't understand how those last ones ever worked, if it is not
working for you? Especially those with the trailing "b". WTF?

> Some days I feel just utterly stupid. Sorry for the fuzz.

Join the club...

Cheers,
Peter

> Wolfram: ignore the patch for now.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
