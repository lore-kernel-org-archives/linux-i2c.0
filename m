From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/7] i2c: add info->archdata field
Date: Fri, 17 Oct 2008 11:21:25 +0200
Message-ID: <20081017112125.1f2c9d94@hyperion.delvare>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171253.GB5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753166AbYJQJVx@vger.kernel.org>
In-Reply-To: <20081016171253.GB5515@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, "Steven A. Falco" <sfalco@harris.com>, Grant Likely <grant.likely@secretlab.ca>, David Miller <davem@davemloft.net>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Hi Anton,

On Thu, 16 Oct 2008 21:12:53 +0400, Anton Vorontsov wrote:
> If present the info->archdata is copied into the dev->archdata.
> Some (OpenFirmware) platforms need it.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/i2c/i2c-core.c |    3 +++
>  include/linux/i2c.h    |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 42e852d..5a485c2 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -266,6 +266,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>  
>  	client->dev.platform_data = info->platform_data;
>  
> +	if (info->archdata)
> +		client->dev.archdata = *info->archdata;
> +
>  	client->flags = info->flags;
>  	client->addr = info->addr;
>  	client->irq = info->irq;
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 0611512..3e358d3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -240,6 +240,7 @@ static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
>   * @flags: to initialize i2c_client.flags
>   * @addr: stored in i2c_client.addr
>   * @platform_data: stored in i2c_client.dev.platform_data
> + * @archdata: copied into i2c_client.dev.archdata
>   * @irq: stored in i2c_client.irq
>   *
>   * I2C doesn't actually support hardware probing, although controllers and
> @@ -259,6 +260,7 @@ struct i2c_board_info {
>  	unsigned short	flags;
>  	unsigned short	addr;
>  	void		*platform_data;
> +	struct dev_archdata	*archdata;
>  	int		irq;
>  };
>  

No objection from me:

Acked-by: Jean Delvare <khali@linux-fr.org>

Let me know if I should push this patch upstream myself.

-- 
Jean Delvare
