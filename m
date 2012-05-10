From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Thu, 10 May 2012 16:54:53 +0530
Message-ID: <4FABA585.7090600@nvidia.com>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com> <1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335251976-31925-3-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean,
On Tuesday 24 April 2012 12:49 PM, Laxman Dewangan wrote:
> Adding support for protocol mangling I2C_M_NOSTART.
> When multiple message transfer request made through i2c
> and if any message is flagged with I2C_M_NOSTART then
> it will not send the start/repeat start/address of that
> message i.e. send the data directly.
>

Now the framework/core changes for making M_NOSTART as a separate flag 
is already part of your tree.
So do I need to re-send the patch for having that change?
1/1 is already part of Wolfram's tree and so not sure that how do I go 
i.e. from where I take the base i2c-tegra driver.
It may create the problem in integration on main if they are not sync.
Also I have some couple of changes which will be on top of this.

Thanks,
Laxman
