From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 8/8] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Wed, 23 Sep 2015 15:56:52 +0300
Message-ID: <1443013012.8361.172.camel@linux.intel.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1442916619-140607-9-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150922143714.GA9235@ulmo.nvidia.com>
	 <1442997686.8361.161.camel@linux.intel.com>
	 <20150923124800.GA11187@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150923124800.GA11187@ulmo.nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-09-23 at 14:48 +0200, Thierry Reding wrote:
> > > > 

> On Wed, Sep 23, 2015 at 11:41:26AM +0300, Andy Shevchenko wrote:
> > On Tue, 2015-09-22 at 16:37 +0200, Thierry Reding wrote:
> > > On Tue, Sep 22, 2015 at 01:10:19PM +0300, Andy Shevchenko wrote:
> > 

> > > 
> > > >  		.of_match_table = pca9685_dt_ids,
> > > 
> > > Similarly to the above, this should use of_match_ptr(), which in 
> > > turn
> > > will require #ifdef protection for the table to avoid warnings.
> > 
> > Hmm... my patch do not touches that part. Perhaps another patch for
> > this?
> 
> Your patch does touch that part by removing the dependency on OF. 
> That
> makes it possible to build this code with !OF, which in turn would 
> make
> the OF match table unused.

Ah, you're right. Will amend this part as well.
Thanks!

> 
> Thierry

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
