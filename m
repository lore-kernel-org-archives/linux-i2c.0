From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] I2C driver of Topcliff PCH
Date: Tue, 20 Jul 2010 11:29:52 +0200
Message-ID: <201007201129.53110.arnd@arndb.de>
References: <4C204B0D.2030201@dsn.okisemi.com> <201007152135.00280.arnd@arndb.de> <000601cb27e4$3768c170$66f8800a@maildom.okisemi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000601cb27e4$3768c170$66f8800a-a06+6cuVnkTSQfdrb5gaxUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masayuki Ohtake <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Wang, Yong Y" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 20 July 2010, Masayuki Ohtake wrote:
> > > @@ -147,6 +148,11 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
> > >  if (tmp == NULL)
> > >  return -ENOMEM;
> > >
> > > + if (copy_from_user(tmp, buf, count)) {
> > > + kfree(tmp);
> > > + return -EFAULT;
> > > + }
> > > +
> > >  pr_debug("i2c-dev: i2c-%d reading %zu bytes.\n",
> > >  iminor(file->f_path.dentry->d_inode), count);
> >
> >
> > A read function should not do copy_from_user, only copy_to_user.
> > If you are worried about returning invalid data from kernel space,
> > better use kzalloc instead of kmalloc to get the buffer.
> 
> Our I2C HW has special mode.
> To control the mode, our i2c driver has copy_from_user.

That is a highly unusual interface and I would definitely not recommend doing
this. Please use an ioctl operation for anything that has both input and output
data.

	Arnd
