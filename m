From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Fri, 21 Apr 2017 16:31:46 +0200
Message-ID: <20170421143146.GA7544@hc>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
 <20170420091632.GA8383@hc>
 <20170420155529.riir2yqhddj4y7lj@ninjato>
 <20170420172728.GA4311@hc>
 <20170421062940.GA1434@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:8000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1041035AbdDUOcA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 21 Apr 2017 10:32:00 -0400
Content-Disposition: inline
In-Reply-To: <20170421062940.GA1434@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-i2c@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

On Fri, Apr 21, 2017 at 08:29:40AM +0200, Wolfram Sang wrote:
> Hi Jan,
> 
> > What is missing in the pci-driver for ACPI support? We already use ACPI
> > to detect the sclk setting.
> 
> I noticed this in the driver:
> 
> 134 static int thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
> 135                                    struct device_node *node)
> 136 {
> 137         /* TODO: ACPI support */
> 138         if (!acpi_disabled)
> 139                 return -EOPNOTSUPP;
> 140 
> 141         return thunder_i2c_smbus_setup_of(i2c, node);
> 142 }
> 
> And from a glimpse, I assumed this is the place to detect and
> instantiate client devices.

I see. This function is only setting up the optional smbus alert irq
stuff.

> > So, if you're ok with this I'll re-phrase the commit message and
> > re-submit the patch.
> 
> I'm OK. It is basically your call. I just wanted to make sure you know
> what it means adding the class to a master driver.

Understood. I think we should look at fully describing the BMC in ACPI
and DT, if that is possible we could get rid of the additional probing.

As we are not there yet I'll post the patch adding the class.

thanks,
Jan

> Regards,
> 
>    Wolfram
> 
