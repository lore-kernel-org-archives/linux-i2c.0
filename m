From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 v2 2/3] i2c-ocore: sifive: add support for i2c device
 on FU540-c000 SoC.
Date: Tue, 7 May 2019 17:26:26 +0200
Message-ID: <20190507152626.GD25013@lunn.ch>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
 <1557242108-13580-3-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557242108-13580-3-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, palmer@sifive.com, paul.walmsley@sifive.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 07, 2019 at 08:45:07PM +0530, Sagar Shrikant Kadam wrote:
> Update device id table for Opencores I2C master used in HiFive Unleashed
> platform having FU540-c000 chipset.
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 4e1a077..7bf7b0c 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -85,6 +85,7 @@ struct ocores_i2c {
>  
>  #define TYPE_OCORES		0
>  #define TYPE_GRLIB		1
> +#define TYPE_SIFIVE_REV0	2
>  
>  static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
>  {
> @@ -465,6 +466,10 @@ static u32 ocores_func(struct i2c_adapter *adap)
>  		.data = (void *)TYPE_OCORES,
>  	},
>  	{
> +		.compatible = "sifive,fu540-c000-i2c",
> +		.data = (void *)TYPE_SIFIVE_REV0,
> +	},

If you list "sifive,i2c0" in the binding document, it should be here
as well.

> +	{
>  		.compatible = "aeroflexgaisler,i2cmst",
>  		.data = (void *)TYPE_GRLIB,
>  	},
> -- 
> 1.9.1
> 
> 
> -- 
> The information transmitted is intended only for the person or entity to 
> which it is addressed and may contain confidential and/or privileged 
> material. If you are not the intended recipient of this message please do 
> not read, copy, use or disclose this communication and notify the sender 
> immediately. It should be noted that any review, retransmission, 
> dissemination or other use of, or taking action or reliance upon, this 
> information by persons or entities other than the intended recipient is 
> prohibited.
