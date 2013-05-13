From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before
 it init successful
Date: Mon, 13 May 2013 08:52:11 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EEB7D7@NWD2MBX7.ad.analog.com>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
 <1368088044-20408-2-git-send-email-libo.chen@huawei.com>
 <B168F8A49F4BCF4C84FD23DA5F6363EEAD57@NWD2MBX7.ad.analog.com>
 <518C46F0.6060507@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <518C46F0.6060507@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Libo Chen <clbchenlibo.chen@huawei.com>
Cc: Libo Chen <libo.chen@huawei.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "lizefan@huawei.com" <lizefan@huawei.com>
List-Id: linux-i2c@vger.kernel.org

Hi Libo,

>-----Original Message-----
>From: Libo Chen [mailto:clbchenlibo.chen@huawei.com]
>Sent: Friday, May 10, 2013 9:02 AM
>To: Zhang, Sonic
>Cc: Libo Chen; wsa@the-dreams.de; uclinux-dist-devel@blackfin.uclinux.org;
>linux-kernel@vger.kernel.org; linux-i2c@vger.kernel.org; lizefan@huawei.com
>Subject: Re: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before it init
>successful
>
>On 2013/5/9 16:33, Zhang, Sonic wrote:
>> Hi Libo,
>>
>>> -----Original Message-----
>>> From: Libo Chen [mailto:libo.chen@huawei.com]
>>> Sent: Thursday, May 09, 2013 4:27 PM
>>> To: Zhang, Sonic; wsa@the-dreams.de
>>> Cc: uclinux-dist-devel@blackfin.uclinux.org;
>>> linux-kernel@vger.kernel.org; linux- i2c@vger.kernel.org;
>>> lizefan@huawei.com; Libo Chen
>>> Subject: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral
>>> before it init successful
>>>
>>> down out_error_no_irq. When platform_get_irq fail, no need to free
>>> peripheral
>>>
>>> Signed-off-by: Libo Chen <libo.chen@huawei.com>
>>> ---
>>> drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c
>>> b/drivers/i2c/busses/i2c-bfin-twi.c
>>> index 05080c4..6617645 100644
>>> --- a/drivers/i2c/busses/i2c-bfin-twi.c
>>> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
>>> @@ -709,9 +709,9 @@ static int i2c_bfin_twi_probe(struct
>>> platform_device *pdev)
>>> out_error_add_adapter:
>>>       free_irq(iface->irq, iface);
>>> out_error_req_irq:
>>> -out_error_no_irq:
>>>       peripheral_free_list((unsigned short
>>> *)pdev->dev.platform_data);
>>> out_error_pin_mux:
>>> +out_error_no_irq:
>>>       iounmap(iface->regs_base);
>>> out_error_ioremap:
>>> out_error_get_res:
>>> --
>>
>> Sorry, but you didn't exchange as I suggested.
>> Should be
>>
>
>Hi Sonic,
>
>Look at peripheral_request_list()
>{
>       u16 cnt;
>       int ret;
>
>       for (cnt = 0; per[cnt] != 0; cnt++) {
>
>               ret = peripheral_request(per[cnt], label);
>
>               if (ret < 0) {
>                       for ( ; cnt > 0; cnt--)
>                               peripheral_free(per[cnt - 1]);
>
>                       return ret;
>               }
>       }
>
>       return 0;
>}
>
>
>When peripheral_request fail, it had called peripheral_free().
>So there is no reason to call peripheral_free_list again.
>
>Did I miss something else?
>
>
Yes, you are right. They are freed in peripheral_request_list() if any one fails.

You have my ACK on this patch.

Regards,

Sonic
