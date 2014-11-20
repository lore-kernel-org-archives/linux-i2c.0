From: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Date: Thu, 20 Nov 2014 19:52:08 +0530
Message-ID: <546DF910.4060802@linux.vnet.ibm.com>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141116171605.4750.17472.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On 11/16/2014 10:47 PM, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.
>
> Signed-off-by: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> ---

Hi Wolfram,

Did you get the chance to look at it?
The patch addresses the comments and discussions on v1.

Thanks,
Neelesh

>   arch/powerpc/include/asm/opal.h                |   29 ++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |    1
>   arch/powerpc/platforms/powernv/opal.c          |   11 +
>   drivers/i2c/busses/Kconfig                     |   11 +
>   drivers/i2c/busses/Makefile                    |    1
>   drivers/i2c/busses/i2c-opal.c                  |  295 ++++++++++++++++++++++++
>   6 files changed, 348 insertions(+)
>   create mode 100644 drivers/i2c/busses/i2c-opal.c
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9124b0e..537807b 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
>
