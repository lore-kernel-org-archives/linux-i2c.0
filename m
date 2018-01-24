From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 08:27:25 +0200
Message-ID: <20180124062725.GK27654@lahna.fi.intel.com>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeAXG13 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Jan 2018 01:27:29 -0500
Content-Disposition: inline
In-Reply-To: <20180124055615.c3qwhwnj7spmcr3w@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org

On Wed, Jan 24, 2018 at 06:56:16AM +0100, Wolfram Sang wrote:
> On Wed, Jan 03, 2018 at 03:02:31PM +0100, Eric Auger wrote:
> > If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
> > and any ACPI opregion calls targeting I2C fail with no opregion found.
> > 
> > This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
> > built into the kernel or built as a module.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> I recall that we had some discussion until ending up with the current
> solution. And I finally found it again:
> 
> http://www.serverphorums.com/read.php?12,1001402
> 
> In any case, I surely want Mika's ack on any change to ACPI related
> Kconfig symbols. Adding him to CC...

So the problem is/was that what happens if you are in a middle of BIOS
AML code touching the opregion and someone unloads the opregion handler?
If you can quarantee nothing bad happens, then I'm fine with the patch :)
