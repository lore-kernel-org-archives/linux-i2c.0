From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V4, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller driver
Date: Wed, 20 May 2015 16:35:08 -0400
Message-ID: <CAC=U0a3dxJi1c1FrQaqGojc8JXzs=om2Z1r=nB0dinyrFzz-+g@mail.gmail.com>
References: <1432052625-6210-1-git-send-email-kdasu.kdev@gmail.com>
	<555BA22B.9020408@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <555BA22B.9020408-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ray,

I am using  non combined operation so it not necessary have limit. I
am not sending a stop condition till the last byte is written or read.
So if the xfer has more than the i2c buffer len we break up the
transfers after the initial salve address write into max read/write
data buffer size.

Thanks
Kamal

On Tue, May 19, 2015 at 4:50 PM, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> Hi Kamal,
>
> There's one change still missing (that I mentioned when reviewing v2 of the
> patchset):
>
>>>>
> What is the max len that can be supported? BSC_CNT_REG1_MASK = 63? Then
> you should check against that.
>
> Note Wolfram has introduced a way to validate the supported data length
> at the i2c-core, which you should adapt:
>
> commit b7f625840267b18ef1011cba0085bb7e237d76f7
> Author: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Date:   Mon Jan 5 23:45:59 2015 +0100
>
>     i2c: add quirk checks to core
>
>     Let the core do the checks if HW quirks prevent a transfer. Saves code
>     from drivers and adds consistency.
> <<<
>
> So you should add struct i2c_adapter_quirks and set the max_read_len and
> max_write_len.
>
> I have no more comment for the rest of the code.
>
> Thanks,
>
> Ray
>
