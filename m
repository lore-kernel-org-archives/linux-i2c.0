From: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Thu, 16 Jul 2009 16:22:44 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE40144F1E816@dlee06.ent.ti.com>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	<20090707231938.GA9907@fluff.org.uk>
	<87skh79uai.fsf@deeprootsystems.com>
	<A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
	<1247642943.5981.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1247642943.5981.76.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Philby,

I tried running this patch against 2.6.31.rc2 (davinci kernel tree). But I =
got a crash as I run the application which is given below....

In my case, time out happens when I kill the capture application using Cntr=
l-C. After Cnrtl-C, the mt9t031 i2c device couldn't be contacted by the hos=
t (during cleanup, i2c commands fails). When the application is run again, =
I get following outputs..

i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: timeout waiting for bus ready

Here are the complete log....

application running and pressed Cntrl-C =3D=3D=3D=3D>

time:105    frame:33
time:105    frame:34vpfe-capture vpfe-capture: stream off failed in subdev

Running it again .....

root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git# ./fbdev_loopback -i2 -d0
main : Enter
initializing capture device
setting data format
input.name =3D Composite
input.name =3D S-Video
input.name =3D Camera
Calling S_INPUT with index =3D 2
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
vpfe-capture vpfe-capture: fh->io_allowed
Error:InitDevice:ioctl:VIDIOC_S_INPUT
: Bad address
Error in setting capture format
Failed to intialize capture
start_streaming:ioctl:VIDIOC_STREAMOFF:
main : Leave
root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git#
root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git#
root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git#
root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git# ./fbdev_loopback -i2 -d0
main : Enter
initializing capture device
setting data format
input.name =3D Composite
input.name =3D S-Video
input.name =3D Camera
Calling S_INPUT with index =3D 2
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: timeout waiting for bus ready
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:83 gpio_ensure_requested+0x5c/0x128()
autorequest GPIO-15
Modules linked in:
Backtrace:
[<c002b7a8>] (dump_backtrace+0x0/0x114) from [<c024d970>] (dump_stack+0x18/=
0x1c)
 r7:c73b1be8 r6:c0159d94 r5:c02cd20d r4:00000053
[<c024d958>] (dump_stack+0x0/0x1c) from [<c003c690>] (warn_slowpath_common+=
0x50/
0x68)
[<c003c640>] (warn_slowpath_common+0x0/0x68) from [<c003c6f4>] (warn_slowpa=
th_fm
t+0x30/0x38)
 r7:00000000 r6:c031ca08 r5:c033b1b4 r4:c031ca08
[<c003c6c4>] (warn_slowpath_fmt+0x0/0x38) from [<c0159d94>] (gpio_ensure_re=
quest
ed+0x5c/0x128)
 r3:0000000f r2:c02cd224
[<c0159d38>] (gpio_ensure_requested+0x0/0x128) from [<c015a028>] (gpio_dire=
ction
_input+0x80/0x140)
 r9:c6c892dc r8:c033b1b4 r7:c73b1cc4 r6:0000000f r5:60000093
r4:c031ca08
[<c0159fa8>] (gpio_direction_input+0x0/0x140) from [<c019fcf4>] (disable_i2=
c_pin
s+0x34/0x6c)
 r9:c6c892dc r8:00000001 r7:c73b1cc4 r6:ffffb774 r5:c031cb68
r4:40000013
[<c019fcc0>] (disable_i2c_pins+0x0/0x6c) from [<c019ff90>] (i2c_davinci_xfe=
r+0xf
c/0x3f0)
 r5:00000000 r4:c6c41800
[<c019fe94>] (i2c_davinci_xfer+0x0/0x3f0) from [<c019d484>] (i2c_transfer+0=
xa4/0
xfc)
[<c019d3e0>] (i2c_transfer+0x0/0xfc) from [<c0033064>] (dm355evm_enable_i2c=
_swit
ch+0x6c/0x80)
[<c0032ff8>] (dm355evm_enable_i2c_switch+0x0/0x80) from [<c00330b4>] (dm355=
evm_s
etup_video_input+0x3c/0x54)
 r5:c6c89000 r4:00000000
