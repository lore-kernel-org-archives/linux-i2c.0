From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/5] I2C: DaVinci: clock between 7-12 Mhz
Date: Fri, 25 Apr 2008 11:41:46 +0200
Message-ID: <20080425114146.2dbedee6@hyperion.delvare>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
	<20080327163626.75d1bd51@hyperion.delvare>
	<47ED4F3A.5060007@boundarydevices.com>
	<20080328213649.508b4f3c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080328213649.508b4f3c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Hi Troy,

On Fri, 28 Mar 2008 21:36:49 +0100, Jean Delvare wrote:
> On Fri, 28 Mar 2008 13:04:10 -0700, Troy Kisky wrote:
> > Jean Delvare wrote:
> > > Hi Troy,
> > > 
> > > On Thu, 20 Mar 2008 20:06:07 -0700, Troy Kisky wrote:
> > >> Ensure psc value gives a clock between 7-12 Mhz
> > > 
> > > Correct spelling is MHz.
> > > 
> > >> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> > >> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > >> ---
> > >>  drivers/i2c/busses/i2c-davinci.c |   19 ++++++++++++-------
> > >>  1 files changed, 12 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> > >> index fde2634..82d4b7f 100755
> > >> --- a/drivers/i2c/busses/i2c-davinci.c
> > >> +++ b/drivers/i2c/busses/i2c-davinci.c
> > >> @@ -142,6 +142,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> > >>  	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> > >>  	u16 psc;
> > >>  	u32 clk;
> > >> +	u32 d;
> > >>  	u32 clkh;
> > >>  	u32 clkl;
> > >>  	u32 input_clock = clk_get_rate(dev->clk);
> > >> @@ -171,23 +172,29 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> > >>  	 *       if PSC > 1 , d = 5
> > >>  	 */
> > >>  
> > >> -	psc = 26; /* To get 1MHz clock */
> > >> +	/* get minimum of 7mHz clock, but max of 12mHz */
> > > 
> > > Correct spelling is MHz.
> > 
> > 
> > Hmm... I seems weird that kHz and MHz are correct, as opposed to
> > kHz and mHz,  or KHz and MHz.
> 
> These are the standard international unit prefixes. Please see:
> http://en.wikipedia.org/wiki/SI_prefix#List_of_SI_prefixes
> kilo- is "k", mega- is "M". "m" would be milli-, which isn't what you
> want here.

<snip>

Any update available for this patch? If you want it (and patch 3/5 of
this series) to go in 2.6.26 we better hurry up.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
