From: Cerrato Renaud <r.cerrato-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: added support for I2C_M_STOP flag
Date: Mon, 24 Jun 2013 08:37:59 +0200
Message-ID: <51C7E947.20000@til-technologies.fr>
References: <1371731837-1476-1-git-send-email-r.cerrato@til-technologies.fr> <20130620193915.GD2961@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130620193915.GD2961@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The 'if (i)' because the STOP condition should only occur after the 
first message is transmitted (and excepted for the last message, 
because there's already a STOP outside the for loop). I thought it was 
cleaner than 'if(i < num - 1)' at the bottom of the for loop.

Sorry for the missing Signed-Off... :-/ Should I submit another patch?

On jeudi 20 juin 2013 21:39:16, Wolfram Sang wrote:
> On Thu, Jun 20, 2013 at 02:37:17PM +0200, Renaud Cerrato wrote:
>> Current i2c bit algo implementation doesn't actually support I2C_M_STOP flag despite I2C_FUNC_PROTOCOL_MANGLING functionnality.
>
> Signed-Off is missing :( Please run checkpatch.pl before sending
> patches!
>
> What was your testcase?
>
>> ---
>>  drivers/i2c/algos/i2c-algo-bit.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
>> index fad22b0..00446a6 100644
>> --- a/drivers/i2c/algos/i2c-algo-bit.c
>> +++ b/drivers/i2c/algos/i2c-algo-bit.c
>> @@ -557,6 +557,12 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>>  	for (i = 0; i < num; i++) {
>>  		pmsg = &msgs[i];
>>  		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
>> +		if (pmsg->flags & I2C_M_STOP) {
>> +			if (i) {
>
> Why 'if (i)'?
>
>> +				bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n");
>> +				i2c_stop(adap);
>> +			}
>> +		}
>>  		if (!(pmsg->flags & I2C_M_NOSTART)) {
>>  			if (i) {
>>  				bit_dbg(3, &i2c_adap->dev, "emitting "
>> --
>> 1.7.2.5
>>
>>
