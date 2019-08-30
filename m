From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: i2c mv64xxx: Update documentation path
Date: Fri, 30 Aug 2019 10:31:03 +0200
Message-ID: <87a7brxdfc.fsf@FE-laptop>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190813060913.14722-1-efremov@linux.com> <20190829200055.GJ3740@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829200055.GJ3740@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Denis Efremov <efremov@linux.com>
Cc: linux-kernel@vger.kernel.org, joe@perches.com, Maxime Ripard <maxime.ripard@bootlin.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Tue, Aug 13, 2019 at 09:09:13AM +0300, Denis Efremov wrote:
>> Update MAINTAINERS record to reflect the file move
>> from i2c-mv64xxx.txt to marvell,mv64xxx-i2c.yaml.
>> 
>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Cc: linux-i2c@vger.kernel.org
>> Fixes: f8bbde72ef44 ("dt-bindings: i2c: mv64xxx: Add YAML schemas")
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>
> Looks OK to me, Gregory or Maxime?

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 87ac0378186c..590dcebe627f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7505,7 +7505,7 @@ I2C MV64XXX MARVELL AND ALLWINNER DRIVER
>>  M:	Gregory CLEMENT <gregory.clement@bootlin.com>
>>  L:	linux-i2c@vger.kernel.org
>>  S:	Maintained
>> -F:	Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +F:	Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
>>  F:	drivers/i2c/busses/i2c-mv64xxx.c
>>  
>>  I2C OVER PARALLEL PORT
>> -- 
>> 2.21.0
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
