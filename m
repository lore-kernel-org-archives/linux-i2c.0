From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i915 and boot freeze
Date: Fri, 27 May 2011 11:31:06 +0200
Message-ID: <20110527113106.56c7d755@endymion.delvare>
References: <BANLkTimZC9vOUu8On5DHkz5qxo8EfLKYYQ@mail.gmail.com>
	<20110524093051.5682e769@endymion.delvare>
	<BANLkTime7ZT2UEeG=T=JqZKZBYa77fi0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTime7ZT2UEeG=T=JqZKZBYa77fi0_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yermandu Patapitafious <yermandu.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 May 2011 10:38:59 -0300, Yermandu Patapitafious wrote:
> Hello Jean,
> 
> Thanks for answer, i will take more atention in subjects,
> 
> > What is the last kernel that works for you?
> >
> > Are you running self-built or distribution kernels?
> > Can we please see the kernel configuration file?
> 
> My Last kernel working from git repository was 2.6.38-rc8+, the stable
> line .38.X work fines.

OK, this is good, it means the bisection domain isn't too big.

Can you remember if you made any kernel configuration change between
2.6.38 and 2.6.39?

> I use the git version from kernel.org site pull and build manually be
> me. The Latest Stable Kernel is from gentoo-sources, and i always
> compile manually too.
> I have attached .config kernel in mail.

I see you have many debug options enabled. I suggest you try building a
kernel without these and see if it makes a difference.

> > It would be great
> > if you were able to get us the kernel logs in a text form, using some
> > form of serial console.
> 
> Removing the CONFIG_I2C_CHARDEV has not effect, the panic continues
> happing I looking for some way to send panic log in text, but no
> success yet.

If you can't get a serial console to capture the complete error log,
the other approach is to bisect between kernels 2.6.38 and 2.6.39, to
find the faulty commit. If you're used to building your kernel
yourself, it shouldn't be too difficult. Just clone Linus' kernel tree
and follow the git bisect manual page:
http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html

-- 
Jean Delvare
