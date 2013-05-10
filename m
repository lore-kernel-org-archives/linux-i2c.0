From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before
 it init successful
Date: Fri, 10 May 2013 09:01:36 +0800
Message-ID: <518C46F0.6060507@huawei.com>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com> <1368088044-20408-2-git-send-email-libo.chen@huawei.com> <B168F8A49F4BCF4C84FD23DA5F6363EEAD57@NWD2MBX7.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B168F8A49F4BCF4C84FD23DA5F6363EEAD57-Nxh9ahLCS6GuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2013/5/9 16:33, Zhang, Sonic wrote:
> Hi Libo,
> 
>> -----Original Message-----
>> From: Libo Chen [mailto:libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>> Sent: Thursday, May 09, 2013 4:27 PM
>> To: Zhang, Sonic; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>> Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; Libo Chen
>> Subject: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before it init
>> successful
>>
>> down out_error_no_irq. When platform_get_irq fail, no need to free peripheral
>>
>> Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>> drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>> index 05080c4..6617645 100644
>> --- a/drivers/i2c/busses/i2c-bfin-twi.c
>> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
>> @@ -709,9 +709,9 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>> out_error_add_adapter:
>>       free_irq(iface->irq, iface);
>> out_error_req_irq:
>> -out_error_no_irq:
>>       peripheral_free_list((unsigned short *)pdev->dev.platform_data);
>> out_error_pin_mux:
>> +out_error_no_irq:
>>       iounmap(iface->regs_base);
>> out_error_ioremap:
>> out_error_get_res:
>> --
> 
> Sorry, but you didn't exchange as I suggested.
> Should be
> 

Hi Sonic,

Look at peripheral_request_list()
{
	u16 cnt;
	int ret;

	for (cnt = 0; per[cnt] != 0; cnt++) {

		ret = peripheral_request(per[cnt], label);

		if (ret < 0) {
			for ( ; cnt > 0; cnt--)
				peripheral_free(per[cnt - 1]);

			return ret;
		}
	}

	return 0;
}


When peripheral_request fail, it had called peripheral_free().
So there is no reason to call peripheral_free_list again.

Did I miss something else?


>> out_error_req_irq:
>> -out_error_no_irq:
>> +out_error_pin_mux:
>>       peripheral_free_list((unsigned short *)pdev->dev.platform_data);
>> -out_error_pin_mux:
>> +out_error_no_irq:
> 
> 
> Regards,
> 
> Sonic
> 
> 
> 
