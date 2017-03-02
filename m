From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RESEND PATCH v6 5/6] i2c: designware: add SLAVE mode functions
Date: Thu, 2 Mar 2017 16:33:59 +0200
Message-ID: <be10879b-a81b-9047-6c67-45916a85ef31@linux.intel.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <07463ebe12af8c88c21c24601cf54b0cd2077e07.1488383202.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <07463ebe12af8c88c21c24601cf54b0cd2077e07.1488383202.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/01/17 17:59, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
>
> All the SLAVE flow is added but it is not enabled via platform
> driver.
>
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> V5->V6
> - Enable Slave mode using a different option (kbuild reported an error)
> - Identation fixes needed
> - Changed debug prints to dev_vdbg
> - Fixed slave enumeration
>
>  drivers/i2c/busses/Kconfig                 |  14 +-
>  drivers/i2c/busses/Makefile                |   1 +
>  drivers/i2c/busses/i2c-designware-common.c |   7 +
>  drivers/i2c/busses/i2c-designware-core.h   |   3 +
>  drivers/i2c/busses/i2c-designware-slave.c  | 403 +++++++++++++++++++++++++++++
>  5 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>
...
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 6357c7c78f6d..24641635aa20 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -56,6 +56,13 @@ static char *abort_sources[] = {
>  		"trying to use disabled adapter",
>  	[ARB_LOST] =
>  		"lost arbitration",
> +	[ABRT_SLAVE_FLUSH_TXFIFO] =
> +		"read command so flush old data in the TX FIFO",
> +	[ABRT_SLAVE_ARBLOST] =
> +		"slave lost the bus while transmitting data to a remote master",
> +	[ABRT_SLAVE_RD_INTX] =
> +		"slave request for data to be transmitted and there is a 1 in "
> +		"bit 8 of IC_DATA_CMD",
>  };

I know ABRT_SLAVE_RD_INTX case is from the specification but I would 
prefer here one-line error text so it will be easier to grep from sources.

I would like it to be also be more understandable. I don't know did I 
understood it correctly but does it occur when attempting to read 
controller while transmitting or something like that?

> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index b620d76ffc8d..6c70945cccea 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -277,6 +277,7 @@ struct dw_i2c_dev {
>  	void			(*disable)(struct dw_i2c_dev *dev);
>  	void			(*disable_int)(struct dw_i2c_dev *dev);
>  	int			(*init)(struct dw_i2c_dev *dev);
> +	bool			mode;
>  };
>

As I mentioned add here comment for "mode" not in patch 4/6.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
