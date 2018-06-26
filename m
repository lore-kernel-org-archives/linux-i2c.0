From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: i801: Fix runtime PM
Date: Tue, 26 Jun 2018 17:55:07 +0300
Message-ID: <20180626145507.GE2558@lahna.fi.intel.com>
References: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 26, 2018 at 05:39:12PM +0300, Jarkko Nikula wrote:
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
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This fixes the issue for me, thanks Jarkko!

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