[<c0033078>] (dm355evm_setup_video_input+0x0/0x54) from [<c01bba00>] (vpfe_=
s_inp
ut+0xcc/0x284)
[<c01bb934>] (vpfe_s_input+0x0/0x284) from [<c01aeaf0>] (__video_do_ioctl+0=
x19d8
/0x3374)
[<c01ad118>] (__video_do_ioctl+0x0/0x3374) from [<c01b0774>] (video_ioctl2+=
0x2e8
/0x434)
[<c01b048c>] (video_ioctl2+0x0/0x434) from [<c01ac2f8>] (v4l2_unlocked_ioct=
l+0x4
0/0x44)
[<c01ac2b8>] (v4l2_unlocked_ioctl+0x0/0x44) from [<c00a2568>] (vfs_ioctl+0x=
34/0x
94)
 r7:c734d280 r6:c0045627 r5:bec58ac8 r4:c734d280
[<c00a2534>] (vfs_ioctl+0x0/0x94) from [<c00a2c2c>] (do_vfs_ioctl+0x56c/0x5=
c8)
 r7:c734d280 r6:00000004 r5:c734d280 r4:c73b4bf8
[<c00a26c0>] (do_vfs_ioctl+0x0/0x5c8) from [<c00a2cc8>] (sys_ioctl+0x40/0x6=
4)
[<c00a2c88>] (sys_ioctl+0x0/0x64) from [<c0027ea0>] (ret_fast_syscall+0x0/0=
x2c)
 r7:00000036 r6:00000000 r5:00000000 r4:40024db0
---[ end trace 21b642dbca792ce4 ]---
------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:83 gpio_ensure_requested+0x5c/0x128()
autorequest GPIO-14
Modules linked in:
Backtrace:
[<c002b7a8>] (dump_backtrace+0x0/0x114) from [<c024d970>] (dump_stack+0x18/=
0x1c)
 r7:c73b1be8 r6:c0159d94 r5:c02cd20d r4:00000053
[<c024d958>] (dump_stack+0x0/0x1c) from [<c003c690>] (warn_slowpath_common+=
0x50/
0x68)
[<c003c640>] (warn_slowpath_common+0x0/0x68) from [<c003c6f4>] (warn_slowpa=
th_fm
t+0x30/0x38)
 r7:00000000 r6:c031ca08 r5:c033b1a8 r4:c031ca08
[<c003c6c4>] (warn_slowpath_fmt+0x0/0x38) from [<c0159d94>] (gpio_ensure_re=
quest
ed+0x5c/0x128)
 r3:0000000e r2:c02cd224
[<c0159d38>] (gpio_ensure_requested+0x0/0x128) from [<c0159ee4>] (gpio_dire=
ction
_output+0x84/0x148)
 r9:c6c892dc r8:c033b1a8 r7:c73b1cc4 r6:0000000e r5:60000093
r4:c031ca08
[<c0159e60>] (gpio_direction_output+0x0/0x148) from [<c019fd00>] (disable_i=
2c_pi
ns+0x40/0x6c)
[<c019fcc0>] (disable_i2c_pins+0x0/0x6c) from [<c019ff90>] (i2c_davinci_xfe=
r+0xf
c/0x3f0)
 r5:00000000 r4:c6c41800
[<c019fe94>] (i2c_davinci_xfer+0x0/0x3f0) from [<c019d484>] (i2c_transfer+0=
xa4/0
xfc)
[<c019d3e0>] (i2c_transfer+0x0/0xfc) from [<c0033064>] (dm355evm_enable_i2c=
_swit
ch+0x6c/0x80)
[<c0032ff8>] (dm355evm_enable_i2c_switch+0x0/0x80) from [<c00330b4>] (dm355=
evm_s
etup_video_input+0x3c/0x54)
 r5:c6c89000 r4:00000000
