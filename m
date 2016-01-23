From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: [PATCH] i2c-piix4: Fix SB800 locking
Date: Sat, 23 Jan 2016 14:26:23 +0100
Message-ID: <56A37F7F.8000803@googlemail.com>
References: <20160122141202.09c94802@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38127 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcAWN01 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 23 Jan 2016 08:26:27 -0500
Received: by mail-wm0-f44.google.com with SMTP id b14so18934872wmb.1
        for <linux-i2c@vger.kernel.org>; Sat, 23 Jan 2016 05:26:27 -0800 (PST)
In-Reply-To: <20160122141202.09c94802@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Jean,

On 22.01.2016 14:12, Jean Delvare wrote:
> We need a single mutex for all 4 shared SMBus ports on the SB800. A
> per-port mutex doesn't protect us from concurrent access.
> 
> In theory the mutex should be per PCI device, however in practice we
> know that there's only ever a single instance of the device in a given
> system so we can use a global.
> 
> Also take the mutex during initialization, as first port may be already
> in use when second port is initialized.

Thanks for following up on this. While the code obviously looks correct
the patch unfortunately does not fix the problem described in the
original patchset (i2c_piix4 has to be loaded before jc42).

> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-piix4.c |   22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> --- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-22 13:51:27.500458587 +0100
> +++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-22 13:56:13.210960522 +0100
> @@ -137,6 +137,7 @@ static const struct dmi_system_id piix4_
>  };
>  
>  /* SB800 globals */
> +DEFINE_MUTEX(piix4_mutex_sb800);
>  static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
>  	"SDA0", "SDA2", "SDA3", "SDA4"
>  };
> @@ -148,7 +149,6 @@ struct i2c_piix4_adapdata {
>  	/* SB800 */
>  	bool sb800_main;
>  	unsigned short port;
> -	struct mutex *mutex;
>  };
>  
>  static int piix4_setup(struct pci_dev *PIIX4_dev,
> @@ -275,10 +275,12 @@ static int piix4_setup_sb800(struct pci_
>  	else
>  		smb_en = (aux) ? 0x28 : 0x2c;
>  
> +	mutex_lock(&piix4_mutex_sb800);
>  	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
>  	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
>  	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
> +	mutex_unlock(&piix4_mutex_sb800);
>  
>  	if (!smb_en) {
>  		smb_en_status = smba_en_lo & 0x10;
> @@ -559,7 +561,7 @@ static s32 piix4_access_sb800(struct i2c
>  	u8 port;
>  	int retval;
>  
> -	mutex_lock(adapdata->mutex);
> +	mutex_lock(&piix4_mutex_sb800);
>  
>  	outb_p(SB800_PIIX4_PORT_IDX, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
> @@ -574,7 +576,7 @@ static s32 piix4_access_sb800(struct i2c
>  
>  	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
>  
> -	mutex_unlock(adapdata->mutex);
> +	mutex_unlock(&piix4_mutex_sb800);
>  
>  	return retval;
>  }
> @@ -673,17 +675,10 @@ static int piix4_add_adapter(struct pci_
>  
>  static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
>  {
> -	struct mutex *mutex;
>  	struct i2c_piix4_adapdata *adapdata;
>  	int port;
>  	int retval;
>  
> -	mutex = kzalloc(sizeof(*mutex), GFP_KERNEL);
> -	if (mutex == NULL)
> -		return -ENOMEM;
> -
> -	mutex_init(mutex);
> -
>  	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
>  		retval = piix4_add_adapter(dev, smba,
>  					   piix4_main_port_names_sb800[port],
> @@ -696,7 +691,6 @@ static int piix4_add_adapters_sb800(stru
>  		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
>  		adapdata->sb800_main = true;
>  		adapdata->port = port;
> -		adapdata->mutex = mutex;
>  	}
>  
>  	return retval;
> @@ -714,8 +708,6 @@ error:
>  		}
>  	}
>  
> -	kfree(mutex);
> -
>  	return retval;
>  }
>  
> @@ -798,10 +790,8 @@ static void piix4_adap_remove(struct i2c
>  		i2c_del_adapter(adap);
>  		if (adapdata->port == 0) {
>  			release_region(adapdata->smba, SMBIOSIZE);
> -			if (adapdata->sb800_main) {
> -				kfree(adapdata->mutex);
> +			if (adapdata->sb800_main)
>  				release_region(SB800_PIIX4_SMB_IDX, 2);
> -			}
>  		}
>  		kfree(adapdata);
>  		kfree(adap);
> 
> 
