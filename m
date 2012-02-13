From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Xilinx iic i2c bus interface GPIO support for i2c-mux in Linux.
Date: Mon, 13 Feb 2012 23:12:13 +0000
Message-ID: <20120213231212.GD2999@freya.fluff.org>
References: <20120208194615.GT14907@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120208194615.GT14907-sJ/iWh9BUns@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Holt <holt-sJ/iWh9BUns@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, info-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 08, 2012 at 01:46:15PM -0600, Robin Holt wrote:
> We are using a Xilinx FPGA which implements a series of i2c bus
> interfaces.  We are planning on implementing a single-bit GPIO
> (XIIC_GPO_REG_OFFSET) which is included in that logic block to act
> as a MUX selector (also in the FPGA) between two separate i2c busses.
> 
> This will require a GPIO driver in the linux kernel.

There's already a general purpose GPIO driver so that should not be a
problem.
 
> Is it better to try and change the i2c-xiic.c code which already knows
> about the GPO register to handle that additional GPIO or should we be
> implementing the GPIO driver outside the i2c driver and then use the
> standard i2c-mux support available in newer kernels?

My feelings would be to try and use the standard i2c-mux support if
possible.
 
> Any guidance is welcome.
> 
> Thanks,
> Robin Holt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
