From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [alsa-devel] [RFC] sound: ppc: keywest: check if DEQ was already
 instantiated
Date: Mon, 1 Jun 2015 08:30:19 +0900
Message-ID: <20150531233018.GC17187@katana>
References: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
 <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
 <s5htwuxb1h4.wl-tiwai@suse.de>
 <20150529105020.GB3168@katana>
 <s5hsiaf6489.wl-tiwai@suse.de>
 <20150529110559.GB4282@katana>
 <s5hoal3621l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hoal3621l.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 29, 2015 at 01:44:38PM +0200, Takashi Iwai wrote:
> At Fri, 29 May 2015 20:06:09 +0900,
> Wolfram Sang wrote:
> > 
> > > Do you think from which stable kernel version can this be applied?
> > 
> > The offending commit is 3a3dd0186f619b74e61e6f29dddcaf59af7d3cac
> > ("i2c/powermac: Improve detection of devices from device-tree") which
> > came in with v3.6 if I read correctly.
> 
> OK, thanks!

Just to make sure: Keep in mind that it depends on "sound: ppc: keywest:
drop using attach adapter" which needs to go to stable, then, too.
