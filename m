From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Allow i2c_add_numbered_adapter() to assign a bus id.
Date: Mon, 27 Jun 2011 13:02:45 -0600
Message-ID: <BANLkTi=6zxPUwGZ5JHhRGRHHaEgvNgiaHQ@mail.gmail.com>
References: <20110627185505.19423.64214.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110627185505.19423.64214.stgit@ponder>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <SWarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 27, 2011 at 12:55 PM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> Currently, if an i2c bus driver supports both static and dynamic bus
> ids, it needs to choose between calling i2c_add_numbered_adapter() an=
d
> i2c_add_adapter(). =A0This patch makes i2c_add_numbered_adapter()
> redirect to i2c_add_adapter() if the requested bus id is -1.
>
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Oops, forgot to edit the email before sending the patch.

This patch is as-yet untested other than build testing, but I want to
get feedback.  With the move to DT on ARM, there are going to be a lot
more i2c bus drivers that need to support both static and dynamically
allocated busses, and it is very likely that it will be needed in the
v3.1 merge window.

Ben/Jean, *IF* this patch tests out okay, and *IF* I get an ack from
you, it will probably need to have this commit in my devicetree/next
branch.  If so, then I'll either need to commit it myself, or have it
put into a separate topic branch that both of us can merge into our
trees.  What is your preference.

John: this is the patch that I asked you to write earlier today, but I
think one of the TI folks will run into the same issue, so I wanted to
get it drafted and onto the list ASAP.

g.

> ---
> =A0drivers/i2c/busses/i2c-cpm.c =A0 | =A0 =A07 ++-----
> =A0drivers/i2c/busses/i2c-pxa.c =A0 | =A0 =A07 ++-----
> =A0drivers/i2c/busses/i2c-s6000.c | =A0 =A05 +----
> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A04 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cp=
m.c
> index 3a20961..b1d9cd2 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -662,11 +662,8 @@ static int __devinit cpm_i2c_probe(struct platfo=
rm_device *ofdev)
> =A0 =A0 =A0 =A0/* register new adapter to i2c module... */
>
> =A0 =A0 =A0 =A0data =3D of_get_property(ofdev->dev.of_node, "linux,i2=
c-index", &len);
> - =A0 =A0 =A0 if (data && len =3D=3D 4) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpm->adap.nr =3D *data;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D i2c_add_numbered_adapter(&cp=
m->adap);
> - =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D i2c_add_adapter(&cpm->adap);
> + =A0 =A0 =A0 cpm->adap.nr =3D (data && len =3D=3D 4) ? be32_to_cpup(=
data) : -1;
> + =A0 =A0 =A0 result =3D i2c_add_numbered_adapter(&cpm->adap);
>
> =A0 =A0 =A0 =A0if (result < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "Unable to regist=
er with I2C\n");
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index f59224a..d603646 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1079,7 +1079,7 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
> =A0 =A0 =A0 =A0 * The reason to do so is to avoid sysfs names that on=
ly make
> =A0 =A0 =A0 =A0 * sense when there are multiple adapters.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 i2c->adap.nr =3D dev->id !=3D -1 ? dev->id : 0;
> + =A0 =A0 =A0 i2c->adap.nr =3D dev->id;
> =A0 =A0 =A0 =A0snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_=
i2c-i2c.%u",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->adap.nr);
>
> @@ -1142,10 +1142,7 @@ static int i2c_pxa_probe(struct platform_devic=
e *dev)
> =A0 =A0 =A0 =A0i2c->adap.dev.of_node =3D dev->dev.of_node;
> =A0#endif
>
> - =A0 =A0 =A0 if (i2c_type =3D=3D REGS_CE4100)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_add_adapter(&i2c->adap);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_add_numbered_adapter(&i2c->=
adap);
> + =A0 =A0 =A0 ret =3D i2c_add_numbered_adapter(&i2c->adap);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "I2C: Failed to add b=
us\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto eadapt;
> diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-=
s6000.c
> index cb5d01e..c64ba73 100644
> --- a/drivers/i2c/busses/i2c-s6000.c
> +++ b/drivers/i2c/busses/i2c-s6000.c
> @@ -341,10 +341,7 @@ static int __devinit s6i2c_probe(struct platform=
_device *dev)
> =A0 =A0 =A0 =A0i2c_wr16(iface, S6_I2C_TXTL, 0);
>
> =A0 =A0 =A0 =A0platform_set_drvdata(dev, iface);
> - =A0 =A0 =A0 if (bus_num < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D i2c_add_adapter(p_adap);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D i2c_add_numbered_adapter(p_adap)=
;
> + =A0 =A0 =A0 rc =3D i2c_add_numbered_adapter(p_adap);
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq_free;
> =A0 =A0 =A0 =A0return 0;
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 9a58994..131079a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -925,6 +925,9 @@ EXPORT_SYMBOL(i2c_add_adapter);
> =A0* or otherwise built in to the system's mainboard, and where i2c_b=
oard_info
> =A0* is used to properly configure I2C devices.
> =A0*
> + * If the requested bus number is set to -1, then this function will=
 behave
> + * identically to i2c_add_adapter, and will dynamically assign a bus=
 number.
> + *
> =A0* If no devices have pre-been declared for this bus, then be sure =
to
> =A0* register the adapter before any dynamically allocated ones. =A0O=
therwise
> =A0* the required bus ID may not be available.
> @@ -940,6 +943,8 @@ int i2c_add_numbered_adapter(struct i2c_adapter *=
adap)
> =A0 =A0 =A0 =A0int =A0 =A0 id;
> =A0 =A0 =A0 =A0int =A0 =A0 status;
>
> + =A0 =A0 =A0 if (adap->nr =3D=3D -1) /* -1 means dynamically assign =
bus id */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i2c_add_adapter(adap);
> =A0 =A0 =A0 =A0if (adap->nr & ~MAX_ID_MASK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
