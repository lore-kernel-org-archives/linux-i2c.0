From: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Thu, 20 Mar 2014 12:12:23 -0400
Message-ID: <532B1367.8050906@yahoo.com>
References: <532A1B12.8080400@yahoo.com> <1511928.3cA2QKoAZt@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511928.3cA2QKoAZt@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

First of all, thank you so much for your detailed explanation. This really helps 
out a lot.

Your assumptions are correct, I am needed working on an ARM device and it uses 
device tree for driver configuration.

Just to confirm that I understand you correctly, what you're saying is that the 
platform_data and the device tree configuration mechanisms have an exclusive-or 
relationship, at least when it comes down to an individual driver, is that 
correct? And, if there is no platform_data provided, it is perfectly permissible 
for the probe function of the driver to make call to of_* functions to read its 
configuration? Provided that the kernel has Open Firmware and Device Tree 
support enabled of course.

Would it also acceptable for a driver's probe function to allocate memory for a 
platform_data instance and use the platform_data member in client->dev to store 
a pointer to it if no previous platform_data is available from the 
i2c_board_info configuration mechanism? Again provided of course that the memory 
is freed and the platform_data member in client->dev set back to null in the 
remove function of the driver.

Thank you,
Frank

On 19/03/14 08:10 PM, Laurent Pinchart wrote:

> You're looking at two different configuration mechanisms, which probably
> explains your confusion.
>
> Platform data is the oldest mechanism used to pass configuration information
> to the driver. This is largely used through the Linux kernel on a wide range
> of architectures. The idea is to store device-specific configuration
> information in board files (as you mentioned DT I'll assume you're working on
> ARM, so that would be arch/arm/mach-*/board-*.c) using driver-specific
> structures and associate those structures with devices. Drivers can then
> retrieve the platform data at probe time and configure the device accordingly.
>
> The way platform data is associated with devices depends on the bus type. For
> I2C the i2c_board_info structure, used to instantiate I2C devices in board
> code, has a void *platform_data field that can be set to point to a platform
> data structure. You can find an example of this in the i2c3_devices array in
> arch/arm/mach-shmobile/board-kzm9g.c.
>
> Device tree (DT) is a newer mechanism to specify hardware configuration.
> Instead of relying on C board files that contain a mix a code and data, the
> platform is described in a tree-like structure of devices with properties
> associated to all those devices. That structure is called the device tree and
> is compiled as a binary that gets passed to the kernel at boot time. When
> using the device tree, drivers don't receive platform data anymore but are
> responsible for parsing the content of the device tree to read platform-
> specific hardware configuration information. The content of device tree nodes
> is defined in documents called DT bindings that can be found in
> Documentation/devicetree/bindings/ (i2c/i2c-mux-pca954x.txt in this case).
>
> A NULL platform_data pointer can then mean either that your platform boots
> using the device tree, or that the board file doesn't specify any platform
> data for the device in case of legacy (non-DT) boot. There's also a hybrid
> method that can be used to associated platform data declared in C files to DT
> nodes, but that's for special cases only and shouldn't be used for the
> pca954x.
>
> This being said, if your platform uses the device tree, you shouldn't (in
> theory at least) need static I2C bus numbers. This is why there is no DT
> property similar to the platform data adap_id field defined in the pca954x DT
> bindings.
