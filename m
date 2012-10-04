From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: correct struct i2c_driver doc about detection
Date: Thu, 4 Oct 2012 09:58:03 +0200
Message-ID: <20121004095803.26548bc7@endymion.delvare>
References: <1349295444-18645-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349295444-18645-1-git-send-email-vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Vivien,

On Wed,  3 Oct 2012 16:17:24 -0400, Vivien Didelot wrote:
> s/address_data/address_list/ in addition to c3813d6.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
> ---
>  include/linux/i2c.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 8e25a91..8d87329 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -140,7 +140,7 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>   * The driver.owner field should be set to the module owner of this driver.
>   * The driver.name field should be set to the name of this driver.
>   *
> - * For automatic device detection, both @detect and @address_data must
> + * For automatic device detection, both @detect and @address_list must
>   * be defined. @class should also be set, otherwise only devices forced
>   * with module parameters will be created. The detect function must
>   * fill at least the name field of the i2c_board_info structure it is

Good catch! Applied, thanks.

-- 
Jean Delvare
