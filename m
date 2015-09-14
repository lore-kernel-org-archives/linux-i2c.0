From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
Date: Mon, 14 Sep 2015 10:37:08 +0530
Message-ID: <55F655FC.8070308@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911185312.GA1516@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150911185312.GA1516@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, robert.jarzmik@free.fr, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Yi Zhang <yizhang@marvell.com>
List-Id: linux-i2c@vger.kernel.org



On Saturday 12 September 2015 12:23 AM, Wolfram Sang wrote:
> On Mon, Aug 24, 2015 at 11:29:35AM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> Enable i2c module/unit before transmission and disable when it
>> finishes.
>>
>> why?
>> It's because the i2c bus may be disturbed if the slave device,
>> typically a touch, powers on.
>
> I am not convinced, "may disturb" is too weak for me. It would need a
> way more detailed description of the problem which makes clear that
> this mechanism is the only way to go forward.
>

Hmm, Ok.
Not sure what else I can bring up here.

> Can't you use Runtime PM for that?
>

I haven't tried it though, I can give a try and check.

Thanks,
Vaibhav
