From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] i2c-s3c2410: Convert to devm_kzalloc()
Date: Sat, 21 Jan 2012 17:57:14 +0000
Message-ID: <20120121175714.GD20505@sirena.org.uk>
References: <1327152527-11364-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F1AE36E.3070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F1AE36E.3070403@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jan 21, 2012 at 05:10:22PM +0100, Sylwester Nawrocki wrote:
> > -	i2c = kzalloc(sizeof(struct s3c24xx_i2c), GFP_KERNEL);
> > +	i2c = devm_kzalloc(&pdev->dev, sizeof(struct s3c24xx_i2c), GFP_KERNEL);

> Just in case you are resending the patch for any other reason, it might be worth
> to change to sizeof(*i2c) for consistency.

Consistency with...?

TBH I'd rather not change the coding style as well as presumably Ben
likes that the way it is.
