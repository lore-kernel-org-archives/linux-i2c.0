From: Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] i2c-i801: use MEM resource instead of IO resource
Date: Tue, 12 Apr 2016 09:02:42 +0200
Message-ID: <1460444562.5044.3.camel@chaos.suse>
References: <4b887e81aae134c2cfea3e8bb0443c7d@cestona.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:55100 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbcDLHDH (ORCPT
	<rfc822;groupwise-linux-i2c@vger.kernel.org:0:0>);
	Tue, 12 Apr 2016 03:03:07 -0400
In-Reply-To: <4b887e81aae134c2cfea3e8bb0443c7d@cestona.ro>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thilo Cestonaro <thilo@cestona.ro>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Thilo,

On lun., 2016-04-11 at 11:24 +0200, Thilo Cestonaro wrote:
> > Whenever I load the i2c-i801 smbus controller module I get a resource
> conflict with the ACPI:
> > -----------------------
> > ACPI Warning: SystemIO range 0x000000000000F040-0x000000000000F05F
> > conflicts with OpRegion 0x000000000000F040-0x000000000000F04F
> > (\_SB_.PCI0.SBUS.SMBI) (20150619/utaddress-254)
> > -----------------------
> > 
> 
> As the resource conflict is about the IO resource, I overworked the 
> i2c-i801 module to use the MEM resource which is altough available.
> This is IMHO the better alternative to using the 
> "acpi_enforce_resources=lax" boot parameter.
> 
> The patched module is working on my machine.

To be honest, I didn't know the 82801 SMBus controller supported memory
access. Does it actually work since the first supported controller
(82801AA)?

But anyway, I can't see how using it solves any problem. I guess you
access the very same registers, just using a different method. If the
BIOS is actually using the SMBus controller, you have exactly the same
conflict as before, the only difference is that it is no longer
reported. This would be a regression, not an improvement.

-- 
Jean Delvare
SUSE L3 Support
