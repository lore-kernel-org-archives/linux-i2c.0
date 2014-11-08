From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create "channel-n" symlinks for child segments
Date: Fri, 7 Nov 2014 23:47:37 -0800
Message-ID: <CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ@mail.gmail.com>
References: <1415363764-10821-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415363764-10821-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Just tested it and it work well for me. lsi2c (a tool I have been
developing) was complacently unaffected, I will be releasing it as an
open source app soon.

Thanks.

[root@linux 32-0071]# ll
total 0
lrwxrwxrwx 1 admin root    0 Nov  7 23:30 bus -> ../../../../../../../bus/i2c
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-0 -> ../i2c-33
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-1 -> ../i2c-34
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-2 -> ../i2c-35
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-3 -> ../i2c-36
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-4 -> ../i2c-37
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-5 -> ../i2c-38
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-6 -> ../i2c-39
lrwxrwxrwx 1 admin root    0 Nov  7 23:41 channel-7 -> ../i2c-40
lrwxrwxrwx 1 admin root    0 Nov  7 23:30 driver ->
../../../../../../../bus/i2c/drivers/pca954x
-r--r--r-- 1 admin root 4096 Nov  7 23:41 modalias
-r--r--r-- 1 admin root 4096 Nov  7 23:30 name
lrwxrwxrwx 1 admin root    0 Nov  7 23:30 subsystem ->
../../../../../../../bus/i2c
-rw-r--r-- 1 admin root 4096 Nov  7 23:41 uevent

[root@linux ~]# lsi2c
I2C Adapters:
bus: i2c-0 path: 0               type: i2c name: MPC adapter at 0xffe03000
bus: i2c-2 path: 0:0.0           type: mux name: i2c-0-mux (chan_id 0)
bus: i2c-3 path: 0:0.1           type: mux name: i2c-0-mux (chan_id 1)
bus: i2c-4 path: 0:0.2           type: mux name: i2c-0-mux (chan_id 2)
bus: i2c-5 path: 0:0.3           type: mux name: i2c-0-mux (chan_id 3)
bus: i2c-6 path: 0:0.4           type: mux name: i2c-0-mux (chan_id 4)
bus: i2c-7 path: 0:0.5           type: mux name: i2c-0-mux (chan_id 5)
bus: i2c-8 path: 0:0.6           type: mux name: i2c-0-mux (chan_id 6)
bus: i2c-9 path: 0:0.7           type: mux name: i2c-0-mux (chan_id 7)
bus: i2c-1 path: 1               type: i2c name: MPC adapter at 0xffe03100
bus: i2c-10 path: 1:0.0           type: mux name: i2c-1-mux (chan_id 0)
bus: i2c-11 path: 1:0.1           type: mux name: i2c-1-mux (chan_id 1)
bus: i2c-18 path: 1:0.1:0.0       type: mux name: i2c-11-mux (chan_id 0)
bus: i2c-12 path: 1:0.2           type: mux name: i2c-1-mux (chan_id 2)
bus: i2c-32 path: 1:0.2:0.0       type: mux name: i2c-12-mux (chan_id 0)
bus: i2c-33 path: 1:0.2:0.0:0.0   type: mux name: i2c-32-mux (chan_id 0)
bus: i2c-34 path: 1:0.2:0.0:0.1   type: mux name: i2c-32-mux (chan_id 1)
bus: i2c-35 path: 1:0.2:0.0:0.2   type: mux name: i2c-32-mux (chan_id 2)
bus: i2c-36 path: 1:0.2:0.0:0.3   type: mux name: i2c-32-mux (chan_id 3)
bus: i2c-37 path: 1:0.2:0.0:0.4   type: mux name: i2c-32-mux (chan_id 4)
bus: i2c-38 path: 1:0.2:0.0:0.5   type: mux name: i2c-32-mux (chan_id 5)
bus: i2c-39 path: 1:0.2:0.0:0.6   type: mux name: i2c-32-mux (chan_id 6)
bus: i2c-40 path: 1:0.2:0.0:0.7   type: mux name: i2c-32-mux (chan_id 7)
bus: i2c-13 path: 1:0.3           type: mux name: i2c-1-mux (chan_id 3)
bus: i2c-23 path: 1:0.3:0.0       type: mux name: i2c-13-mux (chan_id 0)
bus: i2c-24 path: 1:0.3:0.0:0.0   type: mux name: i2c-23-mux (chan_id 0)
bus: i2c-25 path: 1:0.3:0.0:0.1   type: mux name: i2c-23-mux (chan_id 1)
bus: i2c-26 path: 1:0.3:0.0:0.2   type: mux name: i2c-23-mux (chan_id 2)
bus: i2c-27 path: 1:0.3:0.0:0.3   type: mux name: i2c-23-mux (chan_id 3)
bus: i2c-28 path: 1:0.3:0.0:0.4   type: mux name: i2c-23-mux (chan_id 4)
bus: i2c-29 path: 1:0.3:0.0:0.5   type: mux name: i2c-23-mux (chan_id 5)
bus: i2c-30 path: 1:0.3:0.0:0.6   type: mux name: i2c-23-mux (chan_id 6)
bus: i2c-31 path: 1:0.3:0.0:0.7   type: mux name: i2c-23-mux (chan_id 7)
bus: i2c-14 path: 1:0.4           type: mux name: i2c-1-mux (chan_id 4)
bus: i2c-19 path: 1:0.4:0.0       type: mux name: i2c-14-mux (chan_id 0)
bus: i2c-15 path: 1:0.5           type: mux name: i2c-1-mux (chan_id 5)
bus: i2c-20 path: 1:0.5:0.0       type: mux name: i2c-15-mux (chan_id 0)
bus: i2c-16 path: 1:0.6           type: mux name: i2c-1-mux (chan_id 6)
bus: i2c-21 path: 1:0.6:0.0       type: mux name: i2c-16-mux (chan_id 0)
bus: i2c-17 path: 1:0.7           type: mux name: i2c-1-mux (chan_id 7)
bus: i2c-22 path: 1:0.7:0.0       type: mux name: i2c-17-mux (chan_id 0)
Count: 30

