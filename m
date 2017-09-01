From: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: add eeprom "size" property
Date: Fri, 1 Sep 2017 12:02:24 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE73F8@BGSMSX107.gar.corp.intel.com>
References: <1504112740-14072-1-git-send-email-divagar.mohandass@intel.com>
 <1504112740-14072-2-git-send-email-divagar.mohandass@intel.com>
 <20170831152605.zhpi46uu6b5omaou@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18289 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdIAMCa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 1 Sep 2017 08:02:30 -0400
In-Reply-To: <20170831152605.zhpi46uu6b5omaou@rob-hp-laptop>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>

Hi Rob,

Sorry I missed it, will follow from next version.

---
^Divagar

>-----Original Message-----
>From: Rob Herring [mailto:robh@kernel.org]
>Sent: Thursday, August 31, 2017 8:56 PM
>To: Mohandass, Divagar <divagar.mohandass@intel.com>
>Cc: mark.rutland@arm.com; wsa@the-dreams.de; sakari.ailus@iki.fi;
>devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
>kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>
>Subject: Re: [PATCH v4 1/3] dt-bindings: add eeprom "size" property
>
>On Wed, Aug 30, 2017 at 10:35:38PM +0530, Divagar Mohandass wrote:
>> This adds eeprom "size" as optional property for i2c eeproms.
>> The "size" property allows explicitly specifying the size of the
>> EEPROM chip in bytes.
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
>> ---
>>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>
>Please add acks when posting new versions or state here why you didn't.
>
>Acked-by: Rob Herring <robh@kernel.org>
