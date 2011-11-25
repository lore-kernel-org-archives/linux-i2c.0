From: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 0/5] AT91: replace broken TWI driver i2c-at91.c
Date: Fri, 25 Nov 2011 16:42:13 +0100
Message-ID: <4ECFB755.6060509@gmail.com>
References: <cover.1322062555.git.n.voss@weinmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1322062555.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I've tested this driver on a 2.6.38 kernel with several i2c clients
(temp-sensor, audio-codec, touchscreen-controller, w1-bridge,
io-expanders) and works without problems. SoC: at91sam9g45

Because of the 2.6.38 kernel, I had to skip "[PATCH v7 2/5] Replace
clk_lookup.con_id with clk_lookup.dev_id entries for twi clk" and used
instead: at91_clock_associate("twi0_clk", &at91sam9g45_twi0_device.dev,
"twi_clk");

Best Regards
Hubert

On 2011-11-23 16:35, Nikolaus Voss wrote:
> The old driver has two main deficencies:
> i)  No repeated start (Sr) condiction is possible, this makes it unusable
>     e.g. for most SMBus transfers.
> ii) I/O was done with polling/busy waiting what caused over-/underruns
>     even at light system loads and clock speeds.
> 
> The new driver overcomes these deficencies and in addition allows for
> more than one TWI interface.
> 

Tested-by: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
