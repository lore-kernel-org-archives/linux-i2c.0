From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Tue, 14 Jul 2015 17:06:20 +0530
Message-ID: <55A4F434.9080407@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org> <20150714113436.GD1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150714113436.GD1517@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, robh+dt@kernel.org, robert.jarzmik@free.fr, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On Tuesday 14 July 2015 05:04 PM, Wolfram Sang wrote:
> On Tue, Jul 14, 2015 at 01:06:39PM +0530, Vaibhav Hiremath wrote:
>> This patch series fixes bugs/warnings, cleans up the code and adds
>> support for PXA910 family of devices to PXA I2C bus driver.
>>
>> There has been one attempt made sometime back in 2012 to upstream
>> some of the patches from below list, but did not get follow up later.
>> I have consolidated all the patches, cleaned them up, splited into
>> logical changes, added new patches and submitting it now.
>>
>> I tried to maintain authorship & Signoff except where I did some
>> significant changes to the code/logic.
>
> So, I applied patches 1-6 to for-next to make some progress.
>
> The others need more thought because of the bindings which shall be
> discussed replying to the patches in question.
>
> Thanks for the updated work with lots of proper references.
>

OK, Thanks and no issues.

Lets discuss more on the bindings.

Thanks,
Vaibhav
