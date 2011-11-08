From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Tue, 8 Nov 2011 11:43:28 +0800
Message-ID: <CAGsJ_4w2zeMQXc_nqZV1FWTXWMa_HM6Q1DdR-PmaR1O57eUcRQ@mail.gmail.com>
References: <1320228610-18129-1-git-send-email-Barry.Song@csr.com>
 <20111102103904.GB4937@totoro> <20111102105210.GZ19187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111102105210.GZ19187-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
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

done for this as well.

diff --git a/drivers/i2c/busses/i2c-sirfsoc.c b/drivers/i2c/busses/i2c-=
sirfsoc.c
index 9c11458..cf4f61f 100644
--- a/drivers/i2c/busses/i2c-sirfsoc.c
+++ b/drivers/i2c/busses/i2c-sirfsoc.c
@@ -244,17 +244,27 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)
 	if (pdata =3D=3D NULL) {
 		err =3D -ENODEV;
 		dev_err(&pdev->dev, "No platform data!\n");
-		goto out;
+		goto err_pdata;
 	}

 	clk =3D clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		err =3D PTR_ERR(clk);
 		dev_err(&pdev->dev, "Clock get failed\n");
-		goto out;
+		goto err_get_clk;
 	}

-	clk_enable(clk);
+	err =3D clk_prepare(clk);
+	if (err) {
+		dev_err(&pdev->dev, "Clock prepare failed\n");
+		goto  err_clk_prep;
+	}
+
+	err =3D clk_enable(clk);
+	if (err) {
+		dev_err(&pdev->dev, "Clock enable failed\n");
+		goto  err_clk_en;
+	}

 	ctrl_speed =3D clk_get_rate(clk);

@@ -263,14 +273,14 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't allocate new i2c adapter!\n");
 		err =3D -ENOMEM;
-		goto clk_out;
+		goto out;
 	}

 	siic =3D devm_kzalloc(&pdev->dev, sizeof(*siic), GFP_KERNEL);
 	if (!siic) {
 		dev_err(&pdev->dev, "Can't allocate driver data\n");
 		err =3D -ENOMEM;
-		goto clk_out;
+		goto out;
 	}
 	new_adapter->class =3D I2C_CLASS_HWMON | I2C_CLASS_DDC | I2C_CLASS_SP=
D;
 	siic->adapter =3D new_adapter;
@@ -279,7 +289,7 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)
 	if (mem_res =3D=3D NULL) {
 		dev_err(&pdev->dev, "Unable to get MEM resource\n");
 		err =3D -EINVAL;
-		goto clk_out;
+		goto out;
 	}

 	siic->base =3D
@@ -287,18 +297,18 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)
 	if (siic->base =3D=3D NULL) {
 		dev_err(&pdev->dev, "IO remap failed!\n");
 		err =3D -ENOMEM;
-		goto clk_out;
+		goto out;
 	}

 	siic->irq =3D platform_get_irq(pdev, 0);
 	if (!siic->irq) {
 		err =3D -EINVAL;
-		goto clk_out;
+		goto out;
 	}
 	err =3D devm_request_irq(&pdev->dev, siic->irq, i2c_sirfsoc_irq, 0,
 		dev_name(&pdev->dev), siic);
 	if (err)
-		goto clk_out;
+		goto out;

 	new_adapter->algo =3D &i2c_sirfsoc_algo;
 	new_adapter->algo_data =3D siic;
@@ -338,7 +348,7 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)
 	err =3D i2c_add_numbered_adapter(new_adapter);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Can't add new i2c adapter\n");
-		goto clk_out;
+		goto out;
 	}

 	clk_disable(clk);
@@ -347,10 +357,14 @@ static int __devinit i2c_sirfsoc_probe(struct
platform_device *pdev)

 	return 0;

-clk_out:
+out:
 	clk_disable(clk);
+err_clk_en:
+	clk_unprepare(clk);
+err_clk_prep:
 	clk_put(clk);
-out:
+err_get_clk:
+err_pdata:
 	return err;
 }

@@ -362,6 +376,7 @@ static int __devexit i2c_sirfsoc_remove(struct
platform_device *pdev)
 	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
 	i2c_del_adapter(adapter);
 	clk_disable(siic->clk);
+	clk_unprepare(siic->clk);
 	clk_put(siic->clk);
 	return 0;
 }


> And one may query why it's not possible to use clk_enable()...clk_dis=
able()
> around the transfer itself, so the clock can be turned off while the =
device
> is idle. =C2=A0Obviously if its expecting to be operated in slave mod=
e as well
> then you may need to keep the clock enabled.
