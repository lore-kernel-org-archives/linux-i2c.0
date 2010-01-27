From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: davinci: Fix smbus Oops with AIC33 usage
Date: Wed, 27 Jan 2010 06:50:08 -0800
Message-ID: <87k4v3y53z.fsf@deeprootsystems.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-2-git-send-email-khilman@deeprootsystems.com>
	<026601ca9f54$17a18110$46e48330$@raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <026601ca9f54$17a18110$46e48330$@raj-l0cyMroinI0@public.gmane.org> (Sudhakar Rajashekhara's message of "Wed\, 27 Jan 2010 18\:54\:45 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, 'Dirk Behme' <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Alexander Vasiliev' <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

"Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org> writes:

> Hi,
>
> On Wed, Jan 27, 2010 at 05:11:28, Kevin Hilman wrote:
>> From: Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> 
>> This fixes Oops at kernel startup while "scanning" for TLV320AIC23IDx
>> addresses.
>> 
>> Signed-off-by: Alexander Vasiliev <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Acked-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-davinci.c |   29 +++++++++++++++++++++++++----
>>  1 files changed, 25 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index c89687a..444a9f2 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>
> [...]
>
>> @@ -290,6 +293,16 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>>  
>>  	dev->terminate = 0;
>> +
>> +	/* First byte should be set here, not after interrupt,
>> +	 * because transmit-data-ready interrupt can come before
>> +	 * NACK-interrupt during sending of previous message and
>> +	 * ICDXR may have wrong data */
>> +	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
>> +		dev->buf_len--;
>> +	}
>> +
>
> I found an issue on DA850 while using this patch. 

ok, I'll drop this one for 2.6.34 until we figure this out.

> I think the above code should come after the
> below lines because an I2C transaction is being carried out before configuring the I2C mode
> register (which has bits to configure Master, Start condition etc), which causes undefined
> behavior.

hmm, are you seeing this behavior on davinci git too?  This is the same
patch that has been in davinci git for some time?

Kevin

>
>>  	/* write the data into mode register */
>>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>>  
>
> Regards,
> Sudhakar
