From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V5] i2c: imx: add runtime pm support to improve the performance
Date: Fri, 28 Aug 2015 07:49:46 +0200
Message-ID: <55DFF67A.1050606@gmail.com>
References: <1440566600-9371-1-git-send-email-b54642@freescale.com> <55DE0AE3.8060302@gmail.com> <CY1PR0301MB0858FC4A5C79BDE242B0062DCF6F0@CY1PR0301MB0858.namprd03.prod.outlook.com> <55DEA509.2090406@gmail.com> <CY1PR0301MB085833EDBA03A6D478837652CF6F0@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CY1PR0301MB085833EDBA03A6D478837652CF6F0-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 27.08.2015 um 09:06 schrieb Gao Pandy:
> From: Heiner Kallweit <mailto:hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> Sent: Thursday, A=
ugust 27, 2015 1:50 PM
>> To: Gao Pan-B54642; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Duan Fugang-B38611;
>> u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
>> Subject: Re: [Patch V5] i2c: imx: add runtime pm support to improve =
the
>> performance
>>
>> Am 27.08.2015 um 06:01 schrieb Gao Pandy:
>>> From: Heiner Kallweit <mailto:hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> Sent: Thursday,
>>> August 27, 2015 2:52 AM
>>>> To: Gao Pan-B54642; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Duan Fugang-B38611=
;
>>>> u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
>>>> Subject: Re: [Patch V5] i2c: imx: add runtime pm support to improv=
e
>>>> the performance
>>>>
>>>> Am 26.08.2015 um 07:23 schrieb Gao Pan:
>>>>> In our former i2c driver, i2c clk is enabled and disabled in xfer
>>>>> function, which contributes to power saving. However, the clk ena=
ble
>>>>> process brings a busy wait delay until the core is stable. As a
>>>>> result, the performance is sacrificed.
>>>>>
>>>>> To weigh the power consumption and i2c bus performance, runtime p=
m
>>>>> is the good solution for it. The clk is enabled when a i2c transf=
er
>>>>> starts, and disabled after a specifically defined delay.
>>>>>
>>>>> Without the patch the test case (many eeprom reads) executes with
>>>> approx:
>>>>> real 1m7.735s
>>>>> user 0m0.488s
>>>>> sys 0m20.040s
>>>>>
>>>>> With the patch the same test case (many eeprom reads) executes wi=
th
>>>> approx:
>>>>> real 0m54.241s
>>>>> user 0m0.440s
>>>>> sys 0m5.920s
>>>>>
>>>>> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>> Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>> [wsa: fixed some indentation]
>>>>> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>>>> ---
>>>>> V2:
>>>>> As Uwe Kleine-K=C3=B6nig's suggestion, the version do below chang=
es:
>>>>>  -call clk_prepare_enable in probe to avoid never enabling clock
>>>>>   if CONFIG_PM is disabled
>>>>>  -enable clock before request IRQ in probe  -remove the pm staff =
in
>>>>> i2c_imx_isr
>>>>>
>>>>> V3:
>>>>>  -pm_runtime_get_sync returns < 0 as error
>>>>>
>>>>> V4:
>>>>>  -add pm_runtime_set_active before pm_runtime_enable  -replace
>>>>> pm_runtime_put_autosuspend with pm_runtime_autosuspend
>>>>>   in probe
>>>>>  -add error disposal when i2c_add_numbered_adapter fails
>>>>>
>>>>> V5:
>>>>>  -clean up and disable runtime PM when i2c_add_numbered_adapter
>>>>> fails -use pm_runtime_get and pm_runtime_put_autosuspend in probe
>>>>>
>>>>>  drivers/i2c/busses/i2c-imx.c | 91
>>>>> ++++++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 76 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-imx.c
>>>>> b/drivers/i2c/busses/i2c-imx.c index 785aa67..8940a89 100644
>>>>> --- a/drivers/i2c/busses/i2c-imx.c
>>>>> +++ b/drivers/i2c/busses/i2c-imx.c
>>>>> @@ -53,6 +53,7 @@
>>>>>  #include <linux/platform_device.h>
>>>>>  #include <linux/sched.h>
>>>>>  #include <linux/slab.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>
>>>>>  /** Defines
>>>>> *****************************************************************=
***
>>>>>
>>>>> *****************************************************************=
***
>>>>> **
>>>>> *********/
>>>>> @@ -118,6 +119,8 @@
>>>>>  #define I2CR_IEN_OPCODE_0	0x0
>>>>>  #define I2CR_IEN_OPCODE_1	I2CR_IEN
>>>>>
>>>>> +#define I2C_PM_TIMEOUT		10 /* ms */
>>>>> +
>>>>>  /** Variables
>>>>> *****************************************************************=
*
>>>>>
>>>>> *****************************************************************=
***
>>>>> **
>>>>> *********/
>>>>>
>>>>> @@ -520,9 +523,6 @@ static int i2c_imx_start(struct imx_i2c_struc=
t
>>>>> *i2c_imx)
>>>>>
>>>>>  	i2c_imx_set_clk(i2c_imx);
>>>>>
>>>>> -	result =3D clk_prepare_enable(i2c_imx->clk);
>>>>> -	if (result)
>>>>> -		return result;
>>>>>  	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
>>>>>  	/* Enable I2C controller */
>>>>>  	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
>>>>> IMX_I2C_I2SR); @@ -575,7 +575,6 @@ static void i2c_imx_stop(struc=
t
>>>> imx_i2c_struct *i2c_imx)
>>>>>  	/* Disable I2C controller */
>>>>>  	temp =3D i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
>>>>>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>>>>> -	clk_disable_unprepare(i2c_imx->clk);
>>>>>  }
>>>>>
>>>>>  static irqreturn_t i2c_imx_isr(int irq, void *dev_id) @@ -894,6
>>>>> +893,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>>>>>
>>>>>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>>>>
>>>>> +	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
>>>>> +	if (result < 0)
>>>>> +		goto out;
>>>>> +
>>>>>  	/* Start I2C transfer */
>>>>>  	result =3D i2c_imx_start(i2c_imx);
>>>>>  	if (result)
>>>>> @@ -950,6 +953,10 @@ fail0:
>>>>>  	/* Stop I2C transfer */
>>>>>  	i2c_imx_stop(i2c_imx);
>>>>>
>>>>> +out:
>>>>> +	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
>>>>> +	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
>>>>> +
>>>>>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __fu=
nc__,
>>>>>  		(result < 0) ? "error" : "success msg",
>>>>>  			(result < 0) ? result : num);
>>>>> @@ -1020,15 +1027,17 @@ static int i2c_imx_probe(struct
>>>>> platform_device *pdev)
>>>>>
>>>>>  	ret =3D clk_prepare_enable(i2c_imx->clk);
>>>>>  	if (ret) {
>>>>> -		dev_err(&pdev->dev, "can't enable I2C clock\n");
>>>>> +		dev_err(&pdev->dev, "can't enable I2C clock, ret=3D%d\n", ret)=
;
>>>>>  		return ret;
>>>>>  	}
>>>>> +
>>>>>  	/* Request IRQ */
>>>>>  	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
>>>>>  				pdev->name, i2c_imx);
>>>>>  	if (ret) {
>>>>>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
>>>>> -		goto clk_disable;
>>>>> +		clk_disable_unprepare(i2c_imx->clk);
>>>>> +		return ret;
>>>>>  	}
>>>>>
>>>>>  	/* Init queue */
>>>>> @@ -1037,6 +1046,18 @@ static int i2c_imx_probe(struct
>>>>> platform_device
>>>> *pdev)
>>>>>  	/* Set up adapter data */
>>>>>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
>>>>>
>>>>> +	/* Set up platform driver data */
>>>>> +	platform_set_drvdata(pdev, i2c_imx);
>>>>> +
>>>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
>>>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>>>> +	pm_runtime_set_active(&pdev->dev);
>>>>> +	pm_runtime_enable(&pdev->dev);
>>>>> +
>>>>> +	ret =3D pm_runtime_get(&pdev->dev);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>>  	/* Set up clock divider */
>>>>>  	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
>>>>>  	ret =3D of_property_read_u32(pdev->dev.of_node,
>>>>> @@ -1053,12 +1074,11 @@ static int i2c_imx_probe(struct
>>>>> platform_device
>>>> *pdev)
>>>>>  	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
>>>>>  	if (ret < 0) {
>>>>>  		dev_err(&pdev->dev, "registration failed\n");
>>>>> -		goto clk_disable;
>>>>> +		goto rpm_disable;
>>>>>  	}
>>>>>
>>>>> -	/* Set up platform driver data */
>>>>> -	platform_set_drvdata(pdev, i2c_imx);
>>>>> -	clk_disable_unprepare(i2c_imx->clk);
>>>>> +	pm_runtime_mark_last_busy(&pdev->dev);
>>>>> +	pm_runtime_put_autosuspend(&pdev->dev);
>>>>>
>>>>>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>>>>>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);=
 @@
