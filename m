From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
Date: Wed, 31 Oct 2012 12:38:09 +0900
Message-ID: <CABMQnV+=+Crza9kjFk8jB5-1OXXhfFamLFd-3aGz=66g-Yh9sQ@mail.gmail.com>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org> <20121030114428.45752bd0@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121030114428.45752bd0@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Oct 30, 2012 at 7:44 PM, Thomas Petazzoni
<thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Dear Nobuhiro Iwamatsu,
>
> On Tue, 30 Oct 2012 19:39:41 +0900, Nobuhiro Iwamatsu wrote:
>> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
>> This validates to use mv64xxx in this SoC.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
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
>>       help
>>         If you say yes to this option, support will be included for the
>>         built-in I2C interface on the Marvell 64xxx line of host bridges.
>
> This is not needed: ARCH_MVEBU already selects PLAT_ORION.
>

Oh, I see. Thanks!

Nobuhiro
-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
