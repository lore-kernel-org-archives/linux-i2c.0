From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date: Sat, 21 Jul 2018 19:15:15 +0200
Message-ID: <20180721191515.6b20d23b@bbrezillon>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
        <20180720215801.dmklhwxsgakj4exd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215801.dmklhwxsgakj4exd@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vitor soares <Vitor.Soares@synopsys.com>, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, Joao.Pinto@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 20 Jul 2018 23:58:01 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Fri, Jul 20, 2018 at 09:57:49PM +0100, Vitor soares wrote:
> > This patch series is a proposal for the I3C master driver for Synopsys IP.
> > This patch is to be applied on top of I3C subsystem RFC V6 submitted
> > by Boris Brezillon.  
> 
> Nice! More users will help the subsystem evolve.
> 
> Yet, I also think this may be a good timing for a seperate I3C mailing
> list? We can always cross-post if I2C is relevant, but I guess new I3C
> masters usually are very I3C specific. I think a seperate mailing list
> would also look good in the MAINTAINERS entry.
> 

I was waiting for the I3C framework to be merged before creating the ML
and the git repo, but if you think we should do that now I can create
them.

Regards,

Boris
