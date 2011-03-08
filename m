From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] MAX8997/8966 PMIC Regulator Driver Initial Release
Date: Tue, 8 Mar 2011 10:50:04 +0900
Message-ID: <AANLkTik4cT3fbsCLFcsUcNMtia1Ymnhe8JFzzO+N+9sq@mail.gmail.com>
References: <1299221427-4726-1-git-send-email-myungjoo.ham@samsung.com>
	<1299221427-4726-3-git-send-email-myungjoo.ham@samsung.com>
	<20110305120302.GC30187@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110305120302.GC30187-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, MyungJoo Ham <myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 5, 2011 at 9:03 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Fri, Mar 04, 2011 at 03:50:27PM +0900, MyungJoo Ham wrote:

[]

>
>> +static int max8997_reg_enable_suspend(struct regulator_dev *rdev)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>
> This looks odd, especially since you have a disable operation?

The intention is to keep it enabled if it was enabled before entering
sleep and not to enable if it has not been using while the system is
running. Probably, we need three states for suspend-prepare for
regulators: disable, enable, keep_state?

>

[]

>
>> +static int max8997_resume(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct platform_device *pdev =3D container_of(dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct platform_device, dev);
>> + =C2=A0 =C2=A0 struct max8997_data *max8997 =3D platform_get_drvdat=
a(pdev);
>> + =C2=A0 =C2=A0 struct i2c_client *i2c =3D max8997->iodev->i2c;
>> + =C2=A0 =C2=A0 struct regulator_dev *rdev;
>> + =C2=A0 =C2=A0 int ret, reg, mask, pattern;
>> + =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 u8 val;
>> +
>> + =C2=A0 =C2=A0 /* Show Error/Warning Messages for Inconsistency */
>> + =C2=A0 =C2=A0 for (i =3D 0; i < MAX8997_REG_MAX; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (max8997->saved_rdev[=
i]) {
>
> We should put this into the regulator core rather than doing it in
> drivers - it's not really driver specific and other regulators that
> can't preserve state over suspend and resume will need it.
>

This part was sort of "debug and test" part of the driver and removed
in the recent version of the patch.
However, the regulator core depends on calling
regulator_suspend_prepare by machine/architecture pm code and the core
does not have resume-related support. For that matter, I've made and
been using "regulator_suspend_finish" locally. I will post that patch
soon.



Thanks.


- MyungJoo
--=20
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
