From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: (algo-pca) Fix mode selection for PCA9665
Date: Thu, 13 Sep 2012 06:44:39 -0700
Message-ID: <20120913134439.GA1400@roeck-us.net>
References: <1347507591-32352-1-git-send-email-linux@roeck-us.net>
 <1347507591-32352-2-git-send-email-linux@roeck-us.net>
 <20120913100530.GD14237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120913100530.GD14237-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 13, 2012 at 12:05:31PM +0200, Wolfram Sang wrote:
> On Wed, Sep 12, 2012 at 08:39:51PM -0700, Guenter Roeck wrote:
> > From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> > 
> > As implemented, the code always selects turbo mode for PCA9665, no matter which
> > clock frequency is configured. This is because it compares clock boundaries
> > against constants reflecting (boundary / 100), but uses the actual clock frequency
> > to compare against. To fix the problem, use a variable reflecting (clock / 100),
> > not the actual clock frequency, when comparing against (boundary / 100).
> 
> Good point, however...
> 
> > 
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> > Signed-off-by: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> > ---
> >  drivers/i2c/algos/i2c-algo-pca.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
> > index 07ccbef..572251b 100644
> > --- a/drivers/i2c/algos/i2c-algo-pca.c
> > +++ b/drivers/i2c/algos/i2c-algo-pca.c
> > @@ -477,17 +477,17 @@ static int pca_init(struct i2c_adapter *adap)
> >  		/* To avoid integer overflow, use clock/100 for calculations */
> >  		clock = pca_clock(pca_data) / 100;
> >  
> > -		if (pca_data->i2c_clock > 10000) {
> > +		if (clock > 10000) {
> 
> ... we should make the code more readable if we are at it.
> I'd suggest to drop the "/ 100" from above and move it below this
> if-block. This will allow for much more readable comparisons, e.g.
> "clock > 1000000" etc which is really the clock in Hz.
> 
We can simply compare against the real frequency:
		if (pca_data->i2c_clock > 1000000) {
which also makes the description a bit easier to understand.

> >  			mode = I2C_PCA_MODE_TURBO;
> >  			min_tlow = 14;
> >  			min_thi  = 5;
> >  			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
> > -		} else if (pca_data->i2c_clock > 4000) {
> > +		} else if (clock > 4000) {
> >  			mode = I2C_PCA_MODE_FASTP;
> >  			min_tlow = 17;
> >  			min_thi  = 9;
> >  			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
> > -		} else if (pca_data->i2c_clock > 1000) {
> > +		} else if (clock > 1000) {
> >  			mode = I2C_PCA_MODE_FAST;
> >  			min_tlow = 44;
> >  			min_thi  = 20;
> > -- 
> > 1.7.9.7
> > 
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
