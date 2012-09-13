From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: (algo-pca) Fix chip reset function for PCA9665
Date: Thu, 13 Sep 2012 06:41:28 -0700
Message-ID: <20120913134128.GA1343@roeck-us.net>
References: <1347507591-32352-1-git-send-email-linux@roeck-us.net>
 <20120913101423.GE14237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120913101423.GE14237-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 13, 2012 at 12:14:23PM +0200, Wolfram Sang wrote:
> On Wed, Sep 12, 2012 at 08:39:50PM -0700, Guenter Roeck wrote:
> > From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> > 
> > The parameter passed to pca9665_reset is adap->data, not adap. Unless
> > adap->data happens to point back to adap, this can result in a kernel panic.
> 
> Like every write and read to a register which uses the same assumption
> AFAICS?
> 
You lost me there. Other reset functions are aware of and use the passed parameter
(adap->data). pca9665_reset overwrites the original reset function with
	pca_data->reset_chip = pca9665_reset;
but not ->data (which it can't overwrite since it is used by the read_byte and
write_byte functions). 

	static void pca9665_reset(void *pd)
		struct i2c_algo_pca_data *adap = pd;
	static void i2c_pca_pf_resetchip(void *pd)
		struct i2c_pca_pf_data *i2c = pd;
	static int i2c_pca_pf_readbyte32(void *pd, int reg)
		struct i2c_pca_pf_data *i2c = pd;

Guenter
