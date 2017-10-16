From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: RE: [PATCH 1/1] i2c: i801: Restore the presence state of P2SB PCI
 device after reading BAR
Date: Mon, 16 Oct 2017 05:31:27 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F6F5E7A1F@SHSMSX101.ccr.corp.intel.com>
References: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
 <20171013150135.51e481f0@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42775 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdJPFbd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 16 Oct 2017 01:31:33 -0400
In-Reply-To: <20171013150135.51e481f0@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "Luck, Tony" <tony.luck@intel.com>, "Westerberg, Mika" <mika.westerberg@intel.com>, "bp@alien8.de" <bp@alien8.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

> From: Jean Delvare [mailto:jdelvare@suse.de]
... 
> Sorry, this happened while I was on vacation and I missed it.
> 
> The change looks sane, so:
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> And I approve backporting to older kernels if needed.
> 
> That being said... Looking at the code, I have to say I'm surprised that the whole
> value of configuration byte 0xe1 is used as true/false.
> I'd expect a single bit (bit 0) in this configuration file to decide if the P2SB device
> is hidden or visible. So it seems to me that we are trashing 7 bits in the process.
> These bits may be unused at the moment, but could be used in future devices,
> and then unexpected behavior will appear.
> 
> I'm still approving this patch because the same problem was present before, but
> I think this should be checked, and fixed if I'm right.
> I'll be happy to do it myself if someone at Intel points me to the Denverton
> datasheet - if it is public.

Hi Jean,
    Yes, bit[0] is to decide the visibility of P2SB and bits[1-7] are reserved. 
    The internal datasheet (I didn't find the public spec) says that hardware will not allocate the reserved bits[1-7] for any purpose in the future. And it can always write to bit[0] without to remember any other field values. 
    But I agree you that using a single bit[0] would be better :-) 

Thanks!
- Qiuxu
