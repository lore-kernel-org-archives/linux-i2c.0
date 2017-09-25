From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] [trivial] dt-bindings: i2c: i2c-mux: Spelling s/required
 is/required if/
Date: Mon, 25 Sep 2017 17:24:10 +0200
Message-ID: <CAMuHMdWMh5jnfeqxoczdq7SnEj7Sa-egcxgwCi-0y4bmQv6meg@mail.gmail.com>
References: <1505998349-10091-1-git-send-email-geert+renesas@glider.be> <2e6b5d12-f3aa-7228-9335-e3910e790109@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e6b5d12-f3aa-7228-9335-e3910e790109@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <trivial@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Mon, Sep 25, 2017 at 5:13 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-09-21 14:52, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Yes, this is trivial, both the patch and my complaint, but can you please
> add a "body of explanation" as suggested by submitting-patches in its topic
> "The canonical patch format"?

A patch should provide the answer to 3 questions: what?, why?, and how?,
and IMHO all of these have been answered.
What more can I say, besides duplicating the one-line summary?

> Maintainers accepting empty patch descriptions are publicly shamed, and
> I do not wish to be in that boat, sorry...

Are they? AFAIK only if they apply patches that need more explanation.

>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-mux.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux.txt b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
>> index 212e6779dc5c0caf..b38f58a1c8784184 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mux.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
>> @@ -6,10 +6,10 @@ multiplexer/switch will have one child node for each child bus.
>>
>>  Optional properties:
>>  - #address-cells = <1>;
>> -   This property is required is the i2c-mux child node does not exist.
>> +   This property is required if the i2c-mux child node does not exist.
>>
>>  - #size-cells = <0>;
>> -   This property is required is the i2c-mux child node does not exist.
>> +   This property is required if the i2c-mux child node does not exist.
>>
>>  - i2c-mux
>>     For i2c multiplexers/switches that have child nodes that are a mixture
>>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
