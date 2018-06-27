From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c: i801: Fix runtime PM
Date: Wed, 27 Jun 2018 22:15:50 +0200
Message-ID: <20180627221550.0fa5f2df@endymion>
References: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jarkko,

On Tue, 26 Jun 2018 17:39:12 +0300, Jarkko Nikula wrote:
> Commit 9c8088c7988 ("i2c: i801: Don't restore config registers on
> runtime PM") nullified the runtime PM suspend/resume callback pointers
> while keeping the runtime PM enabled. This causes that device stays in
> D0 power state and sysfs /sys/bus/pci/devices/.../power/runtime_status
> shows "error" when runtime PM framework attempts to autosuspend the
> device.
> 
> This is due PCI bus runtime PM which checks for driver runtime PM
> callbacks and returns with -ENOSYS if they are not set. Fix this by
> having a shared dummy runtime PM callback that returns with success.
> 
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")

I don't want to sound like I'm trying to decline all responsibility for
a regression I caused, but frankly, if just using SIMPLE_DEV_PM_OPS()
breaks runtime PM, then it's the PM model which is broken, not the
i2c-i801 driver.

I will boldly claim that the PCI bus runtime code is simply wrong in
returning -ENOSYS in the absence of runtime PM callbacks, and it should
be changed to return 0 instead. Or whoever receives that -ENOSYS should
not treat it as an error - whatever makes more sense.

Having to add dummy functions in every PCI driver that doesn't need to
do anything special for runtime PM sounds plain stupid. It should be
pretty obvious that a whole lot of drivers are going to use
SIMPLE_DEV_PM_OPS() because it exists and seems to do what they want,
and all of them will be bugged because the PCI core is doing something
silly and unexpected.

So please let's fix it at the PCI subsystem core level. Adding Bjorn
and the linux-pci list to Cc.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
