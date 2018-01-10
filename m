From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: Re: [RESEND, 4/4] i2c: mpc: always determine I2C clock prescaler at
 runtime
Date: Wed, 10 Jan 2018 18:36:00 +0700
Message-ID: <a218a553-4d6b-be21-389e-037fd7838277@kb.kras.ru>
References: <20171207102003.23496-5-asolokha@kb.kras.ru>
 <20171230181446.bxongiaogcqjrbos@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171230181446.bxongiaogcqjrbos@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: linux-i2c@vger.kernel.org

>>  			/*
>>  			 * Map and check POR Device Status Register 2
>> -			 * (PORDEVSR2) at 0xE0014
>> +			 * (PORDEVSR2) at 0xE0014. Note than while MPC8533
>> +			 * and MPC8544 indicate SEC frequency ratio
>> +			 * configuration as bit 26 in PORDEVSR2, other MPC8xxx
>> +			 * parts may store it differently or may not have it
>> +			 * at all.
>
> So given this comment which you added...
>
>>  			 */
>>  			reg = ioremap(get_immrbase() + *prop + 0x14, 0x4);
>>  			if (!reg)
>>  				printk(KERN_ERR
>>  				       "Error: couldn't map PORDEVSR2\n");
>>  			else
>> -				val = in_be32(reg) & 0x00000080; /* sec-cfg */
>> +				val = in_be32(reg) & 0x00000020; /* sec-cfg */
>
> ... are you really sure there is no ancient device which needs the
> 0x00000080?

Various MPC SoCs indeed have different bit layout of
PORDEVSR2. Obviously not all of them indicate SEC frequency ratio
configuration at all, either in PORDEVSR2 or in some other register, as
not all SoCs contain SEC engine. In this regard,
mpc_i2c_get_sec_cfg_8xxx() is poorly named as it in its current form is
only applicable to a few SoCs from the whole MPC8xxx family.

mpc_i2c_get_sec_cfg_8xxx() is only called from the following snippet:

  else if ((SVR_SOC_VER(svr) == SVR_8533)
          || (SVR_SOC_VER(svr) == SVR_8544))
          /* the above 85xx SoCs have prescaler 3 or 2 */
          prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;

Both MPC8533 and MPC8544 do in fact indicate SEC frequency ratio
configuration as bit 26 in PORDEVSR2 according to [1,2], so I've added
the comment as a precaution for future uses. I can also rename the
function to something like mpc_i2c_get_sec_cfg_8533_8544(), which looks
ugly and doesn't scale.

AFAICS, mask 0x00000080 in the code clearly contradicts to what I read
in the docs.

[1] https://www.nxp.com/docs/en/reference-manual/MPC8533ERM.pdf
[2] https://www.nxp.com/docs/en/reference-manual/MPC8544ERM.pdf

Arsény
