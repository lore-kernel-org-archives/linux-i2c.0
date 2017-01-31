From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Issue with i2c-designware-platdrv's suspend/runtime-suspend
 handling
Date: Tue, 31 Jan 2017 11:32:44 +0200
Message-ID: <0c44fe3a-b6d7-c947-0137-be4d33e132d7@linux.intel.com>
References: <CALAqxLU7-77hEwUFNNdsvnRnrPPu+-eZfkDMHxeTT3MLMiKhfA@mail.gmail.com>
 <CALAqxLVzW6Di5GM6iXi7PUen2Dq0TZ=awXYXY74BUK02Nfwm0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:33295 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbdAaJdl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Jan 2017 04:33:41 -0500
In-Reply-To: <CALAqxLVzW6Di5GM6iXi7PUen2Dq0TZ=awXYXY74BUK02Nfwm0Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, zhangfei <zhangfei.gao@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Amit Pundir <amit.pundir@linaro.org>

On 01/31/2017 12:05 AM, John Stultz wrote:
> On Tue, Jan 24, 2017 at 2:03 PM, John Stultz <john.stultz@linaro.org> wrote:
>> Doing some further debugging, it seems the problem is that the device
>> is being runtime suspended, and then at suspend time, we're calling
>> the same logic, calling i2c_dw_plat_prepare_clk, which causes the clk
>> count warning.
>>
>> Removing the runtime pm ops:
>> -       SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>> +//     SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>>
>> seems to avoid the warning, but clearly isn't ideal. :)
>>
>> Should there be some logic keep track of the suspend state for the
>> dw_i2c_dev device so we don't try to suspend (or resume) it twice?  Or
>> is there something else I'm missing to keep this from happening?
>
> Ping? Any thoughts on how best to fix this?  I'm leaning towards
> adding a suspended state to the struct dw_i2c_dev. Any objections?
>
I wonder why device PM doesn't take care of this?

If i2c-designware is enumerated from ACPI then drivers/acpi/device_pm.c: 
acpi_subsys_suspend() resumes devices suspended at run time before 
system suspend so dw_i2c_plat_suspend() won't be called twice.

But still I think device PM should not attempt to suspend already 
suspended device?

-- 
Jarkko
