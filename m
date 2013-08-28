From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: sirfsoc: support reverse direction of address
Date: Wed, 28 Aug 2013 20:00:41 +0800
Message-ID: <CAGsJ_4xaDtL1aOzh0JbgmA3umqQp8xc0yo842aaQos6DkQM7BA@mail.gmail.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-5-git-send-email-Baohua.Song@csr.com> <20130819180654.GE8626@katana>
 <CAGsJ_4xoPCJyWZ=_nN6wZBAy2qMER=cKOqY_t8K_jAX8fZWGmA@mail.gmail.com> <20130828094136.GG4086@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130828094136.GG4086@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2013/8/28 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>
>> > Hmm, you are not advertising I2C_FUNC_PROTOCOL_MANGLING so users should
>> > not use it.
>>
>> Wolfram, good comments. the old codes did miss
>> I2C_FUNC_PROTOCOL_MANGLING which i will fix in v2.
>>
>> > Does the master allow to implement the rest of mangling,
>> > too?
>> >
>>
>> i think only I2C_M_REV_DIR_ADDR. i didn't hear I2C_M_NOSTART,
>> I2C_M_IGNORE_NAK from hardware guys.
>
> Hmm, since the driver can't support all of MANGLING, it might be wise to
> not advertise it. I am undecided how to handle this generally. Until
> then, I'll accept this patch (and the series) as is.

ok, thanks Wolfram. then i will not have v2.
>

-barry
