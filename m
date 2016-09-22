From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Thu, 22 Sep 2016 11:49:30 +0300
Message-ID: <20160922084930.GI1218@lahna.fi.intel.com>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
 <20160921054834.GC1484@katana>
 <20160921084502.GV1811@lahna.fi.intel.com>
 <20160921161435.GA1432@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45047 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbcIVIwj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 04:52:39 -0400
Content-Disposition: inline
In-Reply-To: <20160921161435.GA1432@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 21, 2016 at 06:14:38PM +0200, Wolfram Sang wrote:
> On Wed, Sep 21, 2016 at 11:45:02AM +0300, Mika Westerberg wrote:
> > On Wed, Sep 21, 2016 at 07:48:35AM +0200, Wolfram Sang wrote:
> > > On Tue, Sep 20, 2016 at 04:59:25PM +0300, Mika Westerberg wrote:
> > > > When enumerating I2C devices connected to an I2C adapter we scan the whole
> > > > namespace (as it is possible to have devices anywhere in that namespace,
> > > > not just below the I2C adapter device) and add each found device to the I2C
> > > > bus in question.
> > > > 
> > > > Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
> > > > reconfigure notifications") checking of the adapter handle to the one found
> > > > in the I2cSerialBus() resource was moved to happen after resources of the
> > > > I2C device has been parsed. This means that if the I2cSerialBus() resource
> > > > points to an adapter that does not exists in the system we still parse
> > > > those resources. This is problematic in particular because
> > > > acpi_dev_resource_interrupt() tries to configure GSI if the device also has
> > > > an Interrupt() resource. Failing to do that results errrors like this to be
> > > > printed on the console:
> > > > 
> > > >   [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
> > > > 
> > > > To fix this we pass the I2C adapter to i2c_acpi_get_info() and make sure
> > > > the handle matches the one in the I2cSerialBus() resource before doing
> > > > anything else to the device.
> > > > 
> > > > Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > Considering this for for-current. So shall we add:
> > > 
> > > Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
> > > 
> > > ?
> > 
> > Yes please :)
> 
> Huh? It doesn't apply on top of rc7 here? What did you base it on?

It is based on linux-next as it is on top of Jarkko's I2C ACPI namespace
cleanup patches. I'm wondering if I make an updated patch on top of
v4.8-rc7 does it conflict with the I2C stuff in linux-next? What's your
preference?
