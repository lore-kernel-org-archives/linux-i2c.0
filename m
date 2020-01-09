From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/12] i2c: cht-wc: convert to use i2c_new_client_device()
Date: Fri, 10 Jan 2020 00:05:11 +0100
Message-ID: <6e267f65-5884-c0d1-fecc-9d21ce7336a3@redhat.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
 <20200107174748.9616-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07-01-2020 18:47, Wolfram Sang wrote:
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com> > ---
> Build tested only.

I've given this a quick test spin on hw which uses this drivers,
I've not noticed any regressions:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Also the changes look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>   drivers/i2c/busses/i2c-cht-wc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index b8fde61bb5d8..35e55feda763 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -388,9 +388,9 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>   	 */
>   	if (acpi_dev_present("INT33FE", NULL, -1)) {
>   		board_info.irq = adap->client_irq;
> -		adap->client = i2c_new_device(&adap->adapter, &board_info);
> -		if (!adap->client) {
> -			ret = -ENOMEM;
> +		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
> +		if (IS_ERR(adap->client)) {
> +			ret = PTR_ERR(adap->client);
>   			goto del_adapter;
>   		}
>   	}
> 
