From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V1] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Tue, 29 Nov 2016 11:04:31 +0200
Message-ID: <20161129090431.GM1459@lahna.fi.intel.com>
References: <1480390327-24562-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480390327-24562-1-git-send-email-tnhuynh@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 29, 2016 at 10:32:07AM +0700, Tin Huynh wrote:
> ACPI always sets txfifo and rxfifo to 32. This configuration will
> cause problem if the IP core supports a fifo size of 16 bytes only.
> Set the default value to 0 so the driver will get these parameters 
> from IP core.

Except when those values are not available which is the reason why we
have the default 32 for ACPI systems.

Are you saying you have DW I2C controller on ACPI system where the FIFO
is smaller than 32?
