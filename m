From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 12 Jan 2017 13:03:09 +0100
Message-ID: <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello Cedric,

On Thu, Jan 12, 2017 at 12:23:12PM +0100, M'boumba Cedric Madianga wrote:
> 2017-01-11 16:39 GMT+01:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutroni=
x.de>:
> > On Wed, Jan 11, 2017 at 02:58:44PM +0100, M'boumba Cedric Madianga wrot=
e:
> >> 2017-01-11 9:22 GMT+01:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutro=
nix.de>:
> >> > This is surprising. I didn't recheck the manual, but that looks very
> >> > uncomfortable.
> >>
> >> I agree but this exactly the hardware way of working described in the
> >> reference manual.
> >
> > IMHO that's a hw bug. This makes it for example impossible to implement
> > SMBus block transfers (I think).
> =

> This is not correct.
> Setting STOP/START bit does not mean the the pulse will be sent right now.
> Here we have just to prepare the hardware for the 2 next pulse but the
> STOP/START/ACK pulse will be generated at the right time as required
> by I2C specification.
> So SMBus block transfer will be possible.

A block transfer consists of a byte that specifies the count of bytes
yet to come. So the device sends for example:

	0x01 0xab

So when you read the 1 in the first byte it's already too late to set
STOP to get it after the 2nd byte.

Not sure I got all the required details right, though.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
