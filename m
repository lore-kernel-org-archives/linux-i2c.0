From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] i2c: core: Protect acpi_match_device() against NULL
Date: Tue, 11 Jul 2017 13:14:14 +0300
Message-ID: <1499768054.22624.338.camel@linux.intel.com>
References: <20170709131618.12121-1-andriy.shevchenko@linux.intel.com>
         <1499606299.22624.315.camel@linux.intel.com>
         <20170710182151.xes5biaaj7jwkhzz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170710182151.xes5biaaj7jwkhzz@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-07-10 at 20:21 +0200, Wolfram Sang wrote:
> On Sun, Jul 09, 2017 at 04:18:19PM +0300, Andy Shevchenko wrote:
> > On Sun, 2017-07-09 at 16:16 +0300, Andy Shevchenko wrote:
> > > The commit 09b3b246acba
> > > 	("i2c: core: Allow empty id_table in ACPI case as well")
> > > brought an additional check for ACPI match table entry, though
> > > missed
> > > NULL check for table itself.
> > > 
> > > Do it here by introducing a helper i2c_acpi_match_device().
> > > 
> > > Note, we rename some static function in i2c-core-acpi.c to
> > > distinguish
> > > with public API.
> > > 
> > 
> > Wolfram, feel free to squash it into the original commit if it looks
> > better. 
> 
> I didn't want to send Linus a branch which too many last minute fixes.
> That's why I dropped the original patch and would like to ask you to
> resend a combined patch after rc1. If it is a bugfix, we will have no
> problems getting it into v4.13 but it seems a bit more testing is
> needed.

Okay, let's do this way.

I may also try to convert existing users (some coccinelle script I
suppose).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
