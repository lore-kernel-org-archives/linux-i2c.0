From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 24 Jul 2013 05:02:35 +0200
Message-ID: <201307240502.36129.marex@denx.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg@mail.gmail.com> <CAOMZO5A8E54i+hKo5VFWmtuntDHH7O+z6Wb1NL0EkYJ=EQnj5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5A8E54i+hKo5VFWmtuntDHH7O+z6Wb1NL0EkYJ=EQnj5w@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> Wolfram,
> 
> On Mon, Jul 15, 2013 at 10:30 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > Any comment about this patch, please?
> > 
> > If you are happy with it, could we please have it applied into stable?
> > 
> > 3.10 is currently broken without this patch.

Yes, the big question is if we want to use this patch or fix the PIO. I think 
this one is much less intrusive, so I'd vouch for yours for 3.10 .

Best regards,
Marek Vasut