[<c0033078>] (dm355evm_setup_video_input+0x0/0x54) from [<c01bba00>] (vpfe_=
s_inp
ut+0xcc/0x284)
[<c01bb934>] (vpfe_s_input+0x0/0x284) from [<c01aeaf0>] (__video_do_ioctl+0=
x19d8
/0x3374)
[<c01ad118>] (__video_do_ioctl+0x0/0x3374) from [<c01b0774>] (video_ioctl2+=
0x2e8
/0x434)
[<c01b048c>] (video_ioctl2+0x0/0x434) from [<c01ac2f8>] (v4l2_unlocked_ioct=
l+0x4
0/0x44)
[<c01ac2b8>] (v4l2_unlocked_ioctl+0x0/0x44) from [<c00a2568>] (vfs_ioctl+0x=
34/0x
94)
 r7:c734d280 r6:c0045627 r5:bec58ac8 r4:c734d280
[<c00a2534>] (vfs_ioctl+0x0/0x94) from [<c00a2c2c>] (do_vfs_ioctl+0x56c/0x5=
c8)
 r7:c734d280 r6:00000004 r5:c734d280 r4:c73b4bf8
[<c00a26c0>] (do_vfs_ioctl+0x0/0x5c8) from [<c00a2cc8>] (sys_ioctl+0x40/0x6=
4)
[<c00a2c88>] (sys_ioctl+0x0/0x64) from [<c0027ea0>] (ret_fast_syscall+0x0/0=
x2c)
 r7:00000036 r6:00000000 r5:00000000 r4:40024db0
---[ end trace 21b642dbca792ce5 ]---
vpfe-capture vpfe-capture: width =3D 1, height =3D 1, bpp =3D 1
InitDevice:ioctlvpfe-capture vpfe-capture: adjusted width =3D 32, height =
=3D 1, bpp
=3D 1, bytesperline =3D 32, sizeimage =3D 32
:VIDIOC_S_INPUT,vpfe-capture vpfe-capture: width =3D 32768, height =3D 3276=
8, bpp =3D
1
 selected input vpfe-capture vpfe-capture: adjusted width =3D 2048, height =
=3D 1536,
 bpp =3D 1, bytesperline =3D 2048, sizeimage =3D 3145728
index =3D 2
InitDvpfe-capture vpfe-capture: width =3D 1280, height =3D 720, bpp =3D 1
evice:ioctl:VIDIvpfe-capture vpfe-capture: adjusted width =3D 1280, height =
=3D 720,
bpp =3D 1, bytesperline =3D 1280, sizeimage =3D 921600
OC_G_INPUT, selected input, Camera
Following standards available at the input
InitDevice:ioctl:VIDIOC_CROPCAP
Default crop capbility bounds - 34054 1073858848 0 0 ; default - 1073945068=
 3375
6 1 1
set_datvpfe-capture vpfe-capture: stream on failed in subdev
a_format:setting data format
Available image formats at the capture driver :-
fmt_desc.index =3D 0
fmt_desc.type =3D 1
fmt_desc.description =3D Bayer GrRBGb 8bit A-Law compr.
fmt_desc.pixelformat =3D 31384142
fmt_desc.index =3D 1
fmt_desc.type =3D 1
fmt_desc.description =3D Bayer GrRBGb - 16bit
fmt_desc.pixelformat =3D 32525942
*******TRY_FMT (Min resolution) values before calling ioctl*************
fmt.fmt.pix.width =3D 1
fmt.fmt.pix.height =3D 1
fmt.fmt.pix.field=3D 0
fmt.fmt.pix.bytesperline =3D 0
fmt.fmt.pix.sizeimage =3D 0
*******TRY_FMT values after calling ioctl*************
fmt.fmt.pix.width =3D 32
fmt.fmt.pix.height =3D 1
fmt.fmt.pix.field=3D 1
fmt.fmt.pix.bytesperline =3D 32
fmt.fmt.pix.sizeimage =3D 32
*******TRY_FMT (Max resolution) values before calling ioctl*************
fmt.fmt.pix.width =3D 32768
fmt.fmt.pix.height =3D 32768
fmt.fmt.pix.field=3D 0
fmt.fmt.pix.bytesperline =3D 0
fmt.fmt.pix.sizeimage =3D 0
*******TRY_FMT values after calling ioctl*************
fmt.fmt.pix.width =3D 2048
fmt.fmt.pix.height =3D 1536
fmt.fmt.pix.field=3D 1
fmt.fmt.pix.bytesperline =3D 2048
fmt.fmt.pix.sizeimage =3D 3145728
set_data_format:ioctl:VIDIOC_S_FMT
set_data_format:finally negotiated width:1280 height:720
set_data_format:driver reports bytes_per_line:1280(bug)
set_data_format:driver reports size:921600(bug)
set_data_format:Finally negotiated width:1280 height:720
initializing capture buffers
device buffers:3
buffer:0 phy:0 mmap:0x4013f000 length:831488
buffer:1 phy:cb000 mmap:0x4020a000 length:831488
buffer:2 phy:196000 mmap:0x402d5000 length:831488
initializing display device
Queing buffer:0
Queing buffer:1
Queing buffer:2
start_streaming:ioctl:VIDIOC_STREAMON:
vpbe_UE_1 : Enter
Starting loop..........


