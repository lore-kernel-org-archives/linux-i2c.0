From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] i2c-tools: add new tool 'i2ctransfer'
Date: Mon, 13 Mar 2017 14:51:49 +0100
Message-ID: <20170313135149.whr6ga4d52oy4wis@pengutronix.de>
References: <20170313114135.2327-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313114135.2327-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Mon, Mar 13, 2017 at 12:41:35PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.
> 
> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangerous,
> but it can also be very useful when developing.
> 
> It has been tested with various Renesas I2C IP cores as well as Tegra,
> i.MX and AT91.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
