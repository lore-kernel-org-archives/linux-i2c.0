From: Robin Holt <holt-sJ/iWh9BUns@public.gmane.org>
Subject: Xilinx iic i2c bus interface GPIO support for i2c-mux in Linux.
Date: Wed, 8 Feb 2012 13:46:15 -0600
Message-ID: <20120208194615.GT14907@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, info-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We are using a Xilinx FPGA which implements a series of i2c bus
interfaces.  We are planning on implementing a single-bit GPIO
(XIIC_GPO_REG_OFFSET) which is included in that logic block to act
as a MUX selector (also in the FPGA) between two separate i2c busses.

This will require a GPIO driver in the linux kernel.

Is it better to try and change the i2c-xiic.c code which already knows
about the GPO register to handle that additional GPIO or should we be
implementing the GPIO driver outside the i2c driver and then use the
standard i2c-mux support available in newer kernels?

Any guidance is welcome.

Thanks,
Robin Holt
