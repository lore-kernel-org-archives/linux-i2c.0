From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 10:44:12 +0200
Message-ID: <20141016084412.GB22265@kroah.com>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner-csrFAY9JiS4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Werner <andreas.werner-csrFAY9JiS4@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes.thumshirn-csrFAY9JiS4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2014 at 10:15:08AM +0200, Andreas Werner wrote:
> +struct eeprom_data {
> +	uint8_t eeprod_id;

Please use the "real" kernel types, "u8" here, and "u32" in other places
you use uint32_t (those are userspace types, not kernel types, sorry.)

> +static DEVICE_ATTR(eeprod_id, S_IRUGO, show_eeprod_id, NULL);
> +static DEVICE_ATTR(revision, S_IRUGO, show_revision, NULL);
> +static DEVICE_ATTR(serial, S_IRUGO, show_serialnr, NULL);
> +static DEVICE_ATTR(hw_name, S_IRUGO, show_hw_name, NULL);
> +static DEVICE_ATTR(prod_date, S_IRUGO, show_prod_date, NULL);
> +static DEVICE_ATTR(rep_date, S_IRUGO, show_rep_date, NULL);

DEVICE_ATTR_RO() please.
