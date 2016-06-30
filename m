From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v4 1/2] i2c: qup: add ACPI support
Date: Thu, 30 Jun 2016 07:35:14 -0400
Message-ID: <577503F2.90204@codeaurora.org>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <4749471.m1cxc4jj96@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58732 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcF3LfS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Jun 2016 07:35:18 -0400
In-Reply-To: <4749471.m1cxc4jj96@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Austin Christ <austinwc@codeaurora.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, rruigrok@codeaurora.org, nkaje@codeaurora.org

Hi Arnd,

On 06/08/2016 05:02 PM, Arnd Bergmann wrote:
> On Wednesday, June 8, 2016 12:19:44 PM CEST Austin Christ wrote:
>> +               ret = device_property_read_u32(qup->dev,
>> +                               "src-clock-hz", &src_clk_freq);
>> +               if (ret) {
>> +                       dev_warn(qup->dev, "using default src-clock-hz %d",
>> +                               DEFAULT_SRC_CLK);
>> +                       src_clk_freq = DEFAULT_SRC_CLK;
>> +               }
>>
> 
> Where is this property documented?

We plan on submitting documentation via dsd@acpica.org to
https://github.com/ahs3/dsd once it is operational. As I understand it
the project is brand new. It may take several months to begin accepting
submissions. In the mean time, we could potentially include
documentation in a reply to this thread, the cover of the next series, a
wiki page on codeaurora.org, a file in Documentation (perhaps to be
replaced by ACPICA style imports of the OS-neutral DSD project or a git
submodule) or potentially other means. Please let us know what you think
is sufficient.

Thanks,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
