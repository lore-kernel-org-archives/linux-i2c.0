From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Kconfig: Allow I2C_MXS to be selected by MX23
Date: Mon, 19 Nov 2012 09:30:22 -0200
Message-ID: <CAOMZO5Ag_evHUGdFFFccz1Q0Jsqwqd-25h7LcEDGeyQei8r9Rg@mail.gmail.com>
References: <1353181734-13253-1-git-send-email-festevam@gmail.com>
	<20121119084958.GB7775@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121119084958.GB7775-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: f.koliqi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Nov 19, 2012 at 6:49 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Sat, Nov 17, 2012 at 05:48:54PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>
>> With the recent DMA support addition to the i2c-mxs driver, it is now possible
>> to also run it on mx23, so update the Kconfig entry accordingly.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Did you test it?

I don't have the I2C connector board for mx23-olinuxino, but I have
been helping Fadil Berisha (on Cc) to get I2C to work on mx23.

He managed to get I2C working on his mx23 board and posted the results at:
https://www.olimex.com/forum/index.php?topic=283.msg1086#msg1086

He has already sent the dts patches to the ARM kernel list.

Regards,

Fabio Estevam
