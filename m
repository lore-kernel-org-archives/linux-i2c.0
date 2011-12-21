From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Wed, 21 Dec 2011 11:29:29 +0800
Message-ID: <CAGsJ_4y8vwrK=UD8a10gf2aN=O3hs_R_jYBKeFYf0v+gk0hiuQ@mail.gmail.com>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com> <20111220200750.GA2577@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111220200750.GA2577-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/12/21 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:
> On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
>> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev=
)
>> +{
>> + =C2=A0 =C2=A0 struct clk *clk;
>> +
>> + =C2=A0 =C2=A0 clk =3D clk_get(&pdev->dev, NULL);
>> + =C2=A0 =C2=A0 err =3D clk_prepare(clk);
>> + =C2=A0 =C2=A0 err =3D clk_enable(clk);
> ...
>> + =C2=A0 =C2=A0 clk_disable(clk);
>> +
>> + =C2=A0 =C2=A0 dev_info(&pdev->dev, " I2C adapter ready to operate\=
n");
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pde=
v)
>> +{
>> + =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 clk_unprepare(siic->clk);
>> + =C2=A0 =C2=A0 clk_put(siic->clk);
>
> This doesn't look right - look at the state which you leave the clk i=
n
> upon successful probe, and now look at what you do when you do a remo=
ve.
>
> It seems that you disable an already disabled clock to me.

Russell, thanks! i will fix that in v5. but i have to wait for Ben's
feedback and add other fixes together before doing that.
Ben seems to have been scheduled out, i hope the state is
TASK_INTERRUPTBILE not TASK_UNINTERRUPTBILE. Then my signal can wake
up him.

Thanks
barry
