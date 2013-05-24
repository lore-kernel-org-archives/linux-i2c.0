From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC v3 1/3] i2c: i2c-bfin-twi: convert to devm_* API
Date: Fri, 24 May 2013 11:09:26 +0800
Message-ID: <519ED9E6.8050309@huawei.com>
References: <1369310405-21112-1-git-send-email-libo.chen@huawei.com> <B168F8A49F4BCF4C84FD23DA5F6363EE010634@NWD2MBX7.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B168F8A49F4BCF4C84FD23DA5F6363EE010634-Nxh9ahLCS6GuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org" <guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2013/5/24 10:49, Zhang, Sonic wrote:
>> >-      iface = kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
>> >+      iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
>> >+                      GFP_KERNEL);
>> >       if (!iface) {
>> >               dev_err(&pdev->dev, "Cannot allocate memory\n");
>> >-              rc = -ENOMEM;
>> >-              goto out_error_nomem;
>> >+              return -ENOMEM;
>> >       }
>> >
>> >       spin_lock_init(&(iface->lock));
>> >
>> >       /* Find and map our resources */
>> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >-      if (res == NULL) {
>> >-              dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
>> >-              rc = -ENOENT;
>> >-              goto out_error_get_res;
>> >-      }
> Why remove the resource mem check?
> 
> Regards,
> 
> Sonic

devm_ioremap_resource() had done for us, you can refernce the function`comment.

Thanks,

Libo
