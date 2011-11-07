From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Mon, 7 Nov 2011 13:36:24 +0800
Message-ID: <CAGsJ_4wPmNXxQ3aDNasj17YBRJ-iXyQoYYPQwfCWK5dQBWF5PQ@mail.gmail.com>
References: <1320228610-18129-1-git-send-email-Barry.Song@csr.com>
 <20111102103904.GB4937@totoro> <20111102105210.GZ19187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111102105210.GZ19187-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/11/2 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:
> On Wed, Nov 02, 2011 at 10:39:04AM +0000, Jamie Iles wrote:
>> > + =C2=A0 clk =3D clk_get(&pdev->dev, NULL);
>> > + =C2=A0 if (IS_ERR(clk)) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D PTR_ERR(clk);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Clock ge=
t failed\n");
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> > + =C2=A0 }
>> > +
>> > + =C2=A0 clk_enable(clk);
>>
>> The return value of clk_enable() should really be checked.
>
> Now that the clk_prepare() patch has been enabled, new drivers should=
 be
> written assuming that clk_prepare() will be necessary before clk_enab=
le().
>
> And one may query why it's not possible to use clk_enable()...clk_dis=
able()
> around the transfer itself, so the clock can be turned off while the =
device
> is idle. =C2=A0Obviously if its expecting to be operated in slave mod=
e as well
> then you may need to keep the clock enabled.

yes. we can have a clk_enable at the beginning of i2c_sirfsoc_xfer and
clk_disable at the end.
i need some tests to check the hardware is robust enough.
actually, i can add runtime pm as well.

-barry
