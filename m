From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
Date: Tue, 07 Aug 2018 14:45:17 +0300
Message-ID: <af71656fda0f94e77a136bd50381713020660638.camel@linux.intel.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
         <20180807080539.17811-5-hdegoede@redhat.com>
         <20180807112701.5iukqa6m5atf22fw@ninjato>
         <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-08-07 at 13:33 +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-08-18 13:27, Wolfram Sang wrote:
> > Hi Hans,
> > 
> > > +I2C MULTI INSTANTIATE DRIVER

In the case below, I think it would be slightly better to mention ACPI
here, something like

ACPI I2C ...

Otherwise it sounds a bit confusing why it's in PDx86.

> > > +M:	Hans de Goede <hdegoede@redhat.com>
> > > +L:	linux-i2c@vger.kernel.org
> > 
> > Since this driver is about FW bugs, I wonder if
> > platform-driver-x86@vger.kernel.org isn't the better list here?
> 
> Ok, fixed for v4.
> 
> > > +S:	Maintained
> > > +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c
> > 
> > I2C parts of the rest looks good from a glimpse...
> 
> Thanks.
> 
> Regards,
> 
> Hans

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
