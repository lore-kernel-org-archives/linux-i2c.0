From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v3 3/5] i2c:ocores: add polling interface
Date: Mon, 11 Feb 2019 09:20:32 +0100
Message-ID: <1894984.UOdFTssdus@pcbe13614>
References: <20190208161201.7860-1-federico.vaga@cern.ch> <20190208161201.7860-4-federico.vaga@cern.ch> <20190209213353.GA9061@lunn.ch>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209213353.GA9061@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Saturday, February 9, 2019 10:33:53 PM CET Andrew Lunn wrote:
> > +static int ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +	u8 mask;
> > +	int err;
> > +
> > +	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
> > +		/* transfer is over */
> > +		mask = OCI2C_STAT_BUSY;
> > +	} else {
> > +		/* on going transfer */
> > +		mask = OCI2C_STAT_TIP;
> > +		udelay((8 * 1000) / i2c->bus_clock_khz);
> > +	}
> > +
> > +	/*
> > +	 * once we are here we expect to get the expected result immediately
> > +	 * so if after 1ms we timeout then something is broken.
> > +	 */
> > +	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> 
> Hi Federico
> 
> I did some timing tests for this. On my box, we request a udelay of
> 80uS. The kernel actually delays for about 79uS. We then spin in
> ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> 
> There are actually 9 bits on the wire, not 8, since there is an
> ACK/NACK bit after the actual data transfer. So i changed the delay to
> (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> not looping at all. But for reading an 4K AT24 EEPROM, it increased
> the read time by 10ms, from 424ms to 434ms. So we should probably keep
> with 8.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

I had a similar experience. I will add a comment in the code to explain that 8 
is not a mistake but a conscious decision. Then I will add what you wrote here
in the patch changelog

> 
>     Andrew
