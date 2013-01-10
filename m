From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-nforce2: fix coding style issues
Date: Thu, 10 Jan 2013 10:21:48 +0100
Message-ID: <20130110102148.3260760e@endymion.delvare>
References: <1357764624-32134-1-git-send-email-laurent.navet@gmail.com>
	<20130110093255.5353fb31@endymion.delvare>
	<CAH7P7NjdKsWjttmWyKxttm=rJDAErZxe7+Zf_oaSCx6Pmc1GWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH7P7NjdKsWjttmWyKxttm=rJDAErZxe7+Zf_oaSCx6Pmc1GWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Jan 2013 09:52:36 +0100, Laurent Navet wrote:
> Hi Jean,
> 
> >
> > Unfortunately your patch also add one new checkpatch.pl warning:
> >
> > WARNING: line over 80 characters
> > #245: FILE: drivers/i2c/busses/i2c-nforce2.c:272:
> > +		data->word = inb_p(NVIDIA_SMB_DATA) | (inb_p(NVIDIA_SMB_DATA + 1) << 8);
> >
> > Please fix.
> >
> > As mentioned previously, __devinit has been dropped meanwhile, so this
> > change doesn't apply cleanly. Please rebase your patch on top of kernel
> > 3.8-rc3 (or Wolfram's i2c tree) so that Wolfram can apply it.
> >
> > All the rest looks very good now, thanks for the good work.
> 
> I've worked and tested against git.pengutronix.de wsa/linux.git
> ( http://git.pengutronix.de/?p=wsa/linux.git;a=summary )
> Isnt' it the right one ?

Only if you use branch i2c-embedded/for-next of that repository.
Otherwise you're lacking the patch which removed the __dev* markers.

Wolfram, it would be great if you could update your tree to avoid that
kind of issue.

-- 
Jean Delvare
