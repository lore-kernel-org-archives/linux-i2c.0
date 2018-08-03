From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: Re: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
Date: Fri, 3 Aug 2018 10:19:40 +0530
Message-ID: <77928aed-a9c4-48af-6766-693a142568eb@caviumnetworks.com>
References: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
 <20180731210513.izqbzpvvqq5lq4uh@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731210513.izqbzpvvqq5lq4uh@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jglauber@cavium.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfran,

Thanks for the review.

I will update the patch with a small comment section above
len --;
so that there is no confusion.

On 08/01/2018 02:35 AM, Wolfram Sang wrote:
>> --- a/drivers/i2c/busses/i2c-xlp9xx.c
>> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
>> @@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
>>   	if (priv->len_recv) {
>>   		/* read length byte */
>>   		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
>> +		len--;
> 
> I don't know the HW and assume the above line is correct because of
> merging two interrupts into one. However, the line looks a bit stray,
> and I wonder if we shouldn't add a comment somewhere explaining the
> situation similar to the second paragraph of the commit message?
> 

Regards,
-George
