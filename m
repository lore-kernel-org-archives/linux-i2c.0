From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c designware make SCL and SDA falling time
 configurable
Date: Wed, 9 Oct 2013 10:55:38 +0300
Message-ID: <20131009075538.GQ3521@intel.com>
References: <20130828153429.GB7066@ab42.lan>
 <1381244455-3836-1-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381244455-3836-1-git-send-email-romainba@abilis.com>
Sender: linux-doc-owner@vger.kernel.org
To: Romain Baeriswyl <Romain.Baeriswyl@abilis.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, Vineet Gupta <vgupta@synopsys.com>, Christian Ruppert <christian.ruppert@abilis.com>, Chiau Ee Chew <chiau.ee.chew@intel.com>, Shinya Kuribayashi <skuribay@pobox.com>, Jean Delvare <khali@linux-fr.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Romain Baeriswyl <romainba@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 08, 2013 at 05:00:54PM +0200, Romain Baeriswyl wrote:
>  static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
> @@ -286,6 +287,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	u32 input_clock_khz;
>  	u32 hcnt, lcnt;
>  	u32 reg;
> +	u32 sda_falling_time, scl_falling_time;
>  
>  	input_clock_khz = dev->get_clk_rate_khz(dev);
>  
> @@ -307,15 +309,25 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  
>  	/* set standard and fast speed deviders for high/low periods */
>  
> +	if (dev->sda_falling_time)
> +		sda_falling_time = dev->sda_falling_time;
> +	else
> +		sda_falling_time = 300; /* ns */

I think this looks better:

	sda_falling_time = dev->sda_falling_time ? dev->sda_falling_time : 300;

> +
> +	if (dev->scl_falling_time)
> +		scl_falling_time = dev->scl_falling_time;
> +	else
> +		scl_falling_time = 300; /* ns */

Ditto.

> +
>  	/* Standard-mode */
>  	hcnt = i2c_dw_scl_hcnt(input_clock_khz,
> -				40,	/* tHD;STA = tHIGH = 4.0 us */
> -				3,	/* tf = 0.3 us */
> +				4000,	/* tHD;STA = tHIGH = 4.0 us */
> +				sda_falling_time,
>  				0,	/* 0: DW default, 1: Ideal */
>  				0);	/* No offset */
>  	lcnt = i2c_dw_scl_lcnt(input_clock_khz,
> -				47,	/* tLOW = 4.7 us */
> -				3,	/* tf = 0.3 us */
> +				4700,	/* tLOW = 4.7 us */
> +				scl_falling_time,
>  				0);	/* No offset */
>  
>  	/* Allow platforms to specify the ideal HCNT and LCNT values */