root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git# ./fbdev_loopback -i2 -d0
main : Enter
vpfe-capture vpfe-capture: width =3D 1, height =3D 1, bpp =3D 1
initializing capvpfe-capture vpfe-capture: adjusted width =3D 32, height =
=3D 1, bpp
=3D 1, bytesperline =3D 32, sizeimage =3D 32
ture device
setvpfe-capture vpfe-capture: width =3D 32768, height =3D 32768, bpp =3D 1
ting data formatvpfe-capture vpfe-capture: adjusted width =3D 2048, height =
=3D 1536,
 bpp =3D 1, bytesperline =3D 2048, sizeimage =3D 3145728

input.name =3D Cvpfe-capture vpfe-capture: width =3D 1280, height =3D 720, =
bpp =3D 1
omposite
input.vpfe-capture vpfe-capture: adjusted width =3D 1280, height =3D 720, b=
pp =3D 1, b
ytesperline =3D 1280, sizeimage =3D 921600
name =3D S-Video
input.name =3D Camera
Calling S_INPUT with index =3D 2
InitDevice:ioctl:VIDIOC_S_INPUT, selected input index =3D 2
InitDevice:ioctl:VIDIOC_G_INPUT, selected input, Camera
Following standards avavpfe-capture vpfe-capture: stream on failed in subde=
v
ilable at the input
InitDevice:ioctl:VIDIOC_CROPCAP
Default crop capbility bounds - 34054 1073858848 0 0 ; default - 1073945068=
 3375
6 1 1
set_data_format:setting data format
Available image formats at the capture driver :-
fmt_desc.index =3D 0
fmt_desc.type =3D 1
fmt_desc.description =3D Bayer GrRBGb 8bit A-Law compr.
fmt_desc.pixelformat =3D 31384142
fmt_desc.index =3D 1
fmt_desc.type =3D 1
fmt_desc.description =3D Bayer GrRBGb - 16bit
fmt_desc.pixelformat =3D 32525942
*******TRY_FMT (Min resolution) values before calling ioctl*************
fmt.fmt.pix.width =3D 1
fmt.fmt.pix.height =3D 1
fmt.fmt.pix.field=3D 0
fmt.fmt.pix.bytesperline =3D 0
fmt.fmt.pix.sizeimage =3D 0
*******TRY_FMT values after calling ioctl*************
fmt.fmt.pix.width =3D 32
fmt.fmt.pix.height =3D 1
fmt.fmt.pix.field=3D 1
fmt.fmt.pix.bytesperline =3D 32
fmt.fmt.pix.sizeimage =3D 32
*******TRY_FMT (Max resolution) values before calling ioctl*************
fmt.fmt.pix.width =3D 32768
fmt.fmt.pix.height =3D 32768
fmt.fmt.pix.field=3D 0
fmt.fmt.pix.bytesperline =3D 0
fmt.fmt.pix.sizeimage =3D 0
*******TRY_FMT values after calling ioctl*************
fmt.fmt.pix.width =3D 2048
fmt.fmt.pix.height =3D 1536
fmt.fmt.pix.field=3D 1
fmt.fmt.pix.bytesperline =3D 2048
fmt.fmt.pix.sizeimage =3D 3145728
set_data_format:ioctl:VIDIOC_S_FMT
set_data_format:finally negotiated width:1280 height:720
set_data_format:driver reports bytes_per_line:1280(bug)
set_data_format:driver reports size:921600(bug)
set_data_format:Finally negotiated width:1280 height:720
initializing capture buffers
device buffers:3
buffer:0 phy:0 mmap:0x4013f000 length:831488
buffer:1 phy:cb000 mmap:0x4020a000 length:831488
buffer:2 phy:196000 mmap:0x402d5000 length:831488
initializing display device
Queing buffer:0
Queing buffer:1
Queing buffer:2
start_streaming:ioctl:VIDIOC_STREAMON:
vpbe_UE_1 : Enter
Starting loop..........

