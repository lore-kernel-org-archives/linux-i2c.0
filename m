From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon, 15 Jul 2013 10:30:59 -0300
Message-ID: <CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg@mail.gmail.com>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
	<20130702022342.GZ13206@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20130702022342.GZ13206@S2101-09.ap.freescale.net>
Sender: stable-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de
Cc: marex@denx.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Jul 1, 2013 at 11:23 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jul 01, 2013 at 06:14:21PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Recently we have been seing some reports about PIO mode not working properly.
>>
>> - http://www.spinics.net/lists/linux-i2c/msg11985.html
>> - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
>> - https://lkml.org/lkml/2013/6/24/430
>>
> It also causes sgtl5000 register write failure [1].  Changing it back to
> DMA mode fixes the failure.  So,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> [1] http://thread.gmane.org/gmane.linux.alsa.devel/109715/focus=109747
>

Any comment about this patch, please?

If you are happy with it, could we please have it applied into stable?

3.10 is currently broken without this patch.

Regards,

Fabio Estevam
