From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: sirfsoc: support reverse direction of address
Date: Tue, 20 Aug 2013 10:30:34 +0800
Message-ID: <CAGsJ_4xoPCJyWZ=_nN6wZBAy2qMER=cKOqY_t8K_jAX8fZWGmA@mail.gmail.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-5-git-send-email-Baohua.Song@csr.com> <20130819180654.GE8626@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130819180654.GE8626@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2013/8/20 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
> On Tue, Aug 13, 2013 at 05:11:30PM +0800, Barry Song wrote:
>> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>>
>> if users set I2C_M_REV_DIR_ADDR, revert the direction of address.
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>
> Hmm, you are not advertising I2C_FUNC_PROTOCOL_MANGLING so users should
> not use it.

Wolfram, good comments. the old codes did miss
I2C_FUNC_PROTOCOL_MANGLING which i will fix in v2.

> Does the master allow to implement the rest of mangling,
> too?
>

i think only I2C_M_REV_DIR_ADDR. i didn't hear I2C_M_NOSTART,
I2C_M_IGNORE_NAK from hardware guys.

-barry
