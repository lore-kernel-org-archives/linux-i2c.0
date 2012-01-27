From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] at24: add kernel side usage description
Date: Fri, 27 Jan 2012 14:40:18 +0100
Message-ID: <20120127144018.056ddba8@endymion.delvare>
References: <1327507871-15211-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327507871-15211-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Jan 2012 17:11:11 +0100, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> Add EEPROM usage instructions and example for kernel side.
> dm644x-evm was taken as example.
> 
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index ab1ad41..49494ad 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -438,6 +438,15 @@ static ssize_t at24_bin_write(struct file *filp, struct kobject *kobj,
>   * This lets other kernel code access the eeprom data. For example, it
>   * might hold a board's Ethernet address, or board-specific calibration
>   * data generated on the manufacturing floor.
> + *
> + * struct at24_platform_data provides special hook .setup, that can
> + * invoke at24_macc_read()/at24_macc_write() through memory_accessor:
> + * 
> + * void		(*setup)(struct memory_accessor *, void *context);
> + *
> + * setup hook (if provided) will be executed at the end of at24_probe().
> + *
> + * See arch/arm/mach-davinci/board-dm644x-evm.c for details.
>   */
>  
>  static ssize_t at24_macc_read(struct memory_accessor *macc, char *buf,

Good idea.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

I believe Wolfram will pick this as the maintainer of the at24 driver.

-- 
Jean Delvare
