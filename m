From: Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH 1/2] i2c: add bus_freq_hz in i2c_adapter
Date: Wed, 18 Apr 2018 10:59:39 +0300
Message-ID: <a4510530-4bb4-cd4c-cb9a-108a23b27618@microchip.com>
References: <20180326111927.16040-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180326111927.16040-1-tudor.ambarus@microchip.com>
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
To: wsa@the-dreams.de, ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

ping

On 03/26/2018 02:19 PM, Tudor Ambarus wrote:
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in device tree, the buses usually asume that it is 100kHZ.
> There are i2c clients that need to know the i2c bus frequency in order to
> compute their wake token. Spare the clients of making (wrong) assumptions
> and save the bus frequency in the i2c_adapter structure.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   include/linux/i2c.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 44ad14e..7a1f26e 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -671,6 +671,7 @@ struct i2c_adapter {
>   	struct rt_mutex bus_lock;
>   	struct rt_mutex mux_lock;
>   
> +	u32 bus_freq_hz;
>   	int timeout;			/* in jiffies */
>   	int retries;
>   	struct device dev;		/* the adapter device */
> 
