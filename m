From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware: Use transfer timeout from ioctl
 I2C_TIMEOUT
Date: Wed, 15 Jun 2016 16:50:44 +0300
Message-ID: <b4dff73a-5bab-cf08-3b6e-415e14774f04@linux.intel.com>
References: <1465980946-20895-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465980946-20895-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

On 06/15/2016 11:55 AM, Weifeng Voon wrote:
> This allows applications to set the transfer timeout in 10ms increments via
> ioctl I2C_TIMEOUT.
>
> changelog v2:
> * No code change, just change to a more suitable title
>
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Actually changelog doesn't belong to commit log. Otherwise

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
