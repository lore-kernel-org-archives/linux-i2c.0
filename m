From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 0/3] enable eeprom "size" property and runtime pm
Date: Tue, 5 Sep 2017 16:48:22 +0300
Message-ID: <20170905134821.vyrita5fssc5uxxh@valkosipuli.retiisi.org.uk>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:41394 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750959AbdIENsZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Sep 2017 09:48:25 -0400
Content-Disposition: inline
In-Reply-To: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com

Hi Divagar,

On Mon, Sep 04, 2017 at 03:58:45PM +0530, Divagar Mohandass wrote:
> This series adds support for eeprom "size" property which will be read by the
> driver for eeprom size. The existing ACPI has a different default size which
> can be overridden with a DSD property value provided by the platform FW.
> 
> This series also adds support for runtime PM. The eeprom driver currently
> did not have support for runtime PM and the device was kept in D0 throughout.
> 
> [v1]
> - Add support for eeprom "size" property.
> - Add runtime PM support to the driver.
> 
> [v2]
> - Improved the patch subject.
> 
> [v3]
> - Addressed comments from Sakari Ailus.
> - Improved patch description.
> - Improved pm support patch.
> 
> [v4]
> - Improved runtime pm support.
> - Addressed comments from Sakari Ailus.
> 
> [v5]
> - Addressed comments from Sakari Ailus.
> - Improved error handling for PM support.
> 
> [v6]
> - Addressed comments from Sakari Ailus.
> 
> Divagar Mohandass (3):
>   dt-bindings: add eeprom "size" property
>   eeprom: at24: add support to fetch eeprom device property "size"
>   eeprom: at24: enable runtime pm support
> 
>  .../devicetree/bindings/eeprom/eeprom.txt          |  2 ++
>  drivers/misc/eeprom/at24.c                         | 42 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)

Thanks for the update!

For the set:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
