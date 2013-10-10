From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/3] i2c: xilinx: Fix i2c checkpatch warnings
Date: Thu, 10 Oct 2013 07:01:23 -0700
Message-ID: <1381413683.14017.9.camel@joe-AO722>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, wsa@the-dreams.de, Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Jean Delvare <khali@linux-fr.org>, Peter Korsgaard <jacmet@sunsite.dk>, Kedareswara rao Appana <appanad@xilinx.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2013-10-10 at 12:39 +0200, Michal Simek wrote:
> Code changes to fix checkpatch warnings listed below.
> - WARNING: quoted string split across lines
[]
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
[]
> @@ -271,11 +271,8 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
> 
>  	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
> 
> -	dev_dbg(i2c->adap.dev.parent, "%s entry, bytes in fifo: %d, msg: %d"
> -		", SR: 0x%x, CR: 0x%x\n",
> -		__func__, bytes_in_fifo, xiic_rx_space(i2c),
> -		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
> -		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
> +	dev_dbg(i2c->adap.dev.parent, "%s entry, bytes in fifo: %d, msg: %d",
> +		__func__, bytes_in_fifo, xiic_rx_space(i2c));

This is a pretty odd way of silencing checkpatch
by eliminating content.  Aren't the register values
useful information?

You've also removed the terminating newline.
It's necessary to avoid possible dmesg output log
message interleaving.  Please put it back.

A more normal style fix would be to coalesce the
format.  checkpatch will ignore lines exceeding
80 columns for these formats.

	dev_dbg(i2c->adap.dev.parent, "%s entry, bytes in fifo: %d, msg: %d, SR: 0x%x, CR: 0x%x\n",
		__func__, bytes_in_fifo, xiic_rx_space(i2c),
		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));

This passes checkpatch cleanly.

etc...
