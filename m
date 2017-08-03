From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: i2c: Add Spreadtrum I2C
 controller documentation
Date: Thu, 3 Aug 2017 16:45:47 +0800
Message-ID: <CAMz4ku+aPYP8j+Y6cu0azmD2TFGZ428rCaPof15kdmEKRVp6EA@mail.gmail.com>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <20170724065146.GA22330@spreadtrum.com> <CAMz4kuLcGDxcNwymHDNTEf6Zs3ci11Q=1idsXcD=DJLe1rz0PQ@mail.gmail.com>
 <CAMz4kuKhJBoQjrzdy0mO+2WUUw+Hnw9dSWv4VEdR1uPBvHuKYQ@mail.gmail.com> <b67d5908-dbac-4dd4-77f5-68d59f71b7fd@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34820 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdHCIpt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Aug 2017 04:45:49 -0400
Received: by mail-oi0-f51.google.com with SMTP id e124so6706926oig.2
        for <linux-i2c@vger.kernel.org>; Thu, 03 Aug 2017 01:45:48 -0700 (PDT)
In-Reply-To: <b67d5908-dbac-4dd4-77f5-68d59f71b7fd@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: wsa@the-dreams.de, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, wsa+renesas@sang-engineering.com

On 3 August 2017 at 16:26, Peter Rosin <peda@axentia.se> wrote:
> On 2017-08-03 09:29, Baolin Wang wrote:
>> Hi Wolfram,
>>
>> On 27 July 2017 at 17:29, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> Hi Wolfram,
>>>
>>> On 24 July 2017 at 14:51, Baolin Wang <baolin.wang@spreadtrum.com> wrot=
e:
>>>> Hi Wolfram,
>>>>
>>>> On =E4=BA=94,  7=E6=9C=88 14, 2017 at 05:01:10=E4=B8=8B=E5=8D=88 +0800=
, Baolin Wang wrote:
>>>>> This patch adds the binding documentation for Spreadtrum I2C
>>>>> controller device.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>> ---
>>>>> Changes since v3:
>>>>>  - Add Ack from RobH.
>>>>>
>>>>> Changes since v2:
>>>>>  - Change compatible strings to be SoC specific.
>>>>>
>>>>> Changes since v1:
>>>>>  - No updates.
>>>>> ---
>>>>
>>>> Could you apply this patchset if there are no other comments?
>>>> It is a long time since the v4 was send out. Thanks.
>>>
>>> Ping?
>>
>> Since this patchset has waited for a long time, could you pick up this
>> patchset into your branch? Thanks.
>
> Please calm down. You first sent v4 4 weeks ago in the beginning of the
> merge window when everybody are supposedly looking at the integration of
> the work from the previous cycle. You have managed to send remainders
> four times in those few weeks.
>
> Four weeks is not a "long time", and it's not like you didn't get any
> feedback. Part of that feedback was that there was room for improvement.
> Have you looked into that? Or have you been busy sending pings? I'm sure
> Wolfram will pick the series in time for the next merge window if he's
> happy with it, there was that thing about room for improvement...

Sorry for noise. I just afraid Wolfram missed this patchset since I
did not get any comments from V4.

Yes, I've looked at  how to improve, one thing is we can change
readb/writeb to readsb/writesb. I will submit one patch to fix this
after Andy's patches which fixing the readsb/writesb issue on x86
platform were merged. Anyway I will be keep patient and wait for
comments. Thanks.

--=20
Baolin.wang
Best Regards
