From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/5] I2C: DaVinci: clock between 7-12 Mhz
Date: Fri, 28 Mar 2008 21:36:49 +0100
Message-ID: <20080328213649.508b4f3c@hyperion.delvare>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
	<20080327163626.75d1bd51@hyperion.delvare>
	<47ED4F3A.5060007@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47ED4F3A.5060007-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 28 Mar 2008 13:04:10 -0700, Troy Kisky wrote:
> Jean Delvare wrote:
> > Hi Troy,
> > 
> > On Thu, 20 Mar 2008 20:06:07 -0700, Troy Kisky wrote:
> >> Ensure psc value gives a clock between 7-12 Mhz
> > 
> > Correct spelling is MHz.
> > 
> >> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> >> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/i2c/busses/i2c-davinci.c |   19 ++++++++++++-------
> >>  1 files changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> >> index fde2634..82d4b7f 100755
> >> --- a/drivers/i2c/busses/i2c-davinci.c
> >> +++ b/drivers/i2c/busses/i2c-davinci.c
> >> @@ -142,6 +142,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> >>  	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> >>  	u16 psc;
> >>  	u32 clk;
> >> +	u32 d;
> >>  	u32 clkh;
> >>  	u32 clkl;
> >>  	u32 input_clock = clk_get_rate(dev->clk);
> >> @@ -171,23 +172,29 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> >>  	 *       if PSC > 1 , d = 5
> >>  	 */
> >>  
> >> -	psc = 26; /* To get 1MHz clock */
> >> +	/* get minimum of 7mHz clock, but max of 12mHz */
> > 
> > Correct spelling is MHz.
> 
> 
> Hmm... I seems weird that kHz and MHz are correct, as opposed to
> kHz and mHz,  or KHz and MHz.

These are the standard international unit prefixes. Please see:
http://en.wikipedia.org/wiki/SI_prefix#List_of_SI_prefixes
kilo- is "k", mega- is "M". "m" would be milli-, which isn't what you
want here.

> 
> > 
> >> +	psc = (input_clock/7000000)-1;
> > 
> > The usual coding style is to leave spaces around all operators. Same
> > problem below.
> > 
> > Note: if input_clock < 7000000, you're in trouble.
> > 
> >> +	if ((input_clock/(psc+1)) > 12000000)
> >> +		psc++;
> > 
> > The only case where this will happen as far as I can see is if
> > input_clock is between 12 and 14 MHz. In this case, you'll get a clock
> > lower than 7 MHz (worst case is 6 MHz). Is this OK?
> 
> Since it was running out of spec at 1 Mhz, I figured running under
> spec is better than over.

My question was rather, don't you prefer to fail and exit if you can't
get the frequency you want? It really depends on what the consequences
are. I have no idea what was happening with the clock wrongly running
at 1 MHz.

> 
> > 
> >> +	d = (psc >= 2)? 5 : 7 - psc;
> >>  
> >> -	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - 10;
> >> -	clkh = (50 * clk) / 100;
> >> +	clk = ((input_clock/(psc+1)) / (pdata->bus_freq * 1000)) - (d<<1);
> >> +	clkh = clk>>1;
> >>  	clkl = clk - clkh;
> >>  
> >>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_PSC_REG, psc);
> >>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
> >>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
> >>  
> >> -	dev_dbg(dev->dev, "CLK  = %d\n", clk);
> >> +	dev_dbg(dev->dev, "input_clock=%d, CLK  = %d\n", input_clock, clk);
> > 
> > As I already wrote in my previous review: please come up with
> > consistent spacing in this debugging message. Having no space around
> > the first "=", but two spaced before and one after the second "=",
> > doesn't look good.
> 
> Agreed..
> But the previous message was
> > > +	dev_dbg(dev->dev, "input_clock=%d, CLK  = %d\n", input_clock,clk);
> >
> > Please come up with consistent spacing in this debugging message.
> > Missing space after comma.
> And I interpreted you incorrectly. I didn't ignore you.
> 
> 
> > 
> >>  	dev_dbg(dev->dev, "PSC  = %d\n",
> >>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
> >>  	dev_dbg(dev->dev, "CLKL = %d\n",
> >>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
> >>  	dev_dbg(dev->dev, "CLKH = %d\n",
> >>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
> >> +	dev_dbg(dev->dev, "bus_freq = %dkHz bus_delay = %d\n",
> > 
> > For consistency, you should add a comma after kHz.
> > 
> >> +		pdata->bus_freq, pdata->bus_delay);
> >>  
> >>  	/* Take the I2C module out of reset: */
> >>  	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >> @@ -338,12 +345,10 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >>  
> >>  	for (i = 0; i < num; i++) {
> >>  		ret = i2c_davinci_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> >> +		dev_dbg(dev->dev, "%s ret: %d\n", __func__, ret);
> >>  		if (ret < 0)
> >>  			return ret;
> >>  	}
> >> -
> >> -	dev_dbg(dev->dev, "%s:%d ret: %d\n", __FUNCTION__, __LINE__, ret);
> >> -
> >>  	return num;
> >>  }
> >>  
> > 
> > Not sure how this last chunk is supposed to belong to this patch?
> > 
> Do you want a separate patch? Or just a comment that a dev_dbg was moved so that
> it prints always instead of just on no error?

A separate patch would be better, yes. I know it might sound overkill,
but small patches doing just one thing are much easier to review,
merge, and backport if needs be.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
