From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i915 and boot freeze
Date: Tue, 24 May 2011 09:30:51 +0200
Message-ID: <20110524093051.5682e769@endymion.delvare>
References: <BANLkTimZC9vOUu8On5DHkz5qxo8EfLKYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimZC9vOUu8On5DHkz5qxo8EfLKYYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yermandu Patapitafious <yermandu.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Yermandu,

Please pay attention when writing and proofread yourself before
sending. You certainly meant i915, not i195, in the subject line. I've
fixed it. This is important if you want to get the attention of the
relevant maintainers and developers.

On Mon, 23 May 2011 19:33:15 -0300, Yermandu Patapitafious wrote:
> since kernel .39 i can not boot, when kernel go to gmbus start the issue.
> I try capture a dump with kexec, but no success, so i have the idea to
> make video booting,
> kernel version 2.6.39-02745-g0b26d47 and 2.6.39 vanilla same problem.

What is the last kernel that works for you?

Are you running self-built or distribution kernels?

Can we please see the kernel configuration file? You seem to have
verbose debugging options enabled (CONFIG_DEBUG_KOBJECT at least.) it
makes the logs harder to read.

> http://www.vimeo.com/24138372

Unfortunately the beginning is pretty hard to read. It would be great
if you were able to get us the kernel logs in a text form, using some
form of serial console.

I see references to i2c_for_each_dev, a new function which only i2c-dev
and i2c-core are using at the moment. So if you have CONFIG_I2C_CHARDEV
set, and this is a self-built kernel, try again without it just to get
it out of the picture.

Note that logs from a pure 2.6.39 kernel would probably be more useful
than from a later git snapshot. The 2.6.40 development branch is very
young and could have other problems.

Alternatively, if you are familiar with git, a git bisection would help
too.

-- 
Jean Delvare
