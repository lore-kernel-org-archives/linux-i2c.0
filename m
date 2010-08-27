From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers/misc/akm8975: Add compass sensor driver
Date: Fri, 27 Aug 2010 00:24:39 -0700
Message-ID: <20100827002439.8e8df11b.akpm@linux-foundation.org>
References: <1282872717-12228-1-git-send-email-achew@nvidia.com>
	<20100827091607.1bb889f2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100827091607.1bb889f2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Aug 2010 09:16:07 +0200 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> > +static int akm_aot_open(struct inode *inode, struct file *file)
> > +{
> > +	int ret = -1;
> 
> Useless and dangerous initialization.
> 
> > +
> > +	FUNCDBG("called");
> > +	if (atomic_cmpxchg(&open_flag, 0, 1) == 0) {
> > +		wake_up(&open_wq);
> > +		ret = 0;

this doesn't do anything either.

> > +	}
> > +
> > +	ret = nonseekable_open(inode, file);
> > +	if (ret)
> > +		return ret;
> > +
> > +	file->private_data = akmd_data;
> > +
> > +	return ret;
> > +}
