From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
Date: Wed, 31 Oct 2012 12:44:59 +0900
Message-ID: <CABMQnVLAOm3JEynXqPD+zL-D02i2bDJRV3JbOfBKLX7PzEGbsA@mail.gmail.com>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org> <508FF72B.5080708@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508FF72B.5080708-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, Oct 31, 2012 at 12:50 AM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> Hello.
>
> On 10/30/2012 01:39 PM, Nobuhiro Iwamatsu wrote:
>
>> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
>> This validates to use mv64xxx in this SoC.
>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 65dd599..ff53cf4 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -474,7 +474,7 @@ config I2C_MPC
>>
>>  config I2C_MV64XXX
>>       tristate "Marvell mv64xxx I2C Controller"
>> -     depends on (MV64X60 || PLAT_ORION)
>> +     depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)
>
>   Could remove useless parens, while at it...
>
OK, I will send a patch which revise about this.

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
