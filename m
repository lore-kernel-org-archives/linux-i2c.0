From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [wsa:i2c/quirks 7/11] drivers/i2c/busses/i2c-axxia.c:452:27:
 sparse: symbol 'axxia_i2c_quirks' was not declared. Should it be static?
Date: Thu, 8 Jan 2015 13:51:37 -0800
Message-ID: <20150108215137.GA11727@wfg-t540p.sh.intel.com>
References: <201501090118.jHaamxHl%fengguang.wu@intel.com>
 <20150108182847.GA29629@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150108182847.GA29629@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Jan 08, 2015 at 07:28:48PM +0100, Wolfram Sang wrote:
> On Fri, Jan 09, 2015 at 01:57:37AM +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/quirks
> > head:   b1d39af8ae21f4930854b0656aa83a83fd38049e
> > commit: 70181ecd2990326a91edb3dac1db4cce21e561f7 [7/11] i2c: axxia: make use of the new infrastructure for quirks
> > reproduce:
> >   # apt-get install sparse
> >   git checkout 70181ecd2990326a91edb3dac1db4cce21e561f7
> >   make ARCH=x86_64 allmodconfig
> >   make C=1 CF=-D__CHECK_ENDIAN__
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> drivers/i2c/busses/i2c-axxia.c:452:27: sparse: symbol 'axxia_i2c_quirks' was not declared. Should it be static?
> > 
> > Please review and possibly fold the followup patch.
> 
> Yes, it should be static.
> 
> However, this is a development branch and in this case it would be
> enough if the test results would be directed to me only.

It's normally private emails, except for the ones that carry patches
with them. In which case public mailing lists will also be CCed.

> Is there a way to achieve this? I know that adding "experimental" to the
> branch name will skip the testing. Is there another pattern to prevent
> sending mails to everyone?

I wonder if the occasional public emails are acceptable to you. If
not, it'd be trivial for me to add a list of "personal git trees"
where all emails including the auto generated patches will be kept
private (if commit author == committer).

Thanks,
Fengguang
