From: Adrian Yanes <devel@ayanes.com>
Subject: Re: [PATCH] i2c-at91: fix data-loss issue
Date: Mon, 23 Apr 2012 09:24:24 +0300
Message-ID: <4F94F598.1040008@ayanes.com>
References: <20120413103937.GH7154@arwen.pp.htv.fi> <1334317476-10044-1-git-send-email-h.feurstein@gmail.com> <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com> <20120418143920.GA19802@pengutronix.de> <4F930B77.8070909@ayanes.com> <EF2E73589CA71846A15D0B2CDF79505D0905DB4657@wm021.weinmann.com>
Reply-To: devel@ayanes.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905DB4657@wm021.weinmann.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.orglinux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> The latter is probably the easiest and most transparent solution.
> There is no UNRE on G45, it just pauses the clock on an underrun
> condition.
> 
> So in case UNRE is set, EIO should be returned similar to the already
> handled OVRE:
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a6f9e73..a84e19b 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -238,6 +238,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		dev_err(dev->dev, "overrun while reading\n");
>  		return -EIO;
>  	}
> +	if (dev->transfer_status & AT91_TWI_UNRE && dev->is_rm9200) {
> +		dev_err(dev->dev, "underrun while writing\n");
> +		return -EIO;
> +	}
> +
>  	dev_dbg(dev->dev, "transfer complete\n");
>  
>  	return 0;

Indeed, this should be added in order to catch this exception for the
AT91RM9200.

However, the main issue still there: the board is not able to deliver
data up to 2 bytes size without to run in the UNRE case.

Measuring the i2c bus, we verified that the data is not even arriving to
the data bus, i.e. either the kernel driver is too slow to handle it or
just we are missing some tweak required by the hardware
(nevertheless the datasheet does not give any clue).

Anyone with a AT91RM9200 that can test the proposed driver as well? it
will discard that is our hardware/board the issue rather than the
chipset itself.

Adrian
