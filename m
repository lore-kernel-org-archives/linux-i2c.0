From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/9] i2c-designware: Allow mixed endianness accesses
Date: Tue, 25 Jan 2011 11:28:22 +0900
Message-ID: <4D3E3546.80806@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-8-git-send-email-dirk.brandewie@gmail.com>
 <2C61B7B7755780449CA3ED217819DA761BC7B3BD@MAIL.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <2C61B7B7755780449CA3ED217819DA761BC7B3BD-VR+kULHyjlM/vpUtHNqADA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: "'dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 1/18/2011 2:19 AM, Jean-Hugues Deschenes wrote:
>> +u32 dw_readl(struct dw_i2c_dev *dev, int offset)
>> +{
>> +	u32 value = readl(dev->base + offset);
>> +
>> +	if (dev->swab)
>> +		return swab32(value);
>> +	else
>> +		return value;
>> +}
>> +EXPORT_SYMBOL(dw_readl);
>> +
>> +void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
>> +{
>> +	if (dev->swab)
>> +		b = swab32(b);
>> +
>> +	writel(b, dev->base + offset);
>> +}
>> +EXPORT_SYMBOL(dw_writel);
> 
> I would just suggest to declare these accessors as static and avoid to
> export the symbols, especially given their short names. Inlining these
> short, frequently-accessed functions is attractive.
> 
>> +extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
>> +extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
> 
> Same here; I don't believe these lines are necessary.

Ack.

Furthermore, I'd like to see this patch at the start at Dirk-san's
patchset.  We don't want to make a already proposed patch adapted to
a modified driver.
-- 
Shinya Kuribayashi
Renesas Electronics
