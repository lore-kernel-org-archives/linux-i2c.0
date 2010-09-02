From: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Thu, 2 Sep 2010 14:42:53 -0700
Message-ID: <AANLkTimqzUXNYFeG8pPiKxCr_4r+LDB4hwv7NW39edxy@mail.gmail.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<AANLkTi=mC9jM7_U_KoAQ=Ec3Z5wefP-hii9M=_5ATo1i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=mC9jM7_U_KoAQ=Ec3Z5wefP-hii9M=_5ATo1i-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 30, 2010 at 1:44 PM, Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> Hi Colin,
>
> On Fri, Jul 30, 2010 at 3:36 AM, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrot=
e:
>> +static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg =
msgs[],
>> + =A0 =A0 =A0 int num)
>> +{
>> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D i2c_get_adapdata(ada=
p);
>> + =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (i2c_dev->is_suspended)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 =A0 clk_enable(i2c_dev->clk);
>> + =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stop =3D (i =3D=3D (num - 1)) ? 1 =
=A0: 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tegra_i2c_xfer_msg(i2c_dev, &m=
sgs[i], stop);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 clk_disable(i2c_dev->clk);
>> + =A0 =A0 =A0 return i;
>
> In case of error the i2c_transfer should return the error code, so th=
e
> return statement should be
> =A0 =A0 =A0 return ret ?: i;

Done
