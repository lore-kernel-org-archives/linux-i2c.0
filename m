From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 2/3] i2c: designware: detect when dynamic tar update is
 possible
Date: Wed, 17 Aug 2016 11:05:34 +0300
Message-ID: <c58ce503-580b-34b7-3489-7b8829f88dca@linux.intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
 <1469743424-2480-3-git-send-email-lucas.demarchi@intel.com>
 <f4c1fb29-b315-33ee-f029-684ef9cd6264@linux.intel.com>
 <1471356468.2907.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471356468.2907.4.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "christian.ruppert@alitech.com" <christian.ruppert@alitech.com>, "Souza, Jose" <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

On 08/16/2016 05:07 PM, De Marchi, Lucas wrote:
> On Tue, 2016-08-16 at 17:00 +0300, Jarkko Nikula wrote:
>>> +	 */
>>> +	reg = dw_readl(dev, DW_IC_CON);
>>> +	dw_writel(dev, reg ^ DW_IC_CON_10BITADDR_MASTER,
>>> DW_IC_CON);
>>> +
>>> +	if ((dw_readl(dev, DW_IC_CON) &
>>> DW_IC_CON_10BITADDR_MASTER) ==
>>> +	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
>>> +		dev->dynamic_tar_update_enabled = true;
>>> +		dev_dbg(dev->dev, "Dynamic TAR update enabled");
>>> +	}
>>
>> Is this possible to move to i2c_dw_probe()? I guess the enabled
>> status
>> doesn't change runtime?
>
> It was actually useful at this place during development of this patch
> because we could check any unexpected change in behavior when resuming.
> We did catch a bug because of this and fixed.
> I'm not sure if now it makes more sense to move to probe method. I'd
> leave it where it is, but I'm open to move it there.
>
Can you do a quick re-test that case to see does it change runtime? If 
it does then this needs a comment why there is need to do this check 
each time when HW is reinitialized. Otherwise there is chance someone 
may move this code to probe time in the future.

-- 
Jarkko
