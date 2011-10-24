From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Change readl to readw and writel to
 writew
Date: Mon, 24 Oct 2011 16:38:26 +0530
Message-ID: <4EA5472A.1000400@st.com>
References: <1319450282-914-1-git-send-email-rajeev-dlh.kumar@st.com> <20111024103316.GC26649@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111024103316.GC26649-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Hi Baruch

On 10/24/2011 4:03 PM, Baruch Siach wrote:
> Hi Rajeev,
>
> On Mon, Oct 24, 2011 at 03:28:02PM +0530, Rajeev Kumar wrote:
>> Since I2C designware registers are 16 bit wide and so we should use
>> readw/writew.
>>
>> Signed-off-by: Rajeev Kumar<rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-designware.c |  104 +++++++++++++++++-----------------
>>   1 files changed, 52 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
>> index 6eaa681..5149a10 100644
>> --- a/drivers/i2c/busses/i2c-designware.c
>> +++ b/drivers/i2c/busses/i2c-designware.c
>> @@ -216,11 +216,11 @@ struct dw_i2c_dev {
>>   	u32			abort_source;
>>   	int			irq;
>>   	struct i2c_adapter	adapter;
>> -	unsigned int		tx_fifo_depth;
>> -	unsigned int		rx_fifo_depth;
>> +	u16			tx_fifo_depth;
>> +	u16			rx_fifo_depth;
>>   };
>
> This looks wrong. The {tx,rx}_fifo_depth fields do not represent bit fields,
> but numbers. So unsigned int should be better here.

Yes, I agree with you, but I do not see any possibility of value of 
{tx,rx}_fifo_depth fields greater than 2^^16 - 1. So, would not it be 
better to keep them as u16 and save just 4 bytes.

~Rajeev

>
> baruch


>
