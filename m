From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: Re: [PATCH v2 1/3] i2c: piix4: Fix SMBus port selection for AMD
 Family 16h chips
Date: Fri, 15 Dec 2017 09:58:44 +1000
Message-ID: <ab3ac6e1-819b-6f91-a590-ca3aa87f8b23@opengear.com>
References: <cover.1513215039.git.andrew.cooks@opengear.com>
 <3f87f37117e6662661f16ea8fdbbdffff5d2e414.1513215039.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com ([104.47.37.74]:64648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754291AbdLNX7E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Dec 2017 18:59:04 -0500
In-Reply-To: <3f87f37117e6662661f16ea8fdbbdffff5d2e414.1513215039.git.andrew.cooks@opengear.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, linux-i2c@vger.kernel.org
Cc: platypus-sw@opengear.com, Wolfram Sang <wsa@the-dreams.de>, open list <linux-kernel@vger.kernel.org>

Hi Jean

On 14/12/17 13:11, Andrew Cooks wrote:
> HUDSON2 SMBus controller has the same port selection register as
> described and fixed in commit 0fe16195f89173652cf111d7b384941b00c5aabd
> ("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")
> 
> The SMBus port selection register is common to multiple Families and
> models, as documented in AMD's publicly available BIOS and Kernel
> Developer Guides:
> 
>  - 50742 -- Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  - 55072 -- Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  - 52740 -- Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)
> 
> The following additional public AMD BKDG documents were checked and do
> not share the same port selection register:
> 
>  - 42301 -- Family 15h Model 00h-0Fh doesn't mention any
>  - 42300 -- Family 15h Model 10h-1Fh doesn't mention any
>  - 49125 -- Family 15h Model 30h-3Fh doesn't mention any
> 
>  - 48751 -- Family 16h Model 00h-0Fh uses the previously supported
>    index register SB800_PIIX4_PORT_IDX_ALT at 0x2e

I just noticed that commit 6befa3fde65fe437f588da490c07a114393ce229 ("i2c: piix4: Support alternative port selection register") also fixed the port selection for Hudson2, and this patch is incorrect. Unfortunately the AMD naming and PCI Device IDs aren't particularly helpful here.

In both the 51192 Bolton Register Reference Guide[1] and 52740 BKDG for Family 16h Model 30h-3Fh[2], the PCI Device ID for the SMBus controller is 0x780b, but the location of the SmBus0Sel port selection bits are different.

We might be able to distinguish between them using the Revision ID in PCI register 0x08 (in addition to the PCI Device ID, of course).

  Bolton [1] is Revision 0x15
  Family 16h Model 30h (Hudson2?)[2] is Revision 0x1F
  Family 15h Model 70h [3] uses 0x4A
  Family 15h Model 60h [4] uses 0x4A

Thoughts?


Andrew


[1] http://support.amd.com/TechDocs/51192_Bolton_FCH_RRG.pdf
[2] http://support.amd.com/TechDocs/52740_16h_Models_30h-3Fh_BKDG.pdf
[3] http://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-7Fh_BKDG.pdf
[4] http://support.amd.com/TechDocs/50742_15h_Models_60h-6Fh_BKDG.pdf
