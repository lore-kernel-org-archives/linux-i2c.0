From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: must wait for enable
Date: Thu, 15 Feb 2018 13:06:12 +0200
Message-ID: <debe23b7-9609-0433-a8e2-814937e2c753@linux.intel.com>
References: <1518622192-19700-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:31089 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755336AbeBOLFx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Feb 2018 06:05:53 -0500
In-Reply-To: <1518622192-19700-1-git-send-email-gardner.ben@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>, "linux-stable #4 . 13+" <stable@vger.kernel.org>

On 02/14/2018 05:29 PM, Ben Gardner wrote:
> One I2C bus on my Atom E3845 board has been broken since 4.9.
> It has two devices, both declared by ACPI and with built-in drivers.
> 
> There are two back-to-back transactions originating from the kernel, one
> targeting each device. The first transaction works, the second one locks
> up the I2C controller. The controller never recovers.
> 
> These kernel logs show up whenever an I2C transaction is attempted after
> this failure.
> i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
> i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready
> 
> Waiting for the I2C controller status to indicate that it is enabled
> before programming it fixes the issue.
> 
> I have tested this patch on 4.14 and 4.15.
> 
> Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only if necessary")
> Cc: linux-stable <stable@vger.kernel.org> #4.13+
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index ae69188..55926ef 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -209,7 +209,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>   	i2c_dw_disable_int(dev);
>   
>   	/* Enable the adapter */
> -	__i2c_dw_enable(dev, true);
> +	__i2c_dw_enable_and_wait(dev, true);
>   
I believe this conversion was missing from commit 2702ea7dbec5 and 
regression is better to fix this way than reverting. We'll provide 
similar fix for for v4.9..v4.12. Code have had changes and renaming.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
