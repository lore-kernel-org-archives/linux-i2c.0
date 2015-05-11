From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
Date: Tue, 12 May 2015 09:26:43 +1000
Message-ID: <1431386803.13039.30.camel@kernel.crashing.org>
References: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
	 <20150510183431.GA1510@katana>
	 <1431296087.13039.13.camel@kernel.crashing.org>
	 <20150511073428.GA3110@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150511073428.GA3110-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2015-05-11 at 09:34 +0200, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org wrote:
> On Mon, May 11, 2015 at 08:14:47AM +1000, Benjamin Herrenschmidt wrote:
> > On Sun, 2015-05-10 at 20:34 +0200, Wolfram Sang wrote:
> > > Okay, so this patch is bogus. I understand now that onyx uses another
> > > codec than TAS, so this change will regress on other machines.
> > > However,
> > > it shows that this unconditional instantiation of the TAS breaks sound
> > > on Macintoshs which still need non-aoa sound support. I assume there
> > > will be noone in the near future to convert Keywest to AOA, so we'll
> > > need to find a hackish way around this instantiation problem.
> > 
> > Converting the old macs that use TAS shouldn't be *that* hard, main
> > problem is I don't have the hardware to test...
> 
> Dan and Mark (on CC) have been very helpful with testing. Maybe they are
> also in to test "the proper solution"?

Possibly, depends how many machines we can cover. I also have extremely
little time, so I'm not that keen on volunteering :-) I'll *try* to have
a look some time this or next week.

The main problem is the difference in the way the layout of the codec
etc... is reported from the DT by the firmware. Otherwise the HW is the
same between pre-AOA and post-AOA really ...

I do have a bunch of DT snapshots lying around, so I can try to figure
out something.

Dan, Mark, what machine models specifically do you have ? (compatible
property in the DT pls, ie, /proc/device-tree/compatible).

Cheers,
Ben.