[root@linux ]# lsi2c -d
I2C Devices:
bus=0 type=i2c bus_path=0               address=0x70 name=pca9548
   driver=pca954x
bus=6 type=mux bus_path=0:0.4           address=0x68 name=ds1339
  driver=rtc-ds1307
bus=1 type=i2c bus_path=1               address=0x74 name=pca9548
   driver=pca954x
bus=11 type=mux bus_path=1:0.1           address=0x73 name=pca9541
    driver=pca9541
bus=12 type=mux bus_path=1:0.2           address=0x7e name=pca9541
    driver=pca9541
bus=32 type=mux bus_path=1:0.2:0.0       address=0x71 name=pca9547
    driver=pca954x
bus=13 type=mux bus_path=1:0.3           address=0x7e name=pca9541
    driver=pca9541
bus=23 type=mux bus_path=1:0.3:0.0       address=0x71 name=pca9547
    driver=pca954x
bus=14 type=mux bus_path=1:0.4           address=0x73 name=pca9541
    driver=pca9541
bus=15 type=mux bus_path=1:0.5           address=0x73 name=pca9541
    driver=pca9541
bus=16 type=mux bus_path=1:0.6           address=0x73 name=pca9541
    driver=pca9541
bus=17 type=mux bus_path=1:0.7           address=0x73 name=pca9541
    driver=pca9541
Count: 12




On Fri, Nov 7, 2014 at 4:36 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>
> This makes the topology clearer. For instance, by adding a pca9547
> device with address 0x70 to bus i2c-0, you get:
>
> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-0 -> i2c-1
> ...
> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-7 -> i2c-8
>
> Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> [wsa: simplified sysfs-usage and fixed format string usage]
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> ---
>
> This should also make it easier for applications to handle the topology of
> muxes without breaking anything. Please give opinions if it really helps. I
> don't use muxes myself.
>
>  drivers/i2c/i2c-mux.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index d05208232b07..f43273a92069 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -110,6 +110,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>                                                  void *, u32))
>  {
>         struct i2c_mux_priv *priv;
> +       char symlink_name[20];
>         int ret;
>
>         priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
> @@ -189,6 +190,9 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>                                         dev_name(&priv->adap.dev)),
>                                         "can't create compatibility link for old mux name scheme\n");
>
> +       snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
> +       WARN(sysfs_create_link(&mux_dev->kobj, &priv->adap.dev.kobj, symlink_name),
> +                               "can't create symlink for channel\n");
>         dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
>                  i2c_adapter_id(&priv->adap));
>
> @@ -199,6 +203,10 @@ EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
>  void i2c_del_mux_adapter(struct i2c_adapter *adap)
>  {
>         struct i2c_mux_priv *priv = adap->algo_data;
> +       char symlink_name[20];
> +
> +       snprintf(symlink_name, sizeof(symlink_name), "channel-%u", priv->chan_id);
> +       sysfs_remove_link(&adap->dev.parent->kobj, symlink_name);
>
>         if (adap->dev.parent != &priv->parent->dev)
>                 sysfs_remove_link(&priv->parent->dev.kobj, dev_name(&adap->dev));
> --
> 2.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
- Danielle Costantino
