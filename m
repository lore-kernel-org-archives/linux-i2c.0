From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH 3/5] i2c: i2c-stm32f7: add driver
Date: Fri, 17 Mar 2017 23:38:19 +0100
Message-ID: <CAOAejn00O7n1UAyH7VTbgT076ZxS20TSvzfEfgw8bsA80Qgdyg@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
 <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
 <971895d3-2fe6-ecb6-9dc3-ee71193b34ee@baylibre.com>
 <CAOAejn0ScANyMEWnBfe0G8xQ5TbR-XYwEdXLkNexqC=AigBNJA@mail.gmail.com>
 <5539f058-f2a1-ff78-6dd8-aa2119ce8c49@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5539f058-f2a1-ff78-6dd8-aa2119ce8c49@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Neil,

>> As, I2C rise/fall time have some impacts in I2C timings value, the
>> question is: it is very relevant to let customer control these
>> parameters ?
>
> Actually, you could specify a different rise time in DT if it's relevant for
> a specific design, this is why you have the following DT attributes :
> - i2c-scl-falling-time-ns
> - i2c-scl-internal-delay-ns
> - i2c-scl-rising-time-ns
> - i2c-sda-falling-time-ns
>
>> If the answer is NO, I agree with you, it is better to use your
>> formula and remove this property from DT.
>> If the answer is YES, I think we should keep ST tool.
>
> Note that the ST tool calculations are tied to the clock source frequency, so either
> you provide a table for all the possible clock source frequencies or calculate dynamically.
> Having a single parameter for a single frequency is, from my point of view, not acceptable.
>
> And, I don't think it's a military secret to have (at least) a simplified algorithm from ST...
> since you have very detailed explanations in the public manuals !

OK. I will do some trials with your algorithm and push it in the V2.
Thanks

>
> OK, but I think the I2C and DT maintainers are also involved in these kind of decisions.
> They should also give their advice.

I already upstream an I2C driver with this approach: "i2c-stm32f4".
I don't think that Wolfram or Rob will change the philosophy for this driver.
Then, I also don't think that the machine code for F0/F1/L0/L4 will be
pushed in the mainline as it will be completely useless to port a
linux kernel for this kind of chip.

BR,
Cedric
