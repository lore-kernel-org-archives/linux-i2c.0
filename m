From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using algo-bit in another i2c algo
Date: Wed, 10 Mar 2010 14:16:18 -0500
Message-ID: <a728f9f91003101116l422374d2vceb1e5dddfdf44d8@mail.gmail.com>
References: <a728f9f91001111413t1a733e0rbc0352ddd2d9de7c@mail.gmail.com>
	 <20100310104401.57fc43b2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100310104401.57fc43b2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 10, 2010 at 4:44 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Alex,
>
> Sorry for the late answer.
>
> On Mon, 11 Jan 2010 17:13:50 -0500, Alex Deucher wrote:
>> Hi,
>>
>> =A0 =A0 I'm adding support for the i2c controllers on radeon hardwar=
e and
>> I have a few questions. =A0I have a radeon-algo that encapsulates al=
l
>> the various hw i2c controller functionality, however, it uses a
>> bit-algo bus internally for cases where you have to use bit-banging
>> rather than the hardware i2c engines. =A0Also, for bit banging to wo=
rk
>> properly, you need to do some things before the bit-algo transaction
>> (basically masking the gpios for software use).
>
> There used to be a patch floating around that added pre- and post-xfe=
r
> hooks to i2c-algo-bit... I couldn't find it again, so I rewrote it:
>
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: i2c-algo-bit: Add pre- and post-xfer hooks
>
> Drivers might have to do random things before and/or after I2C
> transfers. Add hooks to the i2c-algo-bit implementation to let them d=
o
> so.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A09 +++++++++
> =A0include/linux/i2c-algo-bit.h =A0 =A0 | =A0 =A02 ++
> =A02 files changed, 11 insertions(+)
>
> --- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 =A0=
2009-06-10 05:05:27.000000000 +0200
> +++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c =A0 2010-03-09 =
18:52:50.000000000 +0100
> @@ -522,6 +522,12 @@ static int bit_xfer(struct i2c_adapter *
> =A0 =A0 =A0 =A0int i, ret;
> =A0 =A0 =A0 =A0unsigned short nak_ok;
>
> + =A0 =A0 =A0 if (adap->pre_xfer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D adap->pre_xfer(i2c_adap, adap->=
data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0bit_dbg(3, &i2c_adap->dev, "emitting start condition\n=
");
> =A0 =A0 =A0 =A0i2c_start(adap);
> =A0 =A0 =A0 =A0for (i =3D 0; i < num; i++) {
> @@ -570,6 +576,9 @@ static int bit_xfer(struct i2c_adapter *
> =A0bailout:
> =A0 =A0 =A0 =A0bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n"=
);
> =A0 =A0 =A0 =A0i2c_stop(adap);
> +
> + =A0 =A0 =A0 if (adap->post_xfer)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adap->post_xfer(i2c_adap, adap->data);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> --- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h =A02009-06-10 =
05:05:27.000000000 +0200
> +++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h =A0 =A0 =A0 2010-03=
-09 18:53:06.000000000 +0100
> @@ -32,6 +32,8 @@
> =A0*/
> =A0struct i2c_algo_bit_data {
> =A0 =A0 =A0 =A0void *data; =A0 =A0 =A0 =A0 =A0 =A0 /* private data fo=
r lowlevel routines */
> + =A0 =A0 =A0 int =A0(*pre_xfer) =A0(struct i2c_adapter *i2c_adap, vo=
id *data);
> + =A0 =A0 =A0 void (*post_xfer) (struct i2c_adapter *i2c_adap, void *=
data);
> =A0 =A0 =A0 =A0void (*setsda) (void *data, int state);
> =A0 =A0 =A0 =A0void (*setscl) (void *data, int state);
> =A0 =A0 =A0 =A0int =A0(*getsda) (void *data);
>
> Would it help?
>
>> Right now we use
>> bit-algo i2c for the ddc buses, but they won't work externally to th=
e
>> driver without the proper gpio masking prior to using them. =A0In th=
e
>> radeon-algo patches, I use bit algo internally when I cannot use the
>> hardware i2c engines, or in cases where I haven't implemented suppor=
t
>> yet for the hardware engine (as most gpios can be driven by sw or th=
e
>> hw engine). =A0The problem is, this exposes the i2c bit-algo buses a=
s
>> well as the radeon-algo buses.
>
> This is bad, as it defeats the slave address uniqueness mechanism. Ba=
d
> things could happen. Would the patch above be sufficient to solve you=
r
> case?
>
>> Is there a way to not expose the bit-algo buses that are used
>> internally?
>
> No, this is not possible at the time being. That being said, it
> shouldn't be difficult, if the need exists. Looking at i2c-algo-bit,
> the registration part is split into a preparation step and the actual
> registration with i2c-core. The preparation step if done by
> i2c_bit_prepare_bus(). If we exported this function, then you could
> easily call it to create an internal i2c-algo-bit-based adapter, whic=
h
> you wouldn't have to register if you don't want to:
>
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: i2c-algo-bit: Export i2c_bit_prepare_bus
>
> This lets drivers make use of the i2c-algo-bit implementation without
> actually registering the i2c adapter in question. This is useful to
> drivers which need more than the i2c-algo-bit driver offers.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A03 ++-
> =A0include/linux/i2c-algo-bit.h =A0 =A0 | =A0 =A01 +
> =A02 files changed, 3 insertions(+), 1 deletion(-)
>
> --- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 =A0=
2010-03-10 08:09:03.000000000 +0100
> +++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c =A0 2010-03-10 =
10:23:51.000000000 +0100
> @@ -601,7 +601,7 @@ static const struct i2c_algorithm i2c_bi
> =A0/*
> =A0* registering functions to load algorithms at runtime
> =A0*/
> -static int i2c_bit_prepare_bus(struct i2c_adapter *adap)
> +int i2c_bit_prepare_bus(struct i2c_adapter *adap)
> =A0{
> =A0 =A0 =A0 =A0struct i2c_algo_bit_data *bit_adap =3D adap->algo_data=
;
>
> @@ -617,6 +617,7 @@ static int i2c_bit_prepare_bus(struct i2
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +EXPORT_SYMBOL(i2c_bit_prepare_bus);
>
> =A0int i2c_bit_add_bus(struct i2c_adapter *adap)
> =A0{
> --- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h =A02010-03-10 =
08:09:03.000000000 +0100
> +++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h =A0 =A0 =A0 2010-03=
-10 10:24:03.000000000 +0100
> @@ -47,6 +47,7 @@ struct i2c_algo_bit_data {
> =A0 =A0 =A0 =A0int timeout; =A0 =A0 =A0 =A0 =A0 =A0/* in jiffies */
> =A0};
>
> +int i2c_bit_prepare_bus(struct i2c_adapter *);
> =A0int i2c_bit_add_bus(struct i2c_adapter *);
> =A0int i2c_bit_add_numbered_bus(struct i2c_adapter *);
>
>
> With this possibility, I guess you wouldn't even need the first patch
> any longer? If both are needed, that's fine with me, but if only one =
is
> needed, that's even better.
>
>> I've attached the patches for reference.
>
> Please let me know if either or both of my 2 proposals above fit your
> needs.

I tested the second patch with a trivial patch to the radeon drm:

--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -892,9 +892,9 @@ struct radeon_i2c_chan *radeon_i2c_create(struct
drm_device *dev,
         * make this, 2 jiffies is a lot more reliable */
        i2c->algo.radeon.bit_data.timeout =3D 2;
        i2c->algo.radeon.bit_data.data =3D i2c;
-       ret =3D i2c_bit_add_bus(&i2c->algo.radeon.bit_adapter);
+       ret =3D i2c_bit_prepare_bus(&i2c->algo.radeon.bit_adapter);
        if (ret) {
-               DRM_ERROR("Failed to register internal bit i2c %s\n", n=
ame);
+               DRM_ERROR("Failed to prepare internal bit i2c %s\n", na=
me);
                goto out_free;
        }
        /* set the radeon i2c adapter */

However, just calling i2c_bit_prepare_bus does not appear to be
enough. as I get the following oops:

[ 1443.236030] BUG: unable to handle kernel NULL pointer dereference at=
 (null)
[ 1443.236125] IP: [<ffffffff8139913d>] __mutex_lock_slowpath+0xad/0x18=
0
[ 1443.236192] PGD 677cd067 PUD 68d2c067 PMD 0
[ 1443.236306] Oops: 0002 [#1] SMP
[ 1443.236392] last sysfs file:
/sys/devices/platform/radeon_cp.0/firmware/radeon_cp.0/loading
[ 1443.236429] CPU 0
[ 1443.236486] Modules linked in: radeon(+) ttm drm_kms_helper drm
cfbcopyarea i2c_algo_bit i2c_core cfbimgblt cfbfillrect binfmt_misc
ipv6 powernow_k8 cpufreq_stats cpufreq_conservative cpufreq_userspace
cpufreq_ondemand freq_table cpufreq_powersave video output container
power_meter pci_slot fan sbs acpi_pad sbshc battery iptable_filter
ip_tables x_tables ac sbp2 fuse snd_hda_codec_atihdmi
snd_hda_codec_realtek snd_pcm_oss snd_hda_intel snd_hda_codec
snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss usbhid snd_seq_midi
hid snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device
amd64_edac_mod snd ehci_hcd ohci_hcd ohci1394 pata_acpi pcspkr
edac_core soundcore snd_page_alloc evdev ata_generic usbcore sg r8169
mii ieee1394 thermal button processor [last unloaded: cfbfillrect]
[ 1443.238565] Pid: 16998, comm: work_for_cpu Not tainted 2.6.32 #252
System Product Name
[ 1443.238602] RIP: 0010:[<ffffffff8139913d>]  [<ffffffff8139913d>]
__mutex_lock_slowpath+0xad/0x180
[ 1443.238669] RSP: 0018:ffff880068e75b00  EFLAGS: 00010246
[ 1443.238702] RAX: ffff880068e75b10 RBX: ffff88006769ea24 RCX: 0000000=
000007e40
[ 1443.238736] RDX: 0000000000000000 RSI: ffff880068e75cd0 RDI: ffff880=
06769ea24
[ 1443.238770] RBP: ffff880068e75b60 R08: 0000000000000000 R09: 0000000=
000000400
[ 1443.238804] R10: 000000000000000a R11: 0000000000000000 R12: ffff880=
06769ea20
[ 1443.238837] R13: ffff88006769ea38 R14: ffff88006769ea28 R15: 0000000=
000000000
[ 1443.238871] FS:  00007f69514f36e0(0000) GS:ffff880001a00000(0000)
knlGS:0000000000000000
[ 1443.238908] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 1443.238941] CR2: 0000000000000000 CR3: 000000006610f000 CR4: 0000000=
0000006f0
[ 1443.238974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 1443.239008] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 1443.239043] Process work_for_cpu (pid: 16998, threadinfo
ffff880068e74000, task ffff880065f65b40)
[ 1443.239079] Stack:
[ 1443.239109]  ffff880068e75fd8 ffff880065f65b40 ffff88006769ea28
ffffffff811fe7b8
[ 1443.239225] <0> 0000003000000020 ffff880068e75c00 ffff880068e75b40
ffff88006769ea20
[ 1443.239395] <0> 0000000000000002 00000000ffffffa1 ffff880068e75cd0
0000000000000002
[ 1443.239595] Call Trace:
[ 1443.239630]  [<ffffffff811fe7b8>] ? sprintf+0x68/0x70
[ 1443.239665]  [<ffffffff81399066>] mutex_lock+0x26/0x50
[ 1443.239701]  [<ffffffffa0182638>] i2c_transfer+0xe8/0xf0 [i2c_core]
[ 1443.239763]  [<ffffffffa04e94c5>] radeon_sw_i2c_xfer+0x45/0x70 [rade=
on]
[ 1443.239818]  [<ffffffffa04e957e>] radeon_i2c_xfer+0x8e/0x16e0 [radeo=
n]
[ 1443.239855]  [<ffffffffa0182604>] i2c_transfer+0xb4/0xf0 [i2c_core]
[ 1443.239901]  [<ffffffffa048d148>] drm_do_probe_ddc_edid+0x48/0x60 [d=
rm]
[ 1443.239943]  [<ffffffffa048e128>] drm_ddc_read_edid+0x38/0xb0 [drm]
[ 1443.239984]  [<ffffffffa048e23a>] drm_get_edid+0x9a/0x180 [drm]
[ 1443.240006]  [<ffffffffa04e6cd4>] radeon_modeset_init+0x494/0x7b0 [r=
adeon]
[ 1443.240006]  [<ffffffffa051b9c0>] ? r600_init+0x220/0x390 [radeon]
[ 1443.240006]  [<ffffffffa04c625d>] radeon_driver_load_kms+0xdd/0x1b0 =
[radeon]
[ 1443.240006]  [<ffffffffa048388a>] drm_get_dev+0x35a/0x500 [drm]
[ 1443.240006]  [<ffffffff810748f0>] ? do_work_for_cpu+0x0/0x30
[ 1443.240006]  [<ffffffffa053778e>] radeon_pci_probe+0x10/0x263 [radeo=
n]
[ 1443.240006]  [<ffffffff8120f4c2>] local_pci_probe+0x12/0x20
[ 1443.240006]  [<ffffffff81074903>] do_work_for_cpu+0x13/0x30
[ 1443.240006]  [<ffffffff810748f0>] ? do_work_for_cpu+0x0/0x30
[ 1443.240006]  [<ffffffff810787ce>] kthread+0x8e/0xa0
[ 1443.240006]  [<ffffffff81012faa>] child_rip+0xa/0x20
[ 1443.240006]  [<ffffffff81078740>] ? kthread+0x0/0xa0
[ 1443.240006]  [<ffffffff81012fa0>] ? child_rip+0x0/0x20
[ 1443.240006] Code: a8 83 78 20 63 7f b7 49 8d 5c 24 04 4d 8d 74 24
08 48 89 df e8 25 14 00 00 49 8b 54 24 10 48 8d 45 b0 4c 89 75 b0 49
89 44 24 10 <48> 89 02 48 8b 45 a8 48 89 55 b8 48 c7 c2 ff ff ff ff 48
89 45
[ 1443.241788] RIP  [<ffffffff8139913d>] __mutex_lock_slowpath+0xad/0x1=
80
[ 1443.241788]  RSP <ffff880068e75b00>
[ 1443.241788] CR2: 0000000000000000
[ 1443.242594] ---[ end trace af8d6cef4b61feb3 ]---


Alex
