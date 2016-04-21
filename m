From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 08/19] i2c: octeon: Enable High-Level Controller
Date: Thu, 21 Apr 2016 16:10:34 +0200
Message-ID: <20160421141034.GC2623@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com>
 <20160420214354.GD1546@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160420214354.GD1546@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 20, 2016 at 11:43:54PM +0200, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:39PM +0200, Jan Glauber wrote:
> > From: David Daney <ddaney@caviumnetworks.com>
> > 
> > Use High-Level Controller (HLC) when possible. The HLC can read/write
> > up to 8 bytes and is completely optional. The most important difference
> > of the HLC is that it only requires one interrupt for a transfer
> > (up to 8 bytes) where the low-level read/write requires 2 interrupts
> > plus one interrupt per transferred byte. Since the interrupts are costly
> > using the HLC improves the performance. Also, the HLC provides improved error
> > handling.
> 
> Much better description, thanks!
> 
> > +	while (1) {
> > +		val = octeon_i2c_ctl_read(i2c);
> > +		if (!(val & (TWSI_CTL_STA | TWSI_CTL_STP)));
> > +			break;
> > +
> > +		/* clear IFLG event */
> > +		if (val & TWSI_CTL_IFLG)
> > +			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
> > +
> > +		if (try++ > 100) {
> > +			pr_err("%s: giving up\n", __func__);
> > +			break;
> > +		}
> > +
> > +		/* spin until any start/stop has finished */
> > +		udelay(10);
> > +	}
> 
> Maybe you can use one of the readx_poll_timeout() functions?

Nice, but I don't think we can use readx_poll_timeout() here because
of the octeon_i2c_ctl_write inside the loop...
