From: Patrick Williams <alpawi@amazon.com>
Subject: Re: [PATCH 1/2] i2c: pxa: migrate to new i2c_slave APIs
Date: Tue, 1 Oct 2019 11:39:10 -0500
Message-ID: <20191001163910.GA2307@8c859006a84e.ant.amazon.com>
References: <20191001160001.2388-1-alpawi@amazon.com>
 <20191001160001.2388-2-alpawi@amazon.com>
 <20191001162913.GR32742@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001162913.GR32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Patrick Williams <patrick@stwcx.xyz>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, Ajay Gupta <ajayg@nvidia.com>, Stefan Roese <sr@denx.de>, Florian Fainelli <f.fainelli@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Baolin Wang <baolin.wang@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thanks for the review Andy.

On Tue, Oct 01, 2019 at 07:29:13PM +0300, Andy Shevchenko wrote:
> 
> 
> On Tue, Oct 01, 2019 at 10:59:59AM -0500, Patrick Williams wrote:
> There are quite a few people in the Cc list. I'm not sure they all are
> interested in this. I deliberately dropped few names, sorry, if I was mistaken.

Agree it was kind of a big list.  Just chose what was given to me by
get_maintainer.pl.  It seems like there isn't a direct identified
maintainer of this file.

> 
> > +		if (isr & ISR_RWM) {
> > +			u8 byte = 0;
> > +
> > +			i2c_slave_event(i2c->slave, I2C_SLAVE_READ_REQUESTED,
> > +					&byte);
> > +			writel(byte, _IDBR(i2c));
> > +		} else {
> > +			i2c_slave_event(i2c->slave, I2C_SLAVE_WRITE_REQUESTED,
> > +					NULL);
> > +		}
> 
> Hmm... Perhaps
> 
> 		u8 byte = 0;
> 
> 		i2c_slave_event(i2c->slave, I2C_SLAVE_READ_REQUESTED, &byte);
> 		if (isr & ISR_RWM)
> 			writel(byte, _IDBR(i2c));
> 

The two different paths also require READ_REQUEST vs WRITE_REQUESTED.  I
could do a ternary there but it seemed more obvious to just unroll the
logic.

-- 
- Patrick
