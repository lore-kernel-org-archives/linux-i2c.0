From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 03 Jul 2013 10:33:22 +0200
Message-ID: <51D3E1D2.4070706@free-electrons.com>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <1372752969.4277.8.camel@weser.hi.pengutronix.de> <201307030438.50069.marex@denx.de> <201307030637.05324.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <201307030637.05324.marex@denx.de>
Sender: stable-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, wsa@the-dreams.de, shawn.guo@linaro.org, kernel@pengutronix.de, linux-i2c@vger.kernel.org, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Marek,

On 03/07/2013 06:37, Marek Vasut wrote:
> 
> I'm attaching a patch. Alex, please give it a go and see if it fixes your issue. 
> It is _VERY_ ugly.
>

Quite ugly ;)

It indeed seems to fix the issue.

> The basic idea behind the the patch is that, as (attempted to be) explained 
> above, subsequent writes to DATA register in PIO mode cause constant generation 
> of clock on the bus and therefore a very long transfer of zero data. This 
> confuses the I2C peripherals of course.
> 
> The patch implements clock stretching for PIO writes (maybe we need this for 
> reads too) by making the controller blast out only 4 (or less) bytes of data in 
> each write into the DATA register. To prevent interruption of the transfer 
> between writes into the DATA register, the SCK is held low using the 
> RETAIN_CLOCK bit.
> 
> But (!) here comes the caveat. The PIO was introduced to speed up small 
> transfers. Introducing clock stretching into PIO mode operation might completely 
> remove this advantage. This has to be measured again.
> 

And now, PIO mode is slower than DMA...


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
