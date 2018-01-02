From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] i2c: fix ACPI_I2C_OPREGION dependency
Date: Tue, 2 Jan 2018 13:19:49 -0500
Message-ID: <cad432e6-1722-3080-0266-18629be56e83@codeaurora.org>
References: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
 <ea62b24e-a77b-f52e-46f2-ed38dfebd792@codeaurora.org>
 <48ff2e75-5ee0-5ac9-8d47-58c3c691ad6e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeABSTw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 2 Jan 2018 13:19:52 -0500
In-Reply-To: <48ff2e75-5ee0-5ac9-8d47-58c3c691ad6e@infradead.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 1/2/2018 1:10 PM, Randy Dunlap wrote:
>>>  config ACPI_I2C_OPREGION
>>>  	bool "ACPI I2C Operation region support"
>>> -	depends on I2C=y && ACPI
>>> +	depends on I2C && ACPI
>>>  	default y
>>>  	help
>>>  	  Say Y here if you want to enable ACPI I2C operation region support.
>>>
>> Anybody picking this up?
> Well.  It looks to me like the patch is reversed or the patch description
> needs some improvement.  Or I just don't understand it.

I'll let Eric improve the description. 

Issue is that if you compile I2C as a module, ACPI_I2C_OPREGION doesn't get selected.
Therefore, any ACPI opregion calls targeting I2C fail with no opregion found.

The goal is to select ACPI_I2C_OPREGION independent of the I2C module type selection.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
