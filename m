From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date: Mon, 29 Oct 2018 14:21:51 +0100
Message-ID: <20181029142151.19f480b9@bbrezillon>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
        <20181029115633.GA5881@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029115633.GA5881@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vitor soares <vitor.soares@synopsys.com>, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com, luis.olive
List-Id: linux-i2c@vger.kernel.org

On Mon, 29 Oct 2018 11:56:34 +0000
Wolfram Sang <wsa@the-dreams.de> wrote:

> Boris,
> 
> > This patch series is a proposal for the I3C master driver for Synopsys IP.  
> 
> Any news on the I3C mailing list?

Nope, no news from DaveM so far. I pinged him twice (maybe my emails go
into his SPAM folder).

> It is not much yet, still I was
> wondering...
> 

The plan is to get the framework merged and then we'll have a good
argument to have the I3C ML created.

Alternatively, I could ask David Woodhouse to create a ML on infradead,
but I'd really prefer to have it on kernel.org.