Murali Karicheri
Software Design Engineer
Texas Instruments Inc.
Germantown, MD 20874
Phone : 301-515-3736
email: m-karicheri2-l0cyMroinI0@public.gmane.org

>-----Original Message-----
>From: Philby John [mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org]
>Sent: Wednesday, July 15, 2009 3:29 AM
>To: Karicheri, Muralidharan
>Cc: Kevin Hilman; Ben Dooks; davinci-linux-open-
>source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
>
>Hello Murali,
>
>       I will send a patch out to address this problem.
>
>Regards,
>Philby
>
>
>On Wed, 2009-07-08 at 10:25 -0500, Karicheri, Muralidharan wrote:
>> Hi Kevin,
>>
>> When we do a video loopback with MT9T031, we get i2c timeouts when
>application is killed using Cntrl C. Is it being addressed in any of the
>patches?  We had the same issue with TI LSP releases (1.20, 2.00, 2.1o etc=
).
>> The board has to be rebooted to recover from this.
>>
>> Murali Karicheri
>> Software Design Engineer
>> Texas Instruments Inc.
>> Germantown, MD 20874
>> Phone : 301-515-3736
>> email: m-karicheri2-l0cyMroinI0@public.gmane.org
>>
>> >-----Original Message-----
>> >From: davinci-linux-open-source-bounces+m-
>> >karicheri2=3Dti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org [mailto:davinci-linux-open-
>source-
>> >bounces+m-karicheri2=3Dti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf Of Kevin
>Hilman
>> >Sent: Wednesday, July 08, 2009 9:30 AM
>> >To: Ben Dooks
>> >Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-
>> >i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >Subject: Re: [PATCH 0/2] davinci i2c fixes for 2.6.31
>> >
>> >Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:
>> >
>> >> On Mon, Jul 06, 2009 at 03:48:34PM -0700, Kevin Hilman wrote:
>> >>> Here are a couple fixes for the i2c driver on the TI DaVinci family
>> >>> of SoCs.  These have been tested for awhile in the DaVinci git
>> >>> repo are needed for 2.6.31.
>> >>>
>> >>> These apply on v2.6.31-rc2.
>> >>
>> >> ok, do you have a git branch to pull, or should I apply
>> >> them from the mailing list>
>> >
>> >You can take from the list.  My git branch has a bunch of other
>> >non-i2c changes in it as well.
>> >
>> >Thanks,
>> >
>> >Kevin
>> >
>> >>> David Brownell (1):
>> >>>   i2c-davinci: behave with i2cdetect
>> >>>
>> >>> Kevin Hilman (1):
>> >>>   i2c-davinci: convert clock usage after clkdev conversion
>> >>>
>> >>>  drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++++-----
>> >>>  1 files changed, 15 insertions(+), 5 deletions(-)
>> >>>
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"
>in
>> >>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >> --
>> >> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>> >>
>> >>   'a smiley only costs 4 bytes'
>> >
>> >_______________________________________________
>> >Davinci-linux-open-source mailing list
>> >Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> >http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>
