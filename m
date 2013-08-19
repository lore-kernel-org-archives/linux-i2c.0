From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: sirf: reset i2c controller early after we get a noack
Date: Tue, 20 Aug 2013 06:49:54 +0800
Message-ID: <CAGsJ_4wgUOSeufUtHOj0UGHZ-2iOVbxqPTWoTEKd9mdVNPC9OA@mail.gmail.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-2-git-send-email-Baohua.Song@csr.com> <20130819180540.GD8626@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130819180540.GD8626@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2013/8/20 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>
>> +             while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
>> +                     cpu_relax();
>
> Are you sure you want no timeout here? Same for patch 2/5.

the real situation is that timeout never happen for resetting the i2c
controller, in pressure test, this loop will always break.

>
-barry
