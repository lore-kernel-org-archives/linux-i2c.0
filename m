From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
Date: Tue, 14 Feb 2017 11:29:39 +0200
Message-ID: <CAHp75VcwAym_ujHfyEJKypsvQftCY5JytDy922xqMM9yKz1GfQ@mail.gmail.com>
References: <1486632753-17363-1-git-send-email-baoyou.xie@linaro.org>
 <1486632753-17363-3-git-send-email-baoyou.xie@linaro.org> <8322ae7c-a74d-c6a3-9cdb-4cd5584f37d4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8322ae7c-a74d-c6a3-9cdb-4cd5584f37d4-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 14, 2017 at 6:05 AM, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 2017=E5=B9=B402=E6=9C=8809=E6=97=A5 17:32, Baoyou Xie wrote:
>>

First of all, please, Jun, remove tons of lines of over quoting when
answering to emails with one line question. Respect others time.

See below.

>> +static irqreturn_t zx2967_i2c_isr(int irq, void *dev_id)
>> +{
>> +       u32 status;
>> +       struct zx2967_i2c_info *zx_i2c =3D (struct zx2967_i2c_info *)dev=
_id;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&zx_i2c->lock, flags);
>
>
> Is this spin lock really necessary?

If you protect IO and one CPU is in interrupt while another in some
other function you need to have a spin lock.

>> +
>> +       status =3D zx2967_i2c_readl(zx_i2c, REG_STAT) & I2C_INT_MASK;
>> +       zx2967_i2c_isr_clr(zx_i2c);
>> +
>> +       if (status & I2C_ERROR_MASK) {
>> +               spin_unlock_irqrestore(&zx_i2c->lock, flags);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       if (status & I2C_TRANS_DONE)
>> +               complete(&zx_i2c->complete);
>> +
>> +       spin_unlock_irqrestore(&zx_i2c->lock, flags);
>> +
>> +       return IRQ_HANDLED;
>> +}

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
