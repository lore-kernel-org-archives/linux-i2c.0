From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Thu, 20 Mar 2014 01:10:02 +0100
Message-ID: <1511928.3cA2QKoAZt@avalon>
References: <532A1B12.8080400@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532A1B12.8080400-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Wednesday 19 March 2014 18:32:50 Frank Bormann wrote:
> Hi Everyone,
> 
> I am looking at the i2c_pca954x i2c bus mux driver in linux-stable. My goal
> is to have the slave buses show up in Linux with static bus numbers.
> Ideally, I want to define the first bus number to use in the dtb.
> 
> It seems, the driver has already some support for static bus numbers as its
> probe function checks for the existence of a struct pca954x_platform_data
> instance in client->dev.platform_data and pca954x_platform_mode struct it
> points to has a member adap_id that seems to be doing exactly that judging
> by its documentation. However, calls made to pca954x_probe always have to
> platform_data pointer being passed in through client set to null.
> 
> In addition to that, the recent addition to the driver of a reset gpio to be
> configured reads directly from the dtb in the probe function.
> 
> I am unsure about how to set this up properly. On one hand, platform_data is
> being passed in to the probe function, which seem to indicate, there may be
> some generic place in the i2c core code to set driver-specific
> configuration, on the other hand, the recent reset gpio addition to the
> driver seems to indicate that the driver's probe function is in fact the
> right place to read additional configuration from the dtb.
> 
> Any help is greatly appreciated.

You're looking at two different configuration mechanisms, which probably 
explains your confusion.

Platform data is the oldest mechanism used to pass configuration information 
to the driver. This is largely used through the Linux kernel on a wide range 
of architectures. The idea is to store device-specific configuration 
information in board files (as you mentioned DT I'll assume you're working on 
ARM, so that would be arch/arm/mach-*/board-*.c) using driver-specific 
structures and associate those structures with devices. Drivers can then 
retrieve the platform data at probe time and configure the device accordingly.

The way platform data is associated with devices depends on the bus type. For 
I2C the i2c_board_info structure, used to instantiate I2C devices in board 
code, has a void *platform_data field that can be set to point to a platform 
data structure. You can find an example of this in the i2c3_devices array in 
arch/arm/mach-shmobile/board-kzm9g.c.

Device tree (DT) is a newer mechanism to specify hardware configuration. 
Instead of relying on C board files that contain a mix a code and data, the 
platform is described in a tree-like structure of devices with properties 
associated to all those devices. That structure is called the device tree and 
is compiled as a binary that gets passed to the kernel at boot time. When 
using the device tree, drivers don't receive platform data anymore but are 
responsible for parsing the content of the device tree to read platform-
specific hardware configuration information. The content of device tree nodes 
is defined in documents called DT bindings that can be found in 
Documentation/devicetree/bindings/ (i2c/i2c-mux-pca954x.txt in this case).

A NULL platform_data pointer can then mean either that your platform boots 
using the device tree, or that the board file doesn't specify any platform 
data for the device in case of legacy (non-DT) boot. There's also a hybrid 
method that can be used to associated platform data declared in C files to DT 
nodes, but that's for special cases only and shouldn't be used for the 
pca954x.

This being said, if your platform uses the device tree, you shouldn't (in 
theory at least) need static I2C bus numbers. This is why there is no DT 
property similar to the platform data adap_id field defined in the pca954x DT 
bindings.

-- 
Regards,

Laurent Pinchart
