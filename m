From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Tue, 24 Apr 2012 10:55:57 +0200
Message-ID: <20120424105557.7ac07232@endymion.delvare>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
	<1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335251976-31925-3-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Apr 2012 12:49:36 +0530, Laxman Dewangan wrote:
> Adding support for protocol mangling I2C_M_NOSTART.
> When multiple message transfer request made through i2c
> and if any message is flagged with I2C_M_NOSTART then
> it will not send the start/repeat start/address of that
> message i.e. send the data directly.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-tegra.c |   32 +++++++++++++++++++++++++++-----
>  1 files changed, 27 insertions(+), 5 deletions(-)

What do you need this for?

-- 
Jean Delvare
