From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/3] i2c: designware: Cleanup bus lock handling
Date: Mon, 15 Oct 2018 17:15:47 +0300
Message-ID: <47ea8d77-83eb-8f13-720c-6dd11fb70428@linux.intel.com>
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011142911.13750-4-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 10/11/2018 05:29 PM, Hans de Goede wrote:
> Now that most of the special Bay- / Cherry-Trail bus lock handling has
> been moved to the iosf_mbi code we can simplify the remaining code a bit.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/i2c/busses/i2c-designware-baytrail.c | 18 ++----------------
>   drivers/i2c/busses/i2c-designware-common.c   |  4 ++--
>   drivers/i2c/busses/i2c-designware-core.h     |  9 ++-------
>   drivers/i2c/busses/i2c-designware-platdrv.c  |  2 --
>   4 files changed, 6 insertions(+), 27 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