>>>>> -1071,14 +1091,20 @@ static int i2c_imx_probe(struct platform_dev=
ice
>>>>> *pdev)
>>>>>
>>>>>  	return 0;   /* Return OK */
>>>>>
>>>>> -clk_disable:
>>>>> -	clk_disable_unprepare(i2c_imx->clk);
>>>>> +rpm_disable:
>>>>> +	pm_runtime_put(&pdev->dev);
>>>>> +	pm_runtime_disable(&pdev->dev);
>>>> The cleanup has to be in reverse order of the setup. Therefore the
>>>> rpm cleanup should happen before the clock disabling.
>>>> As it is now you wouldn't disable the clock when registration fail=
s.
>>>
>>> Thanks. When registration fails, pm_runtime_put is used to cleanup =
the
>> runtime status and disable clk.
>>> Actually, I think pm_runtime_put_sync_suspend is better here.
>> You have another error path where only the clock has to be disabled
>> (getting irq fails) as rpm isn't set up yet. Therefore you can't com=
bine
>> both cleanups.
>> And even despite the fact that suspending and disabling clock techni=
cally
>> is the same using suspend in an error path is not intuitive (as ther=
e's
>> no way to resume).
>>
>>>
>>>
>>>> And better use pm_runtime_put_noidle. You don't want to suspend he=
re
>>>> if the ref count is 0.
>>>>
>>>> Last but not least a call to pm_runtime_set_suspended is missing
>>>> (because after disabling the clock the device effectively is in
>> suspended state).
>>>
>>> The status is set suspended in pm_runtime_put_sync_suspend, so
>> pm_runtime_set_suspended is unnecessary here.
>>> What do you think about it?
>>>
>>> Please see the following code:
>>> rpm_disable:
>>>         pm_runtime_put_sync_suspend(&pdev->dev);
>>>         pm_runtime_disable(&pdev->dev);
>>>         return ret;
>>>
>> See above. Better disable the clock manually and set the state to
>> suspended explicitly.
>>
>>>>>  	return ret;
>>>>>
>=20
> Thanks a lot! How about the following logic?
>=20
> /* Request IRQ */
>         ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
>                                 pdev->name, i2c_imx);
>         if (ret) {
>                 dev_err(&pdev->dev, "can't claim irq %d\n", irq);
>                 goto clk_disable;
>         }
>=20
> ret =3D pm_runtime_get(&pdev->dev);
>         if (ret < 0)
>                 goto rpm_disable;
>=20
> rpm_disable:
>         pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
> clk_disable:
>         clk_disable_unprepare(i2c_imx->clk);
>         return ret;
>=20
To be on the very safe side you could use pm_runtime_get_sync
instead of pm_runtime_get.
Apart from that it looks ok to me now.
>=20
>>>>>
>>>>>  static int i2c_imx_remove(struct platform_device *pdev)  {
>>>>>  	struct imx_i2c_struct *i2c_imx =3D platform_get_drvdata(pdev);
>>>>> +	int ret;
>>>>> +
>>>>> +	ret =3D pm_runtime_get_sync(&pdev->dev);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>>
>>>>>  	/* remove adapter */
>>>>>  	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n"); @@ -1093,1=
7
>>>>> +1119,52 @@ static int i2c_imx_remove(struct platform_device *pde=
v)
>>>>>  	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2CR);
>>>>>  	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2SR);
>>>>>
>>>>> +	pm_runtime_put_sync(&pdev->dev);
>>>>> +	pm_runtime_disable(&pdev->dev);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_PM
>>>>> +static int i2c_imx_runtime_suspend(struct device *dev) {
>>>>> +	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
>>>>> +
>>>>> +	clk_disable_unprepare(i2c_imx->clk);
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> +static int i2c_imx_runtime_resume(struct device *dev) {
>>>>> +	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
>>>>> +	int ret;
>>>>> +
>>>>> +	ret =3D clk_prepare_enable(i2c_imx->clk);
>>>>> +	if (ret)
>>>>> +		dev_err(dev, "can't enable I2C clock, ret=3D%d\n", ret);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops i2c_imx_pm_ops =3D {
>>>>> +	SET_RUNTIME_PM_OPS(i2c_imx_runtime_suspend,
>>>>> +			   i2c_imx_runtime_resume, NULL) }; #define
>> I2C_IMX_PM_OPS
>>>>> +(&i2c_imx_pm_ops) #else #define I2C_IMX_PM_OPS NULL #endif /*
>>>>> +CONFIG_PM */
>>>>> +
>>>>>  static struct platform_driver i2c_imx_driver =3D {
>>>>>  	.probe =3D i2c_imx_probe,
>>>>>  	.remove =3D i2c_imx_remove,
>>>>> -	.driver	=3D {
>>>>> -		.name	=3D DRIVER_NAME,
>>>>> +	.driver =3D {
>>>>> +		.name =3D DRIVER_NAME,
>>>>> +		.pm =3D I2C_IMX_PM_OPS,
>>>>>  		.of_match_table =3D i2c_imx_dt_ids,
>>>>>  	},
>>>>> -	.id_table	=3D imx_i2c_devtype,
>>>>> +	.id_table =3D imx_i2c_devtype,
>>>>>  };
>>>>>
>>>>>  static int __init i2c_adap_imx_init(void)
>>>>>
>>>
>=20
