From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is called
Date: Tue, 10 Apr 2018 16:08:10 +0800
Message-ID: <CAMz4kuJ7SHYMvs9ST+u27dZg3mXCc0QW3sv+=HE4ogJXiC+8gw@mail.gmail.com>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <557074eb-e988-8ff5-bec0-c85bb9dcb8ec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <557074eb-e988-8ff5-bec0-c85bb9dcb8ec@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Grygorii,

On 10 April 2018 at 04:56, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>
>
> On 04/09/2018 01:40 AM, Baolin Wang wrote:
>> Add one flag to indicate if the i2c controller has been in suspend state,
>> which can prevent i2c accesses after i2c controller is suspended following
>> system suspend.
>
> This usually indicates some bigger problem - there should be no i2c access to
>  the I2C driver once it's suspended. But if happens -
> it means suspend dependencies between drivers are broken or there some
> scheduling primitives are not disabled properly.

Correct. But on Spreadtrum platform there are some I2C slave devices
(like some sensors), they do not care the system suspend, and we can
not control them. So we can add this flag to make sure I2C driver can
be accessed safely no matter considering other slaves's dependency
like other drivers did (i2c-tegra.c, i2c-brcmstb.c and i2c-zx2967.c).
Thanks for your comments.

-- 
Baolin.wang
Best Regards
