From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 2/3] eeprom: at24: add support to fetch eeprom device
 property "size"
Date: Tue, 22 Aug 2017 12:13:22 +0300
Message-ID: <20170822091322.ubnvxj3cdvzfs44j@valkosipuli.retiisi.org.uk>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
 <1502736119-32084-3-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:44912 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932205AbdHVJNZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 22 Aug 2017 05:13:25 -0400
Content-Disposition: inline
In-Reply-To: <1502736119-32084-3-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com

Hi Divagar,

On Tue, Aug 15, 2017 at 12:11:58AM +0530, Divagar Mohandass wrote:
> This adds support to fetch device property "size" from _DSD.
> 
> There is a CAT24C16/GT24C16S NVMEM chip part of the OV13858
> camera module and it is connected to i2c bus on Intel KBL board.
> This device will use the existing ACPI ID INT3499 and platform
> fw will expose "read-only", "pagesize" and "size" props via _DSD.

Instead of the two paragraphs, how about:

Obtain the size of the EEPROM chip from DT if the "size" property is
specified for the device.

> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 764ff5df..2199c42 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -570,6 +570,10 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>  	if (device_property_present(dev, "read-only"))
>  		chip->flags |= AT24_FLAG_READONLY;
>  
> +	err = device_property_read_u32(dev, "size", &val);
> +	if (!err)
> +		chip->byte_len = val;
> +
>  	err = device_property_read_u32(dev, "pagesize", &val);
>  	if (!err) {
>  		chip->page_size = val;
> -- 
> 1.9.1
> 

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
