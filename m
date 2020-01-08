From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 07/12] i2c: xiic: convert to use i2c_new_client_device()
Date: Wed, 8 Jan 2020 12:39:03 +0100
Message-ID: <b6feec89-3b3c-e0b4-afb7-5af5c4380d31@xilinx.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
 <20200107174748.9616-8-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20200107174748.9616-8-wsa+renesas@sang-engineering.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc: "git@Xilinx.com" <git@Xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 07. 01. 20 18:47, Wolfram Sang wrote:
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only.
> 
>  drivers/i2c/busses/i2c-xiic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index d8d49f1814c7..61e081b186cc 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -806,7 +806,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	if (pdata) {
>  		/* add in known devices to the bus */
>  		for (i = 0; i < pdata->num_devices; i++)
> -			i2c_new_device(&i2c->adap, pdata->devices + i);
> +			i2c_new_client_device(&i2c->adap, pdata->devices + i);
>  	}
>  
>  	return 0;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Shubhrajyoti: Can you please retest?

Thanks,
Michal
