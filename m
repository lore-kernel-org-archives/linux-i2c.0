From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
	non-negative cell_count
Date: Tue, 17 Sep 2019 14:25:30 +0200
Message-ID: <20190917122530.3xy7sut3xdvzlomj@pengutronix.de>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
	<20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
	<20190913215809.GA11833@bogus>
	<CAMuHMdV+pwoAA0zH_vQf2nKqzrgHP8rcMStyJbnuu2qviFC_qg@mail.gmail.com>
	<20190917101303.t5otztdus7y3ayau@pengutronix.de>
	<489c90fb-a135-4fd8-ecb9-46404bd3c234@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <489c90fb-a135-4fd8-ecb9-46404bd3c234-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 17, 2019 at 11:25:46AM +0000, Peter Rosin wrote:
> On 2019-09-17 12:13, Uwe Kleine-K=F6nig wrote:
> > Hello Geert,
> > =

> > On Tue, Sep 17, 2019 at 11:40:25AM +0200, Geert Uytterhoeven wrote:
> >> Hi Rob, Uwe,
> >>
> >> On Fri, Sep 13, 2019 at 11:58 PM Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >>> On Sat, 24 Aug 2019 15:28:46 +0200, =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=
=3DB6nig?=3D          wrote:
> >>>> Referencing device tree nodes from a property allows to pass argumen=
ts.
> >>>> This is for example used for referencing gpios. This looks as follow=
s:
> >>>>
> >>>>       gpio_ctrl: gpio-controller {
> >>>>               #gpio-cells =3D <2>
> >>>>               ...
> >>>>       }
> >>>>
> >>>>       someothernode {
> >>>>               gpios =3D <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
> >>>>               ...
> >>>>       }
> >>>>
> >>>> To know the number of arguments this must be either fixed, or the
> >>>> referenced node is checked for a $cells_name (here: "#gpio-cells")
> >>>> property and with this information the start of the second reference=
 can
