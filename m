From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: dln2: simplify return flow for dln2_i2c_enable
Date: Tue, 11 Nov 2014 14:49:26 +0200
Message-ID: <CAE1zotKi+kpv6a9xM=-qkpo3K9R5xKjrf2RZgDV7advXFS92FA@mail.gmail.com>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
	<1415708457-18798-3-git-send-email-octavian.purdila@intel.com>
	<20141111122636.GF29789@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141111122636.GF29789@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 11, 2014 at 2:26 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Nov 11, 2014 at 02:20:57PM +0200, Octavian Purdila wrote:
>> This fixes the following kbuild test robot warning:
>>
>> >> drivers/i2c/busses/i2c-dln2.c:70:1-4: WARNING: end returns can be simplified if negative or 0 value
>>
>> Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Reported-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-dln2.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
>> index 010a5fa..b3fb86a 100644
>> --- a/drivers/i2c/busses/i2c-dln2.c
>> +++ b/drivers/i2c/busses/i2c-dln2.c
>> @@ -54,7 +54,6 @@ struct dln2_i2c {
>>
>>  static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
>>  {
>> -     int ret;
>>       u16 cmd;
>>       struct {
>>               u8 port;
>> @@ -67,11 +66,7 @@ static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
>>       else
>>               cmd = DLN2_I2C_DISABLE;
>>
>> -     ret = dln2_transfer_tx(dln2->pdev, cmd, &tx, sizeof(tx));
>> -     if (ret < 0)
>> -             return ret;
>> -
>> -     return 0;
>> +     return dln2_transfer_tx(dln2->pdev, cmd, &tx, sizeof(tx));
>
> This looks like a bogus warning. It's not generally equivalent (ret > 0)
> and is not mandated by any style guide lines.
>

In this particular it should be equivalent (with the previous fix) and
it saves 5 lines, so I think its worth it.
