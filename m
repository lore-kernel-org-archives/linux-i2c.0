From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date: Mon, 11 Feb 2019 14:47:47 +0100
Message-ID: <2252068.1XvXk90vR3@pcbe13614>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-4-federico.vaga@cern.ch> <20190211102526.3y46r43usznu4jgp@ninjato>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211102526.3y46r43usznu4jgp@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday, February 11, 2019 11:25:26 AM CET Wolfram Sang wrote:
> On Mon, Feb 11, 2019 at 09:31:20AM +0100, Federico Vaga wrote:
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version.
> > 
> > Report from Andrew Lunn:
> >   I did some timing tests for this. On my box, we request a udelay of
> >   80uS. The kernel actually delays for about 79uS. We then spin in
> >   ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> >   
> >   There are actually 9 bits on the wire, not 8, since there is an
> >   ACK/NACK bit after the actual data transfer. So i changed the delay to
> >   (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> >   not looping at all. But for reading an 4K AT24 EEPROM, it increased
> >   the read time by 10ms, from 424ms to 434ms. So we should probably keep
> >   with 8.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Fixed these checkpatch warnings:
> 
> WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
> #111: FILE: drivers/i2c/busses/i2c-ocores.c:306:
> +		 * We wait for the data to be transfered (8bit),
> 
> CHECK: Please don't use multiple blank lines
> #129: FILE: drivers/i2c/busses/i2c-ocores.c:324:
> +
> +
> 
> WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
> #154: FILE: drivers/i2c/busses/i2c-ocores.c:349:
> +			break; /* all messages have been transfered */
> 
> and applied to for-next, thanks!

I will resend this patch as v5 to add the fix suggested by Peter Rosin
