From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH v7 1/4] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
Date: Mon, 30 Jul 2018 11:15:52 -0600
Message-ID: <d98a059f-e76e-0ae8-e02c-4a980ab925a8@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
 <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
 <20180729103208.uyxp2feonvznmzsp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180729103208.uyxp2feonvznmzsp@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org



On 7/29/2018 4:32 AM, Wolfram Sang wrote:
> On Tue, Jun 12, 2018 at 11:09:05AM -0600, Karthikeyan Ramasubramanian wrote:
>> This bus driver supports the GENI based i2c hardware controller in the
>> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
>> module supporting a wide range of serial interfaces including I2C. The
>> driver supports FIFO mode and DMA mode of transfer and switches modes
>> dynamically depending on the size of the transfer.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Looks good except one minor thing:
> 
>> +	pm_runtime_set_suspended(gi2c->se.dev);
>> +	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>> +	pm_runtime_use_autosuspend(gi2c->se.dev);
>> +	pm_runtime_enable(gi2c->se.dev);
>> +	i2c_add_adapter(&gi2c->adap);
>> +
>> +	return 0;
> 
> i2c_add_adapter can fail. So, I'd guess you want to check the return
> value and move it above the pm_runtime calls?
> 
Sure, I will update and upload a new patchset.

Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
