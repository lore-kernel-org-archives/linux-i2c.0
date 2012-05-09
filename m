From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
Date: Wed, 9 May 2012 20:03:09 +0800
Message-ID: <CAAQ0ZWT4nqA8k=xTHcBvW5d7_KnbiLU73adfWv3_PVvG0YXknQ@mail.gmail.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
	<1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
	<20120509115041.GM3955@opensource.wolfsonmicro.com>
	<CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 9 May 2012 19:59, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 9 May 2012 19:50, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>=
 wrote:
>> On Wed, May 09, 2012 at 07:33:05PM +0800, Richard Zhao wrote:
>>> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>
>> I'll apply this when devm_clk_get() makes it into mainline (hopefull=
y in
>> the merge window); please remind me if I forget.
>
> We will have rmk's clkdev branch appear on arm-soc as dependency
> anyway. =A0Can we have this series go over arm-soc tree, since we wil=
l
> have all the dependencies on clk and pinctrl meet and conflicts solve=
d
> there?
>
Ah, I just realized that the prerequisite patches on fsl_ssi.c have
already applied on sound tree, so yes, we have to wait for the next
merge window then.

Regards,
Shawn
