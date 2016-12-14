From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V5] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Wed, 14 Dec 2016 13:57:06 +0200
Message-ID: <20161214115706.GY1460@lahna.fi.intel.com>
References: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 04:23:58PM +0700, Tin Huynh wrote:
> ACPI always sets Tx/Rx FIFO to 32. This configuration will
> cause problem if the IP core supports a FIFO size of less than 32.
> The driver should read the FIFO size from the IP and select the smaller
> one of the two.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
