From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 15:23:27 +0200
Message-ID: <20150415132327.GE21491@kroah.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> parport starts using device-model and we now have parport under
> /sys/bus. As the ports are discovered they are added as device under
> /sys/bus/parport. As and when other drivers register new device,
> they will be registered as a subdevice under the relevant parport.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/parport/procfs.c |  15 ++-
>  drivers/parport/share.c  | 236 ++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/parport.h  |  29 +++++-
>  3 files changed, 267 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 3b47080..1ce363b 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -21,6 +21,7 @@
>  #include <linux/parport.h>
>  #include <linux/ctype.h>
>  #include <linux/sysctl.h>
> +#include <linux/device.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -558,8 +559,18 @@ int parport_device_proc_unregister(struct pardevice *device)
>  
>  static int __init parport_default_proc_register(void)
>  {
> +	int ret;
> +
>  	parport_default_sysctl_table.sysctl_header =
>  		register_sysctl_table(parport_default_sysctl_table.dev_dir);
> +	if (!parport_default_sysctl_table.sysctl_header)
> +		return -ENOMEM;
> +	ret = bus_register(&parport_bus_type);
> +	if (ret) {
> +		unregister_sysctl_table(parport_default_sysctl_table.
> +					sysctl_header);
> +		return ret;
> +	}
>  	return 0;
>  }
>  
> @@ -570,6 +581,7 @@ static void __exit parport_default_proc_unregister(void)
>  					sysctl_header);
>  		parport_default_sysctl_table.sysctl_header = NULL;
>  	}
> +	bus_unregister(&parport_bus_type);
>  }
>  
>  #else /* no sysctl or no procfs*/
> @@ -596,11 +608,12 @@ int parport_device_proc_unregister(struct pardevice *device)
>  
>  static int __init parport_default_proc_register (void)
>  {
> -	return 0;
> +	return bus_register(&parport_bus_type);
>  }
>  
>  static void __exit parport_default_proc_unregister (void)
>  {
> +	bus_unregister(&parport_bus_type);
>  }
>  #endif

Don't bury bus register/unregister down in proc file creation, it's hard
to review and justify.

greg k-h
