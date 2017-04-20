From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Thu, 20 Apr 2017 19:27:28 +0200
Message-ID: <20170420172728.GA4311@hc>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
 <20170420091632.GA8383@hc>
 <20170420155529.riir2yqhddj4y7lj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:40208
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941126AbdDTR1o (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 13:27:44 -0400
Content-Disposition: inline
In-Reply-To: <20170420155529.riir2yqhddj4y7lj@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-i2c@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

On Thu, Apr 20, 2017 at 05:55:29PM +0200, Wolfram Sang wrote:
> Hi Jan,
> 
> > We do want auto-detection, so either this text is wrong or setting
> > I2C_CLASS_HWMON in our i2c adapter is correct. Am I missing
> > something?
> 
> I was assuming the pci-driver could ACPI for device instantiation, and
> the platdrv could use DT. Then, the adapter class usage raised my
> eyebrow.
> 
> I just saw that the pci-driver does not have ACPI support, yet. So, the
> class could be used. Not sure about the platdrv case? But even then, the
> adapter will probe EVERY hwmon device as soon as its i2c client driver
> loads. Do you really want that? This may cost boot time, has unneeded
> traffic on the bus, etc.

What is missing in the pci-driver for ACPI support? We already use ACPI
to detect the sclk setting.

The automatic probing is requested by distributions. As we have to support
both ACPI and DT there I thought of letting ipmi-ssif use the smbios/dmi
information that is already there and usable regardless of ACPI / DT.

For servers I don't think the probing overhead is an issue, the firmware
only exposes the BMC device there. On the "embedded" systems I've not
seen a BMC yet and anyone attempting do minimize boot time can disable
the automatic probing.

So, if you're ok with this I'll re-phrase the commit message and
re-submit the patch.

Gruß,
Jan

> Regards,
> 
>    Wolfram
> 
