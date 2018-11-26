From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count
 I2cSerialBus() resources
Date: Mon, 26 Nov 2018 16:32:45 +0200
Message-ID: <20181126143245.GK10650@smile.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
 <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 21, 2018 at 01:03:35PM +0100, Hans de Goede wrote:
> On 20-11-18 16:59, Andy Shevchenko wrote:

> > -	multi->num_clients = i;
> > +	multi->num_clients = ret;
> >   	for (i = 0; i < multi->num_clients; i++) {
> >   		memset(&board_info, 0, sizeof(board_info));
> 
> Now you end up indexing inst_data with i without checking that inst_data
> holds enough data. Not using all of inst_data in case there are less
> I2cSerialBus resources then inst_data entries is fine. But you need to
> deal with the case when there are more I2cSerialBus resources then inst_data
> entries, either by erroring out or ignoring the extra I2cSerialBus resources.

I think returning an error here is to be on safer side.

> Also it might be better to make the i2c_multi_inst_count_resources() function
> a generic helper under drivers/acpi, so that it can be used in other places,
> see my comments to the BOSC0200 patch.

I would rather to avoid touching BOSC0200 right now and keep that function
inside i2c-multi-instantiate.


-- 
With Best Regards,
Andy Shevchenko
