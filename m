From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Kernel Oops while loading I2C SSDT overlay with Designware I2C
 adapter
Date: Fri, 18 Nov 2016 11:38:40 +0200
Message-ID: <20161118093840.GX1446@lahna.fi.intel.com>
References: <2A172409E576EA4B8BB1D4D44FAD19390FFAF0A7@ORD2MBX05D.mex05.mlsrvr.com>
 <6d74862a-8920-f09e-6aac-d9a24614a3a3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:38275 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbcKRJip (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 04:38:45 -0500
Content-Disposition: inline
In-Reply-To: <6d74862a-8920-f09e-6aac-d9a24614a3a3@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: David Scully <dscully@sbimagingsystems.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Fri, Nov 18, 2016 at 11:20:36AM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 16.11.2016 00:01, David Scully wrote:
> > I have written an overlay based on a mix of the DSDT for Lenovo 100s and the example in the ssdt-overlay documentation which binds the audio codec to an i2c interface using  the Synopsys Designware I2C adapter. I have attempted to load the driver via the EFI method as well as the configfs method in the documentation, but both cause an immediate kernel oops. The overlay does not cause an oops if I target bus not controlled by the DesignWare adapter.
> > 
> ...
> > SSDT Overlay: https://gist.github.com/anonymous/eddfbb85aebcda2d547ee61873fa7117
> 
> I didn't point anything obviously wrong in your SSDT but I Cc'ed also Mika
> if he notices something.

It should not have _ADR field but that is a separate thing.

> I tested the configfs method with ADXL345 on Intel Joule board which is also
> using Designware I2C adapter and on it I was able dynamically add the chip.
> I tried both v4.9.0-rc5 and v4.8.3.
> 
> > If I'm interpreting the disassembly correctly, I believe that the problem is that the aic31xx_i2c_probe's i2c_client argument is null for the i2c_adapter pointer.
> > 
> One way to debug this is to build tlv320aic31xx into the kernel with
> CONFIG_DEBUG_INFO=y and use "addr2line -e vmlinux [address]" to see the
> source line where it oopsed. I often also add debug prints around to see
> pointer values etc.
> 

If I2C device is enumerated by ACPI the i2c_device_id pointer passed to
probe function is NULL. You need to call acpi_match_device() and friends
to find out the matching entry.

BTW, as an alternative you can stick the SSDT with initrd like we do
here:

https://github.com/westeri/meta-acpi

It includes ASL samples for Joule and the machinery to generate initrd
automatically.
