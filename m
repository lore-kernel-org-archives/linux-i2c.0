From: Chaitanya Lala <clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Subject: Re: [linux-2.6 PATCH 1/1] i2c-i801: Re-read busy bit and wait for
  transaction to complete
Date: Tue, 15 Sep 2009 10:34:56 -0700
Message-ID: <4AAFD040.6040702@riverbed.com>
References: <20090826221105.GA19712@clala-laptop> <20090912213843.59e990ad@hyperion.delvare>
Reply-To: clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090912213843.59e990ad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Chaitanya,
>
> On Wed, 26 Aug 2009 15:11:05 -0700, Chaitanya Lala wrote:
>   
>> Intel ESB2 SMBus chip seems to have an issue where it momentarily
>> resets the HOST_BUSY bit in the host status register.
>>     
>
> Are you certain? There is a known erratum on some of the ICH chips which
> is slightly different.

Not really. I think, I might have hit the same issue.

>  The erratum is about the HOST_BUSY flag not
> being set immediately when starting a new transaction, so there is the
> chance that the first check concludes that the transaction is already
> over. This sounds somewhat similar to the problem you're seeing. 

Your reasoning leads me to believe that I might have hit the same issue.

> One
> big difference though is that the glitch can only happen at the
> beginning of the transaction, according to the erratum.
>
>   
>> This confuses
>> the driver waiting for an SMBus transaction to complete. This patch
>> adds a workaround for the same.
>>
>> Signed-off-by: Chaitanya Lala <clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-i801.c |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index 9d2c5ad..1a04817 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -222,6 +222,7 @@ static int i801_transaction(int xact)
>>  	int status;
>>  	int result;
>>  	int timeout = 0;
>> +	int counter = 0;
>>  
>>  	result = i801_check_pre();
>>  	if (result < 0)
>> @@ -231,12 +232,34 @@ static int i801_transaction(int xact)
>>  	 * INTREN, SMBSCMD are passed in xact */
>>  	outb_p(xact | I801_START, SMBHSTCNT);
>>  
>> +try_again:
>>  	/* We will always wait for a fraction of a second! */
>>  	do {
>>  		msleep(1);
>>  		status = inb_p(SMBHSTSTS);
>>  	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
>>  
>> +	/* The i801 chip resets the HOST_BUSY bit
>> +	*  to indicate that it has completed the transaction,
>> +	*  but a moment later sets it again. Seems like a glitch.
>> +	*  Changed code to check the value more times if its not a timeout.
>> +	*/
>> +	if (timeout < MAX_TIMEOUT) {
>> +		msleep(1);
>> +		status = inb_p(SMBHSTSTS);
>> +		if (status  & SMBHSTSTS_HOST_BUSY) {
>> +			dev_warn(&I801_dev->dev, "Busy bit set again"
>> +				"(%02x)\n", status);
>> +			if (++counter < 3) {
>> +				dev_info(&I801_dev->dev, "Trying"
>> +					"again\n");
>> +				goto try_again;
>> +			}
>> +			dev_err(&I801_dev->dev, "No use"
>> +				" retrying-(%02x)\n", status);
>> +		}
>> +	}
>> +
>>  	result = i801_check_post(status, timeout > MAX_TIMEOUT);
>>  	if (result < 0)
>>  		return result;
>>     
>
> This workaround causes a huge performance penalty. You are basically
> doubling the delay for each and every transaction. I have just tested
> it. At HZ=1000 it doesn't matter too much because the transactions are
> reasonably fast, but at HZ=250 or lower, the impact is high. This is
> hardly acceptable. We need to better understand the exact conditions of
> the problem you have hit, and limit the performance hit as much as we
> can. Questions:
>
> With which value of HZ do you hit the problem? Does the problem go away
> for lower values of HZ?
>   

I use 100 and 250. Since I do not use the bus for a lot of stuff, I did not
see the performance issue.

> Do you hit the problem for all transaction types, or only specific ones?
>   

For all transactions.

> Do you hit the problem with specific slaves, or all of them?
>   

I hit it with a superIO chip and an eeprom chip.

> Did you ever hit the problem with other Intel chips than the ESB2?
>   

I just have a machine that uses ESB2. So cannot really say much.

> I'm wondering if the following fix would be enough for you. It has
> almost no performance impact at HZ=250 and less (and could be improved
> to have none at all for these values of HZ.)
>
> ---
>  drivers/i2c/busses/i2c-i801.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-2.6.32-pre.orig/drivers/i2c/busses/i2c-i801.c	2009-06-10 05:05:27.000000000 +0200
> +++ linux-2.6.32-pre/drivers/i2c/busses/i2c-i801.c	2009-09-12 21:16:44.000000000 +0200
> @@ -233,7 +233,7 @@ static int i801_transaction(int xact)
>  
>  	/* We will always wait for a fraction of a second! */
>  	do {
> -		msleep(1);
> +		msleep(2);
>  		status = inb_p(SMBHSTSTS);
>  	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
>  
> @@ -338,7 +338,7 @@ static int i801_block_transaction_byte_b
>  		/* We will always wait for a fraction of a second! */
>  		timeout = 0;
>  		do {
> -			msleep(1);
> +			msleep(2);
>  			status = inb_p(SMBHSTSTS);
>  		}
>  		while ((!(status & SMBHSTSTS_BYTE_DONE))
>
>
>   

I tried your patch and preliminary results look encouraging.
Will let you know about the final results in a few days.

One question - Are we sure that msleep(2) would fix the glitch for good ?
I am not very clear about the timings constraints of the i2c bus, hence 
the query.

Thanks for your help.

Regards,
Chaitanya
