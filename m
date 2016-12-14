From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH V5] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Wed, 14 Dec 2016 13:20:34 +0200
Message-ID: <b7a12266-3497-3ce9-ed28-211727440c29@linux.intel.com>
References: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On 12/14/2016 11:23 AM, Tin Huynh wrote:
> ACPI always sets Tx/Rx FIFO to 32. This configuration will
> cause problem if the IP core supports a FIFO size of less than 32.
> The driver should read the FIFO size from the IP and select the smaller
> one of the two.
>
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   31 ++++++++++++++++++++------
>  1 files changed, 24 insertions(+), 7 deletions(-)

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
