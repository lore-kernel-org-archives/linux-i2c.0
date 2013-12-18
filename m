From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 04/13] i2c: isch: Use devm_request_region()
Date: Wed, 18 Dec 2013 07:39:32 +0100
Message-ID: <20131218073932.14810fca@endymion.delvare>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
	<002801cefaf4$69243d70$3b6cb850$%han@samsung.com>
	<20131217085309.1459ea27@endymion.delvare>
	<007401cefb92$6f521390$4df63ab0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <007401cefb92$6f521390$4df63ab0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 18 Dec 2013 10:42:39 +0900, Jingoo Han wrote:
> On Tuesday, December 17, 2013 4:53 PM, Jean Delvare wrote:
> > On Tue, 17 Dec 2013 15:51:28 +0900, Jingoo Han wrote:
> > > Use devm_request_region() to make cleanup paths simpler.
> > 
> > You need to include <linux/ioport.h> for this function.
> 
> According to the i2c tree, <linux/ioport.h> is already included. :-)
> 
> ./ drivers/i2c/busses/i2c-isch.c
> #include <linux/module.h>
> #include <linux/platform_device.h>
> #include <linux/kernel.h>
> #include <linux/delay.h>
> #include <linux/stddef.h>
> #include <linux/ioport.h>      <-- Here!

Oops, you're right, don't know how I managed to miss it, sorry.

-- 
Jean Delvare
