From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: RFC: Working around dynamic device allocation in i2c.  Interaction with other subystems.
Date: Mon, 19 Jan 2009 19:37:05 +0000
Message-ID: <20090119193704.GA16803@sirena.org.uk>
References: <4974D20F.20209@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4974D20F.20209-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 19, 2009 at 07:18:39PM +0000, Jonathan Cameron wrote:

> 1) Relax the constraints that the token used for device identification
>    in subsystems using the regulators approach to a void * and use
>    the platform data pointer of an i2c device.  Note this requires
>    every device which may need a regulator to have platform data.
>    Whilst this would work, it is far from ideal.

This would also remove the ability of the APIs using this to use the
struct device for other things like showing what they're doing in sysfs
or use dev_printk.
