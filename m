From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] hwmon: Add support for JEDEC JC 42.4 compliant
 temperature sensors
Date: Sun, 11 Jul 2010 18:21:38 +0200
Message-ID: <20100711182138.132815e4@hyperion.delvare>
References: <1278859984-22593-1-git-send-email-guenter.roeck@ericsson.com>
	<1278862266.1501.59.camel@Joe-Laptop.home>
	<20100711161658.GA23927@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100711161658.GA23927@ericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Paul Goyette <paul@whooppee.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 Jul 2010 09:16:58 -0700, Guenter Roeck wrote:
> On Sun, Jul 11, 2010 at 11:31:06AM -0400, Joe Perches wrote:
> > On Sun, 2010-07-11 at 07:53 -0700, Guenter Roeck wrote:
> > > +	for (i = 0; i < ARRAY_SIZE(jc42_chips); i++) {
> > > +		if (manid == jc42_chips[i].manid
> > > +		    && (devid & jc42_chips[i].devid_mask) ==
> > > +					    jc42_chips[i].devid) {
> > > +			strlcpy(info->type, "jc42", I2C_NAME_SIZE);
> > > +			return 0;
> > > +		}
> > > +	}
> > 
> > Decidedly trivial:
> > 
> > Kernel style seems to prefer having logical tests at
> > end of line rather than start of line.
>
> Ok. Would be nice to have checkpatch.pl complain about it, though,
> if it is a to-be-enforced rule.

Please, not again. This has been discussed before, with the conclusion
that nobody really cares and we don't want to add pointless warnings to
checkpatch.pl, which in the end will just dissuade people from running
the script and/or contributing to the kernel at all.

-- 
Jean Delvare
