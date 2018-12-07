From: Peter Rosin <peda@axentia.se>
Subject: Re: [2nd RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Date: Fri, 7 Dec 2018 12:17:05 +0000
Message-ID: <b70e4721-1cff-eb07-ed8e-8fc39b6e84ed@axentia.se>
References: <20181207112939.15791-1-tudor.ambarus@microchip.com>
 <20181207112939.15791-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207112939.15791-2-tudor.ambarus@microchip.com>
Content-Language: en-US
Content-ID: <3D88C2896AA66A499C41B51F6DCF224C@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-12-07 12:29, Tudor.Ambarus@microchip.com wrote:
> From: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
> 
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in the device tree, the buses __usually__ assume it's 100kHZ
> (see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
> clock-frequency, so the default clock frequency varies from bus to bus.
> 
> There are i2c clients that need to know the bus clock frequency in order to
> compute their wake token (see atecc508a i2c client).
> 
> The clock-frequency value has to be propagated to the i2c clients, otherwise,
> if they will not find the i2c bus clock frequency in the device tree, they
> will have to make their own assumption of the clock frequency.
> 
> Spare the i2c clients of making wrong assumptions of the i2c bus clock
> frequency and enable the buses to save their clock frequency in adapter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviwed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

This is not the correct spelling of the tag and probably the reason for
the lack of reaction from Wolfram. The tag has simply not showed up in
patchwork and the patch has thus been postponed. Probably...

Cheers,
Peter

> ---
>  include/linux/i2c.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..f238da204c49 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -677,6 +677,7 @@ struct i2c_adapter {
>  	struct rt_mutex bus_lock;
>  	struct rt_mutex mux_lock;
>  
> +	u32 bus_freq_hz;
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> 
