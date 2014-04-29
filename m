From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Patch V2 7/9] I2C/ACPI: Add i2c ACPI operation region support
Date: Tue, 29 Apr 2014 11:02:46 +0300
Message-ID: <20140429080246.GE1684@lahna.fi.intel.com>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-8-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398695268-28645-8-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 28, 2014 at 10:27:46PM +0800, Lan Tianyu wrote:
> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) operation region.
> It allows ACPI aml code able to access such kind of devices to implement
> some ACPI standard method.

Looks good to me now,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
