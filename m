From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Kernel Oops while loading I2C SSDT overlay with Designware I2C
 adapter
Date: Fri, 18 Nov 2016 11:20:36 +0200
Message-ID: <6d74862a-8920-f09e-6aac-d9a24614a3a3@linux.intel.com>
References: <2A172409E576EA4B8BB1D4D44FAD19390FFAF0A7@ORD2MBX05D.mex05.mlsrvr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:63565 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbcKRJUj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 04:20:39 -0500
In-Reply-To: <2A172409E576EA4B8BB1D4D44FAD19390FFAF0A7@ORD2MBX05D.mex05.mlsrvr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Scully <dscully@sbimagingsystems.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 16.11.2016 00:01, David Scully wrote:
> I have written an overlay based on a mix of the DSDT for Lenovo 100s and the example in the ssdt-overlay documentation which binds the audio codec to an i2c interface using  the Synopsys Designware I2C adapter. I have attempted to load the driver via the EFI method as well as the configfs method in the documentation, but both cause an immediate kernel oops. The overlay does not cause an oops if I target bus not controlled by the DesignWare adapter.
>
...
> SSDT Overlay: https://gist.github.com/anonymous/eddfbb85aebcda2d547ee61873fa7117

I didn't point anything obviously wrong in your SSDT but I Cc'ed also 
Mika if he notices something.

I tested the configfs method with ADXL345 on Intel Joule board which is 
also using Designware I2C adapter and on it I was able dynamically add 
the chip. I tried both v4.9.0-rc5 and v4.8.3.

> If I'm interpreting the disassembly correctly, I believe that the problem is that the aic31xx_i2c_probe's i2c_client argument is null for the i2c_adapter pointer.
>
One way to debug this is to build tlv320aic31xx into the kernel with 
CONFIG_DEBUG_INFO=y and use "addr2line -e vmlinux [address]" to see the 
source line where it oopsed. I often also add debug prints around to see 
pointer values etc.

-- 
Jarkko
