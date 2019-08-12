From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v1 2/2] i2c: iproc: Add full name of devicetree node to
 adapter name
Date: Mon, 12 Aug 2019 10:29:45 -0700
Message-ID: <76f6d006-a0af-85ba-f893-f60e60bfc20d@broadcom.com>
References: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <1565235473-28461-3-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565235473-28461-3-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 8/7/19 8:37 PM, Rayagonda Kokatanur wrote:
> From: Lori Hikichi <lori.hikichi@broadcom.com>
> 
> Add the full name of the devicetree node to the adapter name.
> Without this change, all adapters have the same name making it difficult
> to distinguish between multiple instances.
> The most obvious way to see this is to use the utility i2c_detect.
> e.g. "i2c-detect -l"
> 
> Before
> i2c-1 i2c Broadcom iProc I2C adapter I2C adapter
> i2c-0 i2c Broadcom iProc I2C adapter I2C adapter
> 
> After
> i2c-1 i2c Broadcom iProc (i2c@e0000) I2C adapter
> i2c-0 i2c Broadcom iProc (i2c@b0000) I2C adapter
> 
> Now it is easy to figure out which adapter maps to a which DT node.
> 
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>   drivers/i2c/busses/i2c-bcm-iproc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 19ef2b0..183b220 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -922,7 +922,9 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>   
>   	adap = &iproc_i2c->adapter;
>   	i2c_set_adapdata(adap, iproc_i2c);
> -	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
> +	snprintf(adap->name, sizeof(adap->name),
> +		"Broadcom iProc (%s)",
> +		of_node_full_name(iproc_i2c->device->of_node));
>   	adap->algo = &bcm_iproc_algo;
>   	adap->quirks = &bcm_iproc_i2c_quirks;
>   	adap->dev.parent = &pdev->dev;
> 

Looks good, thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
