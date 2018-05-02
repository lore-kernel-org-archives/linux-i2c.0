From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is called
Date: Wed, 2 May 2018 11:27:14 +0800
Message-ID: <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427121417.auv4ppryegkprv32@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 27 April 2018 at 20:14, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Apr 09, 2018 at 02:40:54PM +0800, Baolin Wang wrote:
>> Add one flag to indicate if the i2c controller has been in suspend state,
>> which can prevent i2c accesses after i2c controller is suspended following
>> system suspend.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Applied to for-current, thanks!
>
> We should maybe handle this in the core somewhen, though. Or?

Thanks. Yes, It will more helpful if we can handle this in the i2c core.

-- 
Baolin.wang
Best Regards