> >>>> be determined.
> >>>>
> >>>> Currently regulators are referenced with no additional arguments. To
> >>>> allow some optional arguments without having to change all referenced
> >>>> nodes this change introduces a way to specify a default cell_count. =
So
> >>>> when a phandle is parsed we check for the $cells_name property and u=
se
> >>>> it as before if present. If it is not present we fall back to
> >>>> cells_count if non-negative and only fail if cells_count is smaller =
than
> >>>> zero.
> >>>>
> >>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >>
> >> This is now commit e42ee61017f58cd9 ("of: Let of_for_each_phandle fall=
back
> >> to non-negative cell_count") in robh/for-next, which causes a lock-up =
when
> >> booting a shmobile_defconfig kernel on r8a7791/koelsch:
> >>
> >> rcu: INFO: rcu_sched self-detected stall on CPU
> >> rcu:     0-....: (2099 ticks this GP) idle=3D6fe/1/0x40000002
> >> softirq=3D29/29 fqs=3D1050
> >>  (t=3D2100 jiffies g=3D-1131 q=3D0)
> >> NMI backtrace for cpu 0
> >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> >> 5.3.0-rc2-shmobile-00050-ge42ee61017f58cd9 #376
> >> Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> >> [<c010f8ac>] (unwind_backtrace) from [<c010b620>] (show_stack+0x10/0x1=
4)
> >> [<c010b620>] (show_stack) from [<c073d038>] (dump_stack+0x7c/0x9c)
> >> [<c073d038>] (dump_stack) from [<c0742e80>] (nmi_cpu_backtrace+0xa0/0x=
b8)
> >> [<c0742e80>] (nmi_cpu_backtrace) from [<c0742f1c>] (nmi_trigger_cpumas=
k_backtrace+0x84/0x114)
> >> [<c0742f1c>] (nmi_trigger_cpumask_backtrace) from [<c017d684>] (rcu_du=
mp_cpu_stacks+0xac/0xc8)
> >> [<c017d684>] (rcu_dump_cpu_stacks) from [<c017a598>] (rcu_sched_clock_=
irq+0x2ac/0x6b4)
> >> [<c017a598>] (rcu_sched_clock_irq) from [<c0183980>] (update_process_t=
imes+0x30/0x5c)
> >> [<c0183980>] (update_process_times) from [<c01941a8>] (tick_nohz_handl=
er+0xcc/0x120)
> >> [<c01941a8>] (tick_nohz_handler) from [<c05b1d40>] (arch_timer_handler=
_virt+0x28/0x30)
> >> [<c05b1d40>] (arch_timer_handler_virt) from [<c016c9e0>] (handle_percp=
u_devid_irq+0xe8/0x21c)
> >> [<c016c9e0>] (handle_percpu_devid_irq) from [<c0167a8c>] (generic_hand=
le_irq+0x18/0x28)
> >> [<c0167a8c>] (generic_handle_irq) from [<c0167b3c>] (__handle_domain_i=
rq+0xa0/0xb4)
> >> [<c0167b3c>] (__handle_domain_irq) from [<c03673ec>] (gic_handle_irq+0=
x58/0x90)
> >> [<c03673ec>] (gic_handle_irq) from [<c0101a8c>] (__irq_svc+0x6c/0x90)
> >> Exception stack(0xeb08dd30 to 0xeb08dd78)
> >> dd20:                                     c0cc7514 20000013 00000005 0=
0003b27
> >> dd40: eb7c4020 c0cc750c 00000051 00000051 20000013 c0c66b08 eb1cdc00 0=
0000018
> >> dd60: 00000000 eb08dd80 c05c1a38 c0756c00 20000013 ffffffff
> >> [<c0101a8c>] (__irq_svc) from [<c0756c00>] (_raw_spin_unlock_irqrestor=
e+0x1c/0x20)
> >> [<c0756c00>] (_raw_spin_unlock_irqrestore) from [<c05c1a38>] (of_find_=
node_by_phandle+0xcc/0xf0)
> >> [<c05c1a38>] (of_find_node_by_phandle) from [<c05c1bb8>] (of_phandle_i=
terator_next+0x68/0x178)
> >> [<c05c1bb8>] (of_phandle_iterator_next) from [<c05c22bc>] (of_count_ph=
andle_with_args+0x5c/0x7c)
> >> [<c05c22bc>] (of_count_phandle_with_args) from [<c053fc38>] (i2c_demux=
_pinctrl_probe+0x24/0x1fc)
> >> [<c053fc38>] (i2c_demux_pinctrl_probe) from [<c04463c4>] (platform_drv=
_probe+0x48/0x94)
> >> [<c04463c4>] (platform_drv_probe) from [<c0444a20>] (really_probe+0x1f=
0/0x2b8)
> >> [<c0444a20>] (really_probe) from [<c0444e68>] (driver_probe_device+0x1=
40/0x158)
> >> [<c0444e68>] (driver_probe_device) from [<c0444ff0>] (device_driver_at=
tach+0x44/0x5c)
> >> [<c0444ff0>] (device_driver_attach) from [<c04450b4>] (__driver_attach=
+0xac/0xb4)
> >> [<c04450b4>] (__driver_attach) from [<c0443178>] (bus_for_each_dev+0x6=
4/0xa0)
> >> [<c0443178>] (bus_for_each_dev) from [<c04438a8>] (bus_add_driver+0x14=
8/0x1a8)
> >> [<c04438a8>] (bus_add_driver) from [<c0445ad0>] (driver_register+0xac/=
0xf0)
> >> [<c0445ad0>] (driver_register) from [<c0b010b0>] (do_one_initcall+0xa8=
/0x1d4)
> >> [<c0b010b0>] (do_one_initcall) from [<c0b01448>] (kernel_init_freeable=
+0x26c/0x2c8)
> >> [<c0b01448>] (kernel_init_freeable) from [<c0751c70>] (kernel_init+0x8=
/0x10c)
> >> [<c0751c70>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> >> Exception stack(0xeb08dfb0 to 0xeb08dff8)
> >> dfa0:                                     00000000 00000000 00000000 0=
0000000
> >> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0=
0000000
> >> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >>
> >> Presumably it loops forever, due to a conversion of -1 to unsigned
> >> somewhere?
> > =

> > Hmm, I fail to see the culprit. i2c_demux_pinctrl_probe calls
> > of_count_phandle_with_args with cells_name=3DNULL. With that I don't see
> > how my patch changes anything as the only change is in an if
> > (it->cells_name) block that shouldn't be relevant in your case.
> > =

> > Can you please verify that the loop in of_count_phandle_with_args is
> > indeed not terminating, e.g. with
> =

> The below indicated else-branch was not touched by e42ee61017f58cd9,
> which ends up setting the count to -1 (aka 0xff...ff in this case).
> No?
> =

> int of_phandle_iterator_next(struct of_phandle_iterator *it)
> {
> =

> 	...
> =

> 		if (it->cells_name) {
> =

> 			...
> =

> 		} else {
> 			count =3D it->cell_count;    /* <---- SUSPECT!!! */
> 		}

Oh yeah, you're right. I'm a bit disappointed that I didn't spot this
myself :-|

Untested patch to fix this problem:

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 2f25d2dfecfa..26f7a21d7187 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1284,6 +1284,13 @@ int of_phandle_iterator_init(struct of_phandle_itera=
tor *it,
 	const __be32 *list;
 	int size;
 =

+	/*
+	 * one of cell_count or cells_name must be provided to determine the
+	 * argument length.
+	 */
+	if (cell_count < 0 && !cells_name)
+		return -EINVAL;
+
 	memset(it, 0, sizeof(*it));
 =

 	list =3D of_get_property(np, list_name, &size);
@@ -1765,6 +1772,18 @@ int of_count_phandle_with_args(const struct device_n=
ode *np, const char *list_na
 	struct of_phandle_iterator it;
 	int rc, cur_index =3D 0;
 =

+	/* If cells_name is NULL we assume an cell_count of 0 */
+	if (cells_name =3D=3D NULL) {
+		const __be32 *list;
+		int size;
+
+		list =3D of_get_property(np, list_name, &size);
+		if (!list)
+			return -ENOENT;
+
+		return size / sizeof(*list);
+	}
+
 	rc =3D of_phandle_iterator_init(&it, np, list_name, cells_name, -1);
 	if (rc)
 		return rc;

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
