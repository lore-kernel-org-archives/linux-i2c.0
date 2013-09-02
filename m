From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] i2c: prepare runtime PM support for I2C client
 devices
Date: Mon, 2 Sep 2013 13:56:15 +0300
Message-ID: <20130902105615.GR7393@intel.com>
References: <1377007416-13851-1-git-send-email-mika.westerberg@linux.intel.com>
 <1377007416-13851-2-git-send-email-mika.westerberg@linux.intel.com>
 <20130828093858.GF4086@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130828093858.GF4086@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 28, 2013 at 11:38:58AM +0200, Wolfram Sang wrote:
> On Tue, Aug 20, 2013 at 05:03:35PM +0300, Mika Westerberg wrote:
> > From: Aaron Lu <aaron.lu@intel.com>
> > 
> > This patch adds runtime PM support for the I2C bus in a similar way that
> > has been done for PCI bus already. This means that the I2C bus core
> > prepares runtime PM for a client device just before a driver is about to be
> > bound to it. Devices that are not bound to any driver are not prepared for
> > runtime PM.
> > 
> > In order to take advantage of this runtime PM support, the client device
> > driver needs drop the device runtime PM reference count by calling
> > pm_runtime_put() in its ->probe() callback and possibly implement rest of
> > the runtime PM callbacks.
> > 
> > However, this does not yet make runtime PM happen for the device, it has to
> > be explicitly allowed from userspace per each I2C client device. The
> > reason for this is that things like HID over I2C might not work as smoothly
> > when runtime PM is active. So we leave it to the user to balance between
> > performance and power efficiency.
> > 
> > User can allow runtime PM for the client device by running:
> > 
> > 	# echo auto > /sys/bus/i2c/devices/<device>/power/control
> > 
> > and it can be forbidden again by:
> > 
> > 	# echo on > /sys/bus/i2c/devices/<device>/power/control
> > 
> > Status of the device can be monitored by reading files under the device
> > power directory.
> > 
> > If the driver doesn't support runtime PM (like most of the existing I2C
> > client drivers), the device in question is regarded as being runtime PM
> > active and powered on.
> > 
> > The patch adds also runtime PM support for the adapter device because it is
> > needed to be able to runtime power manage the I2C controller device. The
> > adapter device is handled along with the I2C controller device (it uses
> > pm_runtime_no_callbacks()).
> > 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> CCing ALKML. Would appreciate comments/tags from the runtime-PM users of
> the ARM world.

Any comments on this?

I can resend the whole series with ALKML included if that helps.
