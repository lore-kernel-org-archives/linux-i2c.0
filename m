From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Mon, 19 Aug 2013 09:19:01 -0300
Message-ID: <52120D35.707@freescale.com>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <20130815100809.GE2987@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130815100809.GE2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/15/2013 07:08 AM, Wolfram Sang wrote:
> On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
>> According to mx23 erratum 2727:
>>
>> "2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set.
>>
>> Description:
>>
>> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generated.
>> However, the SDA line is read at the proper timing interval. If
>> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
>> Also, the HW_I2C_VERSION register incorrectly states the version is 1.2.
>> It should be 1.3.
>>
>> Workaround:
>> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1 to
>> enable the fix for this issue."
>>
>> It has also been noticed that mx28 needs to implement this fix in order to have
>> SMBus to work properly.
>>
>> Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> What's with this one? Bogus? Needed? Still needed after PIO rework?

According to the mx23 erratum 2727 this patch is needed.

Regards,

Fabio Estevam
