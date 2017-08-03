From: Peter Rosin <peda@axentia.se>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: i2c: Add Spreadtrum I2C
 controller documentation
Date: Thu, 3 Aug 2017 10:26:52 +0200
Message-ID: <b67d5908-dbac-4dd4-77f5-68d59f71b7fd@axentia.se>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <20170724065146.GA22330@spreadtrum.com>
 <CAMz4kuLcGDxcNwymHDNTEf6Zs3ci11Q=1idsXcD=DJLe1rz0PQ@mail.gmail.com>
 <CAMz4kuKhJBoQjrzdy0mO+2WUUw+Hnw9dSWv4VEdR1uPBvHuKYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10108.outbound.protection.outlook.com ([40.107.1.108]:2688
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751043AbdHCI1B (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Aug 2017 04:27:01 -0400
In-Reply-To: <CAMz4kuKhJBoQjrzdy0mO+2WUUw+Hnw9dSWv4VEdR1uPBvHuKYQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, wsa@the-dreams.de, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, wsa+renesas@sang-engineering.com

On 2017-08-03 09:29, Baolin Wang wrote:
> Hi Wolfram,
> 
> On 27 July 2017 at 17:29, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Hi Wolfram,
>>
>> On 24 July 2017 at 14:51, Baolin Wang <baolin.wang@spreadtrum.com> wrote:
>>> Hi Wolfram,
>>>
>>> On 五,  7月 14, 2017 at 05:01:10下午 +0800, Baolin Wang wrote:
>>>> This patch adds the binding documentation for Spreadtrum I2C
>>>> controller device.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>> Changes since v3:
>>>>  - Add Ack from RobH.
>>>>
>>>> Changes since v2:
>>>>  - Change compatible strings to be SoC specific.
>>>>
>>>> Changes since v1:
>>>>  - No updates.
>>>> ---
>>>
>>> Could you apply this patchset if there are no other comments?
>>> It is a long time since the v4 was send out. Thanks.
>>
>> Ping?
> 
> Since this patchset has waited for a long time, could you pick up this
> patchset into your branch? Thanks.

Please calm down. You first sent v4 4 weeks ago in the beginning of the
merge window when everybody are supposedly looking at the integration of
the work from the previous cycle. You have managed to send remainders
four times in those few weeks.

Four weeks is not a "long time", and it's not like you didn't get any
feedback. Part of that feedback was that there was room for improvement.
Have you looked into that? Or have you been busy sending pings? I'm sure
Wolfram will pick the series in time for the next merge window if he's
happy with it, there was that thing about room for improvement...

Cheers,
Peter
