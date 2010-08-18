From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-tools: do not fail opening bus if /dev/i2c is not a
 directory
Date: Wed, 18 Aug 2010 14:43:29 +0200
Message-ID: <20100818144329.50711481@hyperion.delvare>
References: <201008181433.50995.ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201008181433.50995.ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Florian,

On Wed, 18 Aug 2010 14:33:50 +0200, Florian Fainelli wrote:
> In case /dev/i2c is not a directory, open_i2c_dev will fail opening
> /dev/i2c/<i2cbus> but only handles the ENOENT errno, while we should also
> handle ENOTDIR errno because this is the returned error code. The patch
> attached fixes the issue.

This is better discussed on the linux-i2c list. Redirecting...

> Signed-off-by: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
> --
> Index: tools/i2cbusses.c
> ===================================================================
> --- tools/.svn/text-base/i2cbusses.c.svn-base	2010-08-18 14:22:18.000000000 +0200
> +++ /tmp/tempfile.2.tmp	2010-08-18 14:33:12.000000000 +0200

What a ugly header. How am I supposed to apply this?

> @@ -378,7 +378,7 @@
>  	sprintf(filename, "/dev/i2c/%d", i2cbus);
>  	file = open(filename, O_RDWR);
>  
> -	if (file < 0 && errno == ENOENT) {
> +	if (file < 0 && (errno == ENOENT || errno == ENOTDIR)) {
>  		sprintf(filename, "/dev/i2c-%d", i2cbus);
>  		file = open(filename, O_RDWR);
>  	}
> 

I've never seen the case where /dev/i2c exists but isn't a directory
(which is why that case isn't handled.) How did you get in this
situation? It doesn't make much sense IMHO.

That being said, we can certainly apply your patch if it makes you
happy, I don't see it as being terribly useful, but it also shouldn't
hurt.

-- 
Jean Delvare
