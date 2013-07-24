From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 24 Jul 2013 00:09:30 -0300
Message-ID: <CAOMZO5DqeMGgM9uTM5jZ_96_T2dWGBLDUfVf9JNqo2gypLDgvA@mail.gmail.com>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
	<CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg@mail.gmail.com>
	<CAOMZO5A8E54i+hKo5VFWmtuntDHH7O+z6Wb1NL0EkYJ=EQnj5w@mail.gmail.com>
	<201307240502.36129.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <201307240502.36129.marex@denx.de>
Sender: stable-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Marek,

On Wed, Jul 24, 2013 at 12:02 AM, Marek Vasut <marex@denx.de> wrote:

> Yes, the big question is if we want to use this patch or fix the PIO. I think
> this one is much less intrusive, so I'd vouch for yours for 3.10 .

Correct. Also according to Documentation/stable_kernel_rules.txt :

"Rules on what kind of patches are accepted, and which ones are not, into the
"-stable" tree:

....
 - It cannot be bigger than 100 lines, with context."

Your PIO fix is really appreciated, but it surpasses 100 lines, so it
would be better if we go with this one first so that it can reach
3.10, and then we can use your PIO fix later.

Regards,

Fabio Estevam
