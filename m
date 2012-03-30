From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Date: Fri, 30 Mar 2012 17:47:44 +0900
Message-ID: <20120330084744.GF26543@linux-sh.org>
References: <20120330084402.19597.63655.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120330084402.19597.63655.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-i2c@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, w.sang@pengutronix.de, rjw@sisk.pl, ben-linux@fluff.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 30, 2012 at 05:44:02PM +0900, Magnus Damm wrote:
> +static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
> +	{ .compatible = "renesas,rmobile-iic", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
> +
Given that this block predates R-Mobile, using the rmobile naming here is
pretty dubious. I suppose you can have it as an alias, though.
