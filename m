From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC v3 2/3] i2c: pxa: convert to devm_* API
Date: Fri, 24 May 2013 11:51:55 +0800
Message-ID: <519EE3DB.5060505@huawei.com>
References: <1369310408-10348-1-git-send-email-libo.chen@huawei.com> <519EDFFC.5020308@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <519EDFFC.5020308-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gu Zheng <guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>
Cc: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2013/5/24 11:35, Gu Zheng wrote:
> Hi Libo,
>    I think you can merge patch 1/3 and 2/3, they e thdo the saming that using  devm_* API to simplify
> and make the code clean, and the additional goal is it also can fix a bug. Besides, maybe you need to
> change the title and make it clear and self-described.
> 
> Thanks,
> Gu

thanks for your suggestion. But, I had referenced other guy`s patch title, they usually do like this, so I think it is enough.

Regards,

Libo
