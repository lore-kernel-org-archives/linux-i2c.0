From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ocores: Adapt for device tree
Date: Wed, 24 Nov 2010 08:22:17 -0700
Message-ID: <AANLkTi=edjyG91KCHXq9fKJZL0nAzx-z8yLopbyiU6CY@mail.gmail.com>
References: <1290607789-8996-1-git-send-email-jonas@southpole.se>
	<1290607789-8996-2-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1290607789-8996-2-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 24, 2010 at 7:09 AM, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org> wrote:
> This patch adapts the i2c-ocores driver for being defined and configured =
via
> a device tree description.
>
> The device tree bits need to be protected by CONFIG_OF guards as this is
> still an optional feature.
>
> Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-ocores.c | =A0 63 +++++++++++++++++++++++++++++=
+++++-----
> =A01 files changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index 0070371..86a536c 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -210,6 +210,31 @@ static struct i2c_adapter ocores_adapter =3D {
> =A0 =A0 =A0 =A0.algo =A0 =A0 =A0 =A0 =A0 =3D &ocores_algorithm,
> =A0};
>
> +#ifdef CONFIG_OF
> +static int ocores_i2c_of_probe(struct platform_device* pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ocor=
es_i2c* i2c)
> +{
> + =A0 =A0 =A0 int* val;

__be32 *val;

> +
> + =A0 =A0 =A0 val =3D (int*) of_get_property(pdev->dev.of_node, "regstep"=
, NULL);

of_get_property returns a void*.  Drop the unnecessary cast.

> + =A0 =A0 =A0 if (!val) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Missing required param=
ter 'regstep'");

spelling: parameter

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c->regstep =3D *val;

i2c->regstep =3D be32_to_cpup(val);

> + =A0 =A0 =A0 val =3D (int*) of_get_property(pdev->dev.of_node, "clock_kh=
z", NULL);

Drop the cast.  It is also considered bad form to use '_' in property
names.  Use '-' instead.  Traditionally, clock frequencies are
specified in Hz (not kHz), and the property name is something like
'bus-frequency' or 'clock-frequency'.

> + =A0 =A0 =A0 if (!val) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Missing required param=
ter 'clock_khz'");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 i2c->clock_khz =3D *val;

i2c->clock_khz =3D be32_to_cpup(val);

> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
> +#endif
>
> =A0static int __devinit ocores_i2c_probe(struct platform_device *pdev)
> =A0{
> @@ -227,10 +252,6 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0if (!res2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 pdata =3D (struct ocores_i2c_platform_data*) pdev->dev.plat=
form_data;
> - =A0 =A0 =A0 if (!pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> @@ -249,8 +270,16 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto map_failed;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 i2c->regstep =3D pdata->regstep;
> - =A0 =A0 =A0 i2c->clock_khz =3D pdata->clock_khz;
> + =A0 =A0 =A0 pdata =3D (struct ocores_i2c_platform_data*) pdev->dev.plat=
form_data;

Drop the unnecessary cast

> + =A0 =A0 =A0 if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regstep =3D pdata->regstep;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->clock_khz =3D pdata->clock_khz;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ocores_i2c_of_probe(pdev, i2c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ocores_init(i2c);
>
> =A0 =A0 =A0 =A0init_waitqueue_head(&i2c->wait);
> @@ -265,6 +294,9 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0i2c->adap =3D ocores_adapter;
> =A0 =A0 =A0 =A0i2c_set_adapdata(&i2c->adap, i2c);
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &pdev->dev;
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 i2c->adap.dev.of_node =3D pdev->dev.of_node;
> +#endif
>
> =A0 =A0 =A0 =A0/* add i2c adapter to i2c tree */
> =A0 =A0 =A0 =A0ret =3D i2c_add_adapter(&i2c->adap);
> @@ -274,8 +306,10 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* add in known devices to the bus */
> - =A0 =A0 =A0 for (i =3D 0; i < pdata->num_devices; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, pdata->devices +=
 i);
> + =A0 =A0 =A0 if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_devices; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, =
pdata->devices + i);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -344,6 +378,16 @@ static int ocores_i2c_resume(struct platform_device =
*pdev)
> =A0#define ocores_i2c_resume =A0 =A0 =A0NULL
> =A0#endif
>
> +#ifdef CONFIG_OF
> +static struct of_device_id ocores_i2c_match[] =3D {
> + =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.compatible =3D "opencores,i2c-ocores",

Is this binding documented somewhere?  If not, you can use devicetree.org

> + =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 =A0{},
> +};
> +MODULE_DEVICE_TABLE(of, ocores_i2c_match);
> +#endif
> +
> =A0/* work with hotplug and coldplug */
> =A0MODULE_ALIAS("platform:ocores-i2c");
>
> @@ -355,6 +399,9 @@ static struct platform_driver ocores_i2c_driver =3D {
> =A0 =A0 =A0 =A0.driver =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "ocores-i2c",
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D ocores_i2c_match,
> +#endif
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.7.1
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
