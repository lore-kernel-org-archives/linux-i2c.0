From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: vt8500: Add support for I2C bus on Wondermedia
 SoCs
Date: Sun, 16 Jun 2013 09:58:53 +1200
Message-ID: <51BCE39D.4030505@prisktech.co.nz>
References: <1371246736-5460-1-git-send-email-linux@prisktech.co.nz> <20130615111817.GA2938@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130615111817.GA2938@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15/06/13 23:18, Wolfram Sang wrote:
> On Sat, Jun 15, 2013 at 09:52:16AM +1200, Tony Prisk wrote:
>> This patch adds support for the I2C bus controllers found on Wondermedia
>> 8xxx-series SoCs. Only master-mode is supported.
>>
>> Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
>> ---
> ...
>
>> +/* REG_TR */
>> +#define SCL_TIMEOUT(x)		(((x) & 0xFF) << 16)
> I assume this should be << 8 since all regs are 16 bit wide.
>
> Fixed it locally and ready to apply. Please confirm or send a proper
> fix. Rest looks fine.
>
> Thanks for the submission!
>
It should be << 8. Please apply your locally corrected version.

Regards
Tony Prisk
