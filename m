From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: i2c-ocores: Add irq support for sparc
Date: Tue, 13 Nov 2012 07:18:37 -0600
Message-ID: <50A248AD.9000705@gmail.com>
References: <1352739591-1317-1-git-send-email-andreas@gaisler.com> <1352739591-1317-2-git-send-email-andreas@gaisler.com> <20121113111055.GF23119@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121113111055.GF23119-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 11/13/2012 05:10 AM, Wolfram Sang wrote:
> Hi,
> 
> On Mon, Nov 12, 2012 at 05:59:50PM +0100, Andreas Larsson wrote:
>> Add sparc support by using platform_get_irq instead of platform_get_resource.
>> There are no platform resources of type IORESOURCE_IRQ for sparc, but
>> platform_get_irq works for sparc. In the non-sparc case platform_get_irq
>> internally uses platform_get_resource.
>>
>> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
>> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
>> ---
>> Changes since v1:
>>  - platform_get_irq now works for sparc, so that is used for all platforms
>>  - Acked by Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
>>
>>  drivers/i2c/busses/i2c-ocores.c |    9 +++++----
>>  1 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
>> index bffd550..0b71dc6 100644
>> --- a/drivers/i2c/busses/i2c-ocores.c
>> +++ b/drivers/i2c/busses/i2c-ocores.c
>> @@ -267,7 +267,8 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>>  {
>>  	struct ocores_i2c *i2c;
>>  	struct ocores_i2c_platform_data *pdata;
>> -	struct resource *res, *res2;
>> +	struct resource *res;
>> +	int irq;
>>  	int ret;
>>  	int i;
>>  
>> @@ -275,8 +276,8 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>>  	if (!res)
>>  		return -ENODEV;
>>  
>> -	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> -	if (!res2)
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>>  		return -ENODEV;
> 
> Why not pass the error code you got?

I believe that should actually be a check for 'irq <= 0' as it returns
NO_IRQ on error.

>>  
>>  	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
>> @@ -313,7 +314,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>>  	ocores_init(i2c);
>>  
>>  	init_waitqueue_head(&i2c->wait);
>> -	ret = devm_request_irq(&pdev->dev, res2->start, ocores_isr, 0,
>> +	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
>>  			       pdev->name, i2c);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> 
> Rest looks good.
> 
