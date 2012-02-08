From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Xilinx iic i2c bus interface GPIO support for i2c-mux in Linux.
Date: Wed, 8 Feb 2012 20:54:29 +0100
Message-ID: <20120208205429.672c9092@endymion.delvare>
References: <20120208194615.GT14907@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120208194615.GT14907-sJ/iWh9BUns@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Holt <holt-sJ/iWh9BUns@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, info-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Robin,

On Wed, 8 Feb 2012 13:46:15 -0600, Robin Holt wrote:
> We are using a Xilinx FPGA which implements a series of i2c bus
> interfaces.  We are planning on implementing a single-bit GPIO
> (XIIC_GPO_REG_OFFSET) which is included in that logic block to act
> as a MUX selector (also in the FPGA) between two separate i2c busses.
> 
> This will require a GPIO driver in the linux kernel.
> 
> Is it better to try and change the i2c-xiic.c code which already knows
> about the GPO register to handle that additional GPIO or should we be
> implementing the GPIO driver outside the i2c driver and then use the
> standard i2c-mux support available in newer kernels?

Both are possible. It depends if there are other GPIOs on your FPGA
which you will have to access from other drivers for other purposes. If
there are such other GPIOs then it certainly makes sense to have a
clean, separate gpio driver for your FPGA, and have all consumers bind
to it. If not, then I'd keep things simple and embed everything in
i2c-xiic.c, especially if the two i2c buses are truly separated and
there is no common trunk (i2c-mux would create 3 segments.)

-- 
Jean Delvare
