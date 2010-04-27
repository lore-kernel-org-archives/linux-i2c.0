From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [V2 PATCH 02/10] i2c/of: Allow device node to be passed via
	i2c_board_info
Date: Tue, 27 Apr 2010 12:19:55 -0600
Message-ID: <s2sfa686aa41004271119m4ff1390eh405726d78de86d09@mail.gmail.com>
References: <20100318144836.21082.93040.stgit@angua> <20100318152216.21082.63.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100318152216.21082.63.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben & Jean,

I'm getting patches queued up for linux-next.  Any objections to this
patch or to merging it via the devicetree tree?  This patch is part of
the device tree support rework that consolidates most of the
arch-specific code.

Thanks,
g.

On Thu, Mar 18, 2010 at 9:22 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> The struct device_node *of_node pointer is moving out of dev->archdat=
a
> and into the struct device proper. =A0of_i2c.c needs to set the of_no=
de
> pointer before the device is registered. =A0Since the i2c subsystem
> doesn't allow 2 stage allocation and registration of i2c devices, the
> of_node pointer needs to be passed via the i2c_board_info structure
> so that it is set prior to registration.
>
> This patch adds of_node to struct i2c_board_info (conditional on
> CONFIG_OF), sets of_node in i2c_new_device(), and modifies of_i2c.c
> to use the new parameter. =A0The calling of dev_archdata_set_node()
> from of_i2c will be removed in a subsequent patch when of_node is
> removed from archdata and all users are converted over.
>
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>
> =A0drivers/i2c/i2c-core.c | =A0 =A03 +++
> =A0drivers/of/of_i2c.c =A0 =A0| =A0 =A01 +
> =A0include/linux/i2c.h =A0 =A0| =A0 =A04 ++++
> =A03 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 3202a86..4099b2b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -387,6 +387,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i=
2c_board_info const *info)
> =A0 =A0 =A0 =A0client->dev.parent =3D &client->adapter->dev;
> =A0 =A0 =A0 =A0client->dev.bus =3D &i2c_bus_type;
> =A0 =A0 =A0 =A0client->dev.type =3D &i2c_client_type;
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 client->dev.of_node =3D info->of_node;
> +#endif
>
> =A0 =A0 =A0 =A0dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(a=
dap),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->addr);
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index a3a708e..e690a2a 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -43,6 +43,7 @@ void of_register_i2c_devices(struct i2c_adapter *ad=
ap,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info.addr =3D be32_to_cpup(addr);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_archdata_set_node(&dev_ad, node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.of_node =3D node;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info.archdata =3D &dev_ad;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0request_module("%s", info.type);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 0a5da63..4f37ff1 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -34,6 +34,7 @@
> =A0#include <linux/device.h> =A0 =A0 =A0/* for struct device */
> =A0#include <linux/sched.h> =A0 =A0 =A0 /* for completion */
> =A0#include <linux/mutex.h>
> +#include <linux/of.h> =A0 =A0 =A0 =A0 =A0/* for struct device_node *=
/
>
> =A0extern struct bus_type i2c_bus_type;
>
> @@ -251,6 +252,9 @@ struct i2c_board_info {
> =A0 =A0 =A0 =A0unsigned short =A0addr;
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*platform_data;
> =A0 =A0 =A0 =A0struct dev_archdata =A0 =A0 *archdata;
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 struct device_node *of_node;
> +#endif
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 irq;
> =A0};
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
